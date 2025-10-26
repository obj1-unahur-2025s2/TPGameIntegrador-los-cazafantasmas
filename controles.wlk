//controles generales de todo el juego
import wollok.game.*
import fantasma.*
import personas.*
///robado para poder armar el movimiento
object controles{
	method configurarTeclas(){
	keyboard.w().onPressDo({ arriba.moverseAProximaPosicion(fantasma.position()) })
	keyboard.s().onPressDo({ abajo.moverseAProximaPosicion(fantasma.position()) })
	keyboard.a().onPressDo({ izquierda.moverseAProximaPosicion(fantasma.position()) })
	keyboard.d().onPressDo({ derecha.moverseAProximaPosicion(fantasma.position()) })
	keyboard.e().onPressDo({ fantasma.asustar() })
	}
/*
	keyboard.1().onPressDo({ nivelFacil.configurate() })
	keyboard.2().onPressDo({ nivelDificil.configurate() })
*/
}

 class Direccion {
	
	const property posicionesInvalidas=[game.at(0,37),game.at(0,38),game.at(0,12),game.at(0,5),game.at(23,5),game.at(6,27),game.at(13,27)]
	method siguiente(position)

	method esIgual(unaDireccion) = unaDireccion == self

	/*method moverseAProximaPosicion(posicion) {
		const siguientePosicion = game.getObjectsIn(self.siguiente(posicion))
		if (siguientePosicion.isEmpty() && !self.estaEnElBorde(siguientePosicion)) {
			fantasma.position(self.siguiente(posicion))}
		else{
			fantasma.position(posicion) 
		}
	
	}*/
	/* Próxima posición en un tablero al estilo "pacman" */
	method moverseAProximaPosicion(posicion) {
		const siguientePosicion = self.siguiente(posicion)
		if (!posicionesInvalidas.contains(siguientePosicion)&& !self.estaEnElBorde(siguientePosicion)) {
			fantasma.position(siguientePosicion)
		}
		
	}

	method estaEnElBorde(posicion){
		const sonBordes=[self.esBordeDerecho(posicion), self.esBordeIzquierdo(posicion),self.esBordeInferior(posicion),self.esBordeSuperior(posicion)]
		return sonBordes.any({b=> b})
	}

	method esBordeDerecho(posicion) = game.width() -1 == posicion.x() 

	method esBordeIzquierdo(posicion) = posicion.x() == -1

	method esBordeInferior(posicion) = posicion.y() == -1

	// Toma en cuenta la franja reservada para los indicadores
	method esBordeSuperior(posicion) = game.height() == posicion.y()+1

}

object izquierda inherits Direccion {

	override method siguiente(position) = position.left(1)

	method opuesto() = derecha
}

object derecha inherits Direccion {

	override method siguiente(position) = position.right(1)

	method opuesto() = izquierda
}
object posicionInvalida inherits Direccion {
	override method siguiente(position){

	}
	method posicionInvalida(){
		return posicionesInvalidas
	}
}

object abajo inherits Direccion {

	override method siguiente(position) = position.down(1)

	method opuesto() = arriba
}

object arriba inherits Direccion {

	override method siguiente(position) = position.up(1)

	method opuesto() = abajo
}

/*
//para poder cancelar las posiciones del nivel
object utilidadesParaJuego {

	method posicionArbitraria() { // Delimita el rango aleatorio dejando una celda de margen para que los bloques no aparzcan pegados a la pared
		return game.at(1.randomUpTo(game.width() - 2).truncate(0), 1.randomUpTo(game.height() - 2).truncate(0))
	}

	method sePuedeMover(posicion) {
		return posicion.x().between(0, game.width() - 1) and posicion.y().between(0, game.height() - 1)
	}

	method eliminarVisual(visual) {
		if(game.hasVisual(visual)) {
			game.removeVisual(visual)
		}
	}
}
*/