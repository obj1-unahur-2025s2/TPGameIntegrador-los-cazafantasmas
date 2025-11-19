import nivel1.*
import wollok.game.*
import fantasma.*
import personas.*
import cazafantasmas.*
import puntaje.*
import items.*
import controles.*
import pantallaInicio.*
class Nivel {
  var property elementosEnNivel = [] // Lista de elementos recolectables interactivos, excepto enemigos
  var nivelActual= ""
  method nivelActual()= nivelActual
  method cambiarNivelActual(nuevoNivel){
    nivelActual= nuevoNivel
  }
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
    game.clear()
	  musica.pararMusicaInicio()
	  musica.empezarMusicaJuego()
    game.removeTickEvent("cazador")
    posicionesInvalidas.cargarNiveles()
	  controles.configurarTeclas()
    
	
	// El sonido para que esté accesible desde todos los niveles
	/*keyboard.plusKey().onPressDo({ musicaDeFondo.volume(1)})
	keyboard.m().onPressDo({musicaDeFondo.volume(0)})
	keyboard.minusKey().onPressDo({ musicaDeFondo.volume(0.5)})
	keyboard.p().onPressDo({ musicaDeFondo.pause()})
	keyboard.r().onPressDo({ musicaDeFondo.resume()})
	keyboard.s().onPressDo({ musicaDeFondo.stop()})*/
	}
}


object estadoJuego {
    var nivelActual = "" // aca guardaremos el nivelActual

    method nivelActual() = nivelActual
    
    method cambiarNivelActual(nuevoNivel) {
        nivelActual = nuevoNivel
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

object gameOver {
    
    method perder() {
        //Limpiamos todo el juego actual
        game.clear()
        const musicaDerrota=game.sound("musicaDerrota.mp3")
        musica.pararMusicaJuego()
        musicaDerrota.volume(0.20)
        musicaDerrota.play()
        
        // primera imagen que se muestra en pantalla
        const fondoVisual = new Fondo(image = "derrota_1.jpg") 
        game.addVisual(fondoVisual)

        // Variable contador para saber que numero de imagen toca
        var numeroImagen = 1 

        game.onTick(800, "animacionDerrota", { 
            
            numeroImagen += 1 
            
            if (numeroImagen > 2) { 
                numeroImagen = 1 
            }

            // Cambiamos la imagen del visual
            fondoVisual.image("derrota_" + numeroImagen.toString() + ".jpg")
        })
      
        // --- Finaliza a los seg y vuelve al inicio
        game.schedule(14000, { 
            
            game.removeTickEvent("animacionDerrota")
            pantallaInicio.configurate()
        })
        
    }
}

object gameWin {
    
    method ganar() {
        //Limpiamos todo el juego actual
        game.clear()
        const musicaVictoria=game.sound("musicaVictoria.mp3")
		musica.pararMusicaJuego()
      	musicaVictoria.volume(0.20)
      	musicaVictoria.play()
        // primera imagen que se muestra en pantalla
        const fondoVisual = new Fondo(image = "victoria_1.jpg") 
        game.addVisual(fondoVisual)

        // Variable contador para saber que numero de imagen toca
        var numeroImagen = 1 

        game.onTick(600, "animacionVictoria", { 
            
            numeroImagen += 1 
            
            if (numeroImagen > 2) { 
                numeroImagen = 1 
            }

            // Cambiamos la imagen del visual
            fondoVisual.image("victoria_" + numeroImagen.toString() + ".jpg")
        })
       

        // --- Finaliza a los seg y vuelve al inicio
        game.schedule(14000, { 

            game.removeTickEvent("animacionVictoria")
            pantallaInicio.configurate()
        })
    }
}

class Fondo {

	const property position = game.at(0, 0)
	var property image 

	method esInteractivo() = false
	method asustarse(jugador){}
	method chocarse(jugador){}
    method recibirDaño(){}
    method accionarObjeto(objeto){}
    method atrapar(){}
    
}

class VisualCorazon {
    var property position
    var property image 
}

