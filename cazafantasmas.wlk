import controles.*
import wollok.game.*
import fantasma.*

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
		jugador.modificarPuntos(self.puntaje())
	}
	
	method puntaje() = -300
	

	/*method acercarseA(personaje) {
		const otroPosicion = personaje.position()
		var newX = position.x() + if (otroPosicion.x() > position.x()) 1 else -1
		var newY = position.y() + if (otroPosicion.y() > position.y()) 1 else -1
		// evitamos que se posicionen fuera del tablero
		newX = innewX.max(0).min(game.width() - 1)
		newY = newY.max(0).min(game.height() - 1)
		previousPosition = position
		position = game.at(newX, newY)
	}*/

	method acercarseA(jugador) {//deberia acercarse a la posicion del jugador y no salirse del mapa
		game.onTick(1000,"cazador",
			{ const x = self.acercarseHorizontalA(jugador)
			  const y = self.acercarseVerticalA(jugador)
			  if(invalida.noEsPosicionInvalida(x, y)){
				position = game.at(x,y) 
			  }
			}
		)
	}
	method accionarObjeto(objeto){
		
	}
	
	method acercarseHorizontalA(jugador) = if (self.estaALaIzquierdaDe(jugador))self.position().x() + 1
	                                       else self.position().x() - 1
	
	method acercarseVerticalA(jugador) = if (self.estaAbajoDe(jugador))self.position().y() + 1
	                                     else self.position().y() - 1
	
	method estaALaIzquierdaDe(unElemento) = unElemento.position().x() > self.position().x()
	
	method estaAbajoDe(unElemento) = unElemento.position().y() > self.position().y()
}