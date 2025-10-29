import controles.*
import wollok.game.*
import fantasma.*

//los cazafantasmas que van a ser enemigos
class Cazafantasma {
	var position = game.at(0, 0)
	var posicionInicial = game.at(0, 0)
	var image = ""
	
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
	
	method instanciar(posicion) {//crea al cazador
		self.image("cazafantasmas.png")
		self.position(posicion)
		posicionInicial = posicion //se define en donde se coloca por primera vez
	}
	
	method chocarse(jugador) {
		jugador.recibirDaño()
		self.resetPosition()
		jugador.modificarPuntos(self.puntaje())
	}
	
	method puntaje() = -300
	
	method acercarseA(jugador) {//deberia acercarse a la posicion del jugador y no salirse del mapa
		game.onTick(1500,"cazador",
			{ position = { position = new Position(
						x = self.acercarseHorizontalA(jugador),
						y = self.acercarseVerticalA(jugador)
						) } 
			}
		)
	}
	
	method resetPosition() {
		position = posicionInicial
	}
	
	method acercarseHorizontalA(jugador) = if (self.estaALaIzquierdaDe(jugador))izquierda.moverseAProximaPosicion(self.position())
	                                       else derecha.moverseAProximaPosicion(self.position())
	
	method acercarseVerticalA(jugador) = if (self.estaAbajoDe(jugador))abajo.moverseAProximaPosicion(self.position())
	                                     else arriba.moverseAProximaPosicion(self.position())
	
	method estaALaIzquierdaDe(unElemento) = unElemento.position().x() > self.position().x()
	
	method estaAbajoDe(unElemento) = unElemento.position().y() > self.position().y()
}