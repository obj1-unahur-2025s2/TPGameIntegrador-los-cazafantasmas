import controles.*
import wollok.game.*
import fantasma.*

//los cazafantasmas que van a ser enemigos
class Cazafantasma {
	var property position = game.at(0, 0)
	var image = "cazafantasmas.png"
	
	method esInteractivo() = true//el jugador puede interactuar (osea pueden colisionar)
	
	method image() = image
	
	method image(nueva) {
		image = nueva
	}
	
	method position() = position
	
	method position(nueva) {
		position = nueva
	}
	
	method asustarse(jugador) {
		
	}
	
	method instanciar(posicion,cantidad) {//crea al cazador
		self.image("cazafantasmas.png")
		self.position(posicion)
	}
	
	method atrapar(jugador) {
		jugador.recibirDaño()
		jugador.modificarPuntos(self.puntaje())
	}
	
	method puntaje() = -300

    method acercarseA(jugador) {
        // Inicia el ciclo de persecución automático (ejecutando la lógica cada 500ms).
        game.onTick(500, "cazador", { self.intentarMoverseHacia(jugador) })
    }

    method intentarMoverseHacia(jugador) {
        // 1. Calcula la diferencia absoluta para decidir qué eje priorizar.
        const diferenciaX = (self.position().x() - jugador.position().x()).abs()
        
        // 2. Ejecuta la lógica de Respaldo: Prioridad X o Y.
        if (diferenciaX > (self.position().y() - jugador.position().y()).abs()) {
            // Prioridad X (eje más lejano o igual)
            self.ejecutarMovimientoConRespaldo(
                self.proximaPosicionHorizontal(jugador),
                self.proximaPosicionVertical(jugador) 
            )
        } else {
            // Prioridad Y (eje más cercano)
            self.ejecutarMovimientoConRespaldo(
                self.proximaPosicionVertical(jugador), 
                self.proximaPosicionHorizontal(jugador) 
            )
        }
    }

    method ejecutarMovimientoConRespaldo(intentoPrincipal, intentoRespaldo) {
        // Intenta el movimiento principal y usa el auxiliar para saber si tuvo éxito.
        const movio = self.intentarMover(intentoPrincipal)
        
        // Si el intento principal falla, intenta el movimiento de respaldo.
        if (!movio) {
            self.intentarMover(intentoRespaldo)
        }
    }

    method intentarMover(nuevaPosicion) {
        // Almacena el resultado de la validación.
        const esValida = invalida.noEsPosicionInvalida(nuevaPosicion.x(), nuevaPosicion.y())
        
        // Si es válida, aplica el movimiento.
        if (esValida) {
            self.position(nuevaPosicion) 
        }
        
        // Devuelve el estado de la validación.
        return esValida 
    }

    method proximaPosicionHorizontal(unElemento) = 
        // Mueve a la derecha si la X del elemento es mayor, si no, a la izquierda.
        if (unElemento.position().x() > self.position().x()) 
            self.position().right(1)
        else 
            self.position().left(1)

    method proximaPosicionVertical(unElemento) = 
        // Mueve arriba si la Y del elemento es mayor, si no, abajo.
        if (unElemento.position().y() > self.position().y()) 
            self.position().up(1)
        else 
            self.position().down(1)
    method accionarObjeto(objeto){}
}