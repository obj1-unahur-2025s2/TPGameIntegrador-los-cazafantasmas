import puntaje.*
import controles.*
import wollok.game.*
import fantasma.*
import niveles.*


//los cazafantasmas que van a ser enemigos
class Cazafantasma {
	var position = game.at(0, 0)
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
		puntaje.puntosCazador()
        if(self.position()== game.at(14, 0) ){   //si el cazador esta en la posicion inicial del fantasma, retrocede 3 celdas
            self.position(game.at(14, 3))
        }
	}
	
	method accionarObjeto(objeto) {}
    method recibirDaño() {}
    method acercarseA(jugador) {
        // Inicia el ciclo de persecución automático (ejecutando la lógica cada 500ms).
        game.onTick(600, "cazador", { self.intentarMoverseHacia(jugador) })
        
    }

    method intentarMoverseHacia(jugador) {
        // Calcula la diferencia absoluta para decidir qué eje priorizar.
        const diferenciaX = (self.position().x() - jugador.position().x()).abs()
        const diferenciaY = (self.position().y() - jugador.position().y()).abs()

        // Prioriza el eje donde la diferencia es mayor.
        if (diferenciaX > diferenciaY) {
            self.intentarMover(self.proximaPosicionHorizontal(jugador))
        } else {
            self.intentarMover(self.proximaPosicionVertical(jugador))
        }
    }

    method intentarMover(nuevaPosicion) {
        const esValida = invalida.noEsPosicionInvalida(nuevaPosicion.x(), nuevaPosicion.y())

        if (esValida) {
            self.position(nuevaPosicion)
        }

        return esValida
    }

    method proximaPosicionHorizontal(unElemento) =
        if (unElemento.position().x() > self.position().x()) 
            self.position().right(1)
        else 
            self.position().left(1)

    method proximaPosicionVertical(unElemento) =
        if (unElemento.position().y() > self.position().y()) 
            self.position().up(1)
        else 
            self.position().down(1)
}