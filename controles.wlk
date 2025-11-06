import pantallaInicio.*
//controles generales de todo el juego
import wollok.game.*
import fantasma.*
import personas.*
import niveles.*
import nivel1.*
import nivel2.*
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
		keyboard.num1().onPressDo({ nivel1.configurate() })
		keyboard.num2().onPressDo({ nivel2.configurate() })
	}

}

class Direccion {
	//lista que deberia cargarse con las posiciones de los muebles y paredes
	const property posicionesInvalidas = [
		game.at(0, 7),
		game.at(0, 8),
		game.at(0, 9),
		game.at(0, 10),
		game.at(0, 11),
		game.at(0, 12),
		game.at(0, 13),
		game.at(1, 7),
		game.at(2, 7),
		game.at(5, 7),
		game.at(6, 7),
		game.at(7, 7),
		game.at(7, 8),
		game.at(7, 9),
		game.at(7, 10),
		game.at(7, 11),
		game.at(7, 12),
		game.at(7, 13),
		game.at(7, 14),
		game.at(7, 15),
		game.at(1, 14),
		game.at(2, 14),
		game.at(3, 14),
		game.at(4, 14),
		game.at(5, 14),
		game.at(6, 14),
		game.at(10, 8),
		game.at(10, 9),
		game.at(10, 10),
		game.at(10, 11),
		game.at(10, 12),
		game.at(10, 13),
		game.at(10, 14),
		game.at(10, 15),
		game.at(11, 8),
		game.at(12, 8),
		game.at(15, 8),
		game.at(16, 8),
		game.at(17, 8),
		game.at(17, 9),
		game.at(17, 10),
		game.at(17, 11),
		game.at(17, 12),
		game.at(17, 13),
		game.at(17, 14),
		game.at(17, 15),
		game.at(11, 14),
		game.at(12, 14),
		game.at(13, 14),
		game.at(14, 14),
		game.at(15, 14),
		game.at(16, 14),
		game.at(17, 14),
		game.at(20, 0),
		game.at(21, 0),
		game.at(22, 0),
		game.at(23, 0),
		game.at(24, 0),
 		game.at(25, 0),
		game.at(26, 0),
		game.at(27, 0),
		game.at(28, 0),
		game.at(29, 0),
		game.at(20, 1),
		game.at(20, 2),
		game.at(20, 3),
		game.at(20, 4),
		game.at(20, 7),
		game.at(20, 8),
		game.at(20, 9),
		game.at(20, 10),
		game.at(21, 10),
		game.at(22, 10),
		game.at(23, 10),
		game.at(24, 10),
		game.at(25, 10),
		game.at(26, 10),
		game.at(27, 10),
		game.at(28, 10),
		game.at(29, 10),
		game.at(21, 9),
		game.at(22, 9),
		game.at(23, 9),
		game.at(24, 9),
		game.at(25, 9),
		game.at(26, 9),
		game.at(27, 9),
		game.at(28, 9),
		game.at(29, 9),
		game.at(29, 9),
		game.at(29, 0),
		game.at(29, 1),
		game.at(29, 2),
		game.at(29, 3),
		game.at(29, 4),
		game.at(29, 5),
		game.at(29, 6),
		game.at(29, 7),
		game.at(29, 8),
		game.at(29, 9)
		

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