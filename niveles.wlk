//niveles del juego
import wollok.game.*
import fantasma.*
import personas.*
import cazafantasmas.*
import puntaje.*
import cosas.*
import items.*
import controles.*
import pantallaInicio.*
class Nivel {
  var property elementosEnNivel = [] // Lista de elementos recolectables interactivos, excepto enemigos
  method hayElementoEn(posicion) = elementosEnNivel.any({ e => e.position() == posicion && e.esInteractivo() })
									

  method ponerElementos(cantidad, elemento) { // debe recibir cantidad y EL NOMBRE DE UN ELEMENTO
	if (cantidad > 0) {
		const unaPosicion = elegirPosicion.posicionAleatoria()
			if (not self.hayElementoEn(unaPosicion)) { // si la posicion no está ocupada
				const unaInstancia = elemento.get(cantidad-1) // instancia el elemento en una posicion
					elementosEnNivel.add(unaInstancia) // Agrega el elemento a la lista
					game.addVisual(unaInstancia) // Agrega el elemento al tablero
					unaInstancia.instanciar(unaPosicion, cantidad)
					self.ponerElementos(cantidad - 1, elemento) // llamada recursiva al proximo elemento a agregar
			} else { // Si había elementos, hace llamada recursiva
					self.ponerElementos(cantidad, elemento)
			}
		}
  }


  method configurate() {
	musica.pararMusicaInicio()
	musica.empezarMusicaJuego()
	

	controles.configurarTeclas()
	casa.crearCasa()
	// El sonido para que esté accesible desde todos los niveles
	/*keyboard.plusKey().onPressDo({ musicaDeFondo.volume(1)})
	keyboard.m().onPressDo({musicaDeFondo.volume(0)})
	keyboard.minusKey().onPressDo({ musicaDeFondo.volume(0.5)})
	keyboard.p().onPressDo({ musicaDeFondo.pause()})
	keyboard.r().onPressDo({ musicaDeFondo.resume()})
	keyboard.s().onPressDo({ musicaDeFondo.stop()})*/
	}

	method ganar() {
		// sonido al ganar el juego
		game.sound("audio/ganarNivel3.mp3").play()
	     
		game.clear()
		game.addVisual(pantallaVic.victoria())
			// después de un ratito ...
		game.schedule(4000, { // Volver al inicio 
		pantallaInicio.configurate()})

		// si todos NO están visibles y grimly está vivo entonces ganar, si no perder(o porque grimly se murió o porque hay personas vivas).
	}

	
}

object pantallaVic{
	var num=1
	method victoria(){
		
		game.onTick(200, "victoria", {
			if(num>1){
				num=1
				return new Fondo(image="victoria_1.jpg")
			}
			else{
				num=2
				return new Fondo(image="victoria_2.jpg")
			}
		})
		
	}
}
object elegirPosicion {

  method posicionAleatoria(){//deberia elegir una posicion aleatoria para ponerlo y que no queden uno sobre otro 
    const x = 0.randomUpTo(game.width()-2).truncate(0)
    const y = 2.randomUpTo(game.height()-2).truncate(0)
    if(invalida.noEsPosicionInvalida(x, y) && !game.hasVisual(self)){
      return game.at(x,y)
    }
    else{
      return self.posicionAleatoria()
    }
  }
	method eliminarVisual(visual) {
		if(game.hasVisual(visual)) {
			game.removeVisual(visual)
		}
	}
}

/*object gameOver {
	method position() = game.center()
	method image() = "gameover.png"
	method perder() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
			// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image = "imgs/fondo Completo.png"))
			// después de un ratito ...
		game.schedule(1000, { game.clear()
				// cambio de fondo
			game.addVisual(new Fondo(image = "imgs/perdimos.png"))
				// después de un ratito ...
			game.schedule(4000, { // reinicia el juego
			pantallaInicio.configurate()})
		})
	}
}
*/
class Fondo {

	const property position = game.at(0, 0)
	var property image 

	method esInteractivo() = false
	method asustarse(jugador){}
	method chocarse(jugador){}
    method recibirDaño(){}
    method accionarObjeto(objeto){}
    method atrapar(){}
    method modificarPuntos(num){}
}

/*



// configura los niveles de forma general
class Nivel {

	// Elementos del nivel	
	var property elementosEnNivel = [] // Lista de elementos recolectables interactivos, excepto enemigos
	var property enemigosEnTablero = [] // Lista de enemigos interactivos
	// Abstractos

	method personaje()

	method faltanRequisitos()

	method imagenIntermedia()

	method siguienteNivel()

	// Indica si hay elementos interactivo en la posición
	method hayElementoEn(posicion) = elementosEnNivel.any({ e => e.position() == posicion and e.esInteractivo() })

	/* Metodos que tambien interactuan con los movimientos del personaje */

/*




	method terminar() {
		// sonido al ganar el juego
		game.sound("audio/ganarNivel3.mp3").play()
			// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
			// Fondo final
		game.addVisual(new Fondo(image = "imgs/fondo ganaste.png"))
			// después de un ratito ...
		game.schedule(4000, { // Volver al inicio 
		pantallaInicio.configurate()})
	}
*/