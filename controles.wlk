//controles generales de todo el juego
import wollok.game.*
import fantasma.*
import personas.*

///robado para poder armar el movimiento
object controles {
	method configurarTeclas() {
		keyboard.w().onPressDo(
			{ grimly.position(arriba.moverseAProximaPosicion(grimly.position())) }
		)
		keyboard.s().onPressDo(
			{ grimly.position(abajo.moverseAProximaPosicion(grimly.position())) }
		)
		keyboard.a().onPressDo(
			{ grimly.position(izquierda.moverseAProximaPosicion(grimly.position())) }
		)
		keyboard.d().onPressDo(
			{ grimly.position(derecha.moverseAProximaPosicion(grimly.position())) }
		)
		keyboard.e().onPressDo({ grimly.asustar(game.getObjectsIn(grimly.position())) })
	}
/*
	keyboard.1().onPressDo({ nivelFacil.configurate() })//para hacer que se configure el nivel y cargue cuando el jugador lo elige
	keyboard.2().onPressDo({ nivelDificil.configurate() })
*/
	
}

class Direccion {
	//lista que deberia cargarse con las posiciones de los muebles y paredes
	const property posicionesInvalidas = [
		game.at(0, 37),
		game.at(0, 38),
		game.at(0, 12),
		game.at(0, 5),
		game.at(23, 5),
		game.at(6, 27),
		game.at(13, 27)
	]

	method siguiente(position)
	
	method esIgual(unaDireccion) = unaDireccion == self
	/* Próxima posición en un tablero al estilo "pacman" , aplica para el fantasma y los npc */
	
	method moverseAProximaPosicion(posicion) {
		const siguientePosicion = self.siguiente(posicion)
		if ((!posicionesInvalidas.contains(siguientePosicion)) && (!self.estaEnElBorde(siguientePosicion))) {
			return siguientePosicion
		} else {
			return posicion
		}
	}
	
	method estaEnElBorde(posicion) {
		const sonBordes = [
			self.esBordeDerecho(posicion),
			self.esBordeIzquierdo(posicion),
			self.esBordeInferior(posicion),
			self.esBordeSuperior(posicion)
		]
		return sonBordes.any({ b => b })
	}
	
	method esBordeDerecho(posicion) = game.width() == posicion.x()
	
	method esBordeIzquierdo(posicion) = posicion.x() == (-1)
	
	method esBordeInferior(posicion) = posicion.y() == (-1)
	
	// Toma en cuenta la franja reservada para los indicadores
	method esBordeSuperior(posicion) = game.height() == (posicion.y() + 1)
}

object izquierda inherits Direccion {
	override method siguiente(position) = position.left(1)
	
}

object derecha inherits Direccion {
	override method siguiente(position) = position.right(1)
	
}

object abajo inherits Direccion {
	override method siguiente(position) = position.down(1)
	
}

object arriba inherits Direccion {
	override method siguiente(position) = position.up(1)
	
}

object invalida inherits Direccion {
	override method siguiente(position) {
	}
	
	method posicionInvalida() = posicionesInvalidas
	
	method noEsPosicionInvalida(posX, posY) = (!self.posicionInvalida().contains(game.at(posX, posY))) && (!self.estaEnElBorde(game.at(posX, posY)))
}