import nivel2.*
import nivel1.*
import wollok.game.*
import fantasma.*
import personas.*
import cazafantasmas.*
import puntaje.*
import items.*
import controles.*
import pantallaInicio.*

const gameWin = new GameWin()
const gameOver = new GameOver()

//nivel padre (no se puede instanciar)
class Nivel {
  var property elementosEnNivel = [] // Lista de elementos recolectables interactivos
  const property enemigos = [new Cazafantasma(nivelActual=self),new Cazafantasma(nivelActual=self)]
  const property pociones = [new Pocion(),new Pocion()]
  const property trampas = [new Trampa(),new Trampa(),new Trampa()]

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
  method personas()

  method configurate() { //configura el nivel
    game.clear()
	  musica.pararMusicaInicio()
	  musica.empezarMusicaJuego()
    posicionesInvalidas.cargarNiveles()
	  controles.configurarTeclas()
    self.vaciarListas()
	}
 method chequearCondicionVictoria() {    
			// .all() revisa si TODOS en la lista cumplen la condición
			const todasAsustadas = self.personas().all({ p => p.estaAsustado() })
			if (todasAsustadas) {
      			gameWin.ganar()
				self.personas().forEach({p=>p.dejarEstarAsustado()})
			} 
	}
  method chequearCondicionDerrota() {    
		if(not vidaGrimly.tieneVidas()){
			const sonidoMuerte= game.sound("sonidoMuerte.wav")
			sonidoMuerte.volume(0.10)
			sonidoMuerte.play()
			gameOver.perder()
			self.personas().forEach({p=>p.dejarEstarAsustado()})
    	}
	}
	method cantEnemigos(){//devuelve cuantos enemigos hay
		return enemigos.size()
	}

  method vaciarListas(){
    elementosEnNivel.clear()
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

class TerminarJuego {

  method ejecutarFinal(cancion, volumen, prefijoImagen, tiempoTick, nombreTick) {
    //Limpia todo el juego actual
    game.clear()

		musica.pararMusicaJuego()
		const sonido = game.sound(cancion)
		sonido.volume(volumen)
		sonido.play()

    // primera imagen que se muestra en pantalla
		const fondoVisual = new Fondo(image = prefijoImagen + "1.jpg") 
		game.addVisual(fondoVisual)

    // variable contador para saber que numero de imagen toca
		var numeroImagen = 1

		game.onTick(tiempoTick, nombreTick, {
			numeroImagen += 1 
			if (numeroImagen > 2) numeroImagen = 1
      // cambia la imagen del visual
			fondoVisual.image(prefijoImagen + numeroImagen.toString() + ".jpg")
		})

		puntaje.iniciarBarraDePuntos(puntaje.puntosActuales())
    // finaliza a los segundos y vuelve al inicio
		game.schedule(14000, {
			game.removeTickEvent(nombreTick)
			musica.pararMusica(sonido)
			pantallaInicio.configurate()
		})
  }
}


class GameOver inherits TerminarJuego {
  method perder() {
    self.ejecutarFinal(
      "musicaDerrota.mp3",
      0.30,
      "derrota_",
      800,
      "animacionDerrota"
    )
  }
}

class GameWin inherits TerminarJuego {
  method ganar() {
    self.ejecutarFinal(
      "musicaVictoria2.mp3",
      0.20,
      "victoria_",
      600,
      "animacionVictoria"
    )
  }
}


/*object gameOver {
    
    method perder() {
        //Limpiamos todo el juego actual
        game.clear()
      
        
        const musicaDerrota=game.sound("musicaDerrota.mp3")
        musica.pararMusicaJuego()
        musicaDerrota.volume(0.30)
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
        puntaje.iniciarBarraDePuntos(puntaje.puntosActuales())
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
        const musicaVictoria=game.sound("musicaVictoria2.mp3")
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
        puntaje.iniciarBarraDePuntos(puntaje.puntosActuales())
        // --- Finaliza a los seg y vuelve al inicio
        game.schedule(14000, { 

            game.removeTickEvent("animacionVictoria")
            musica.pararMusica(musicaVictoria)
            pantallaInicio.configurate()
        })
    }
}*/

class Fondo {

	const property position = game.at(0, 0)
	var property image 

	method esInteractivo() = false
	method asustarse(jugador){}
	method chocarse(jugador){}
  method recibirDaño(cant){}
  method accionarObjeto(objeto){}
  method atrapar(){}
    
}
