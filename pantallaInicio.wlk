import wollok.game.*
import niveles.*
import fantasma.*
import personas.*
import cazafantasmas.*
import puntaje.*
import items.*
import controles.*
import nivel1.*
import nivel2.*

//configuracion de la pantalla de inicio antes de elegir el nivel
object pantallaInicio {

  // La pantalla de configuración inicial
  const fondoEmpezar = new Fondo(image = "fondoInicio.jpg") 
  method configurate() {

    game.clear()
    grimly.resetPosition()
    game.removeTickEvent("cazador")
    game.addVisual(fondoEmpezar)
    game.addVisual(grimly)
    controles.configurarTeclas()
    musica.configurar()
    musica.empezarMusicaInicio()
  }
  
}

object musica {
  const property musicaInicio = game.sound("musicaInicio.wav")
  const property musicaJuego = game.sound("musicaFondo.mp3")

  var configurada = false
  var reproduciendoInicio = false
  var reproduciendoJuego = false

  method configurar() {
    if (not configurada) {
      musicaInicio.shouldLoop(true)
      musicaInicio.volume(0.20)
      musicaJuego.shouldLoop(true)
      musicaJuego.volume(0.10)
      configurada = true
    }
  }

  method empezarMusicaInicio() {
    if (reproduciendoJuego) {
      musicaJuego.stop()
      reproduciendoJuego = false
    }
    if (not reproduciendoInicio) {
      musicaInicio.play()
      reproduciendoInicio = true
    }
  }

  method empezarMusicaJuego() {
    if (reproduciendoInicio) {
      musicaInicio.stop()
      reproduciendoInicio = false
    }
    if (not reproduciendoJuego) {
      musicaJuego.play()
      reproduciendoJuego = true
    }
  }

  method pararMusicaInicio() {
    if (reproduciendoInicio) {
      musicaInicio.stop()
      reproduciendoInicio = false
    }
  }

  method pararMusicaJuego() {
    if (reproduciendoJuego) {
      musicaJuego.stop()
      reproduciendoJuego = false
    }
  }
}
// objeto musica como estaba antes
/*object musica {
  method empezarMusicaInicio(){
 	const musicaDeFondo = game.sound("musicaInicio.mp3")
    	musicaDeFondo.shouldLoop(true)
    	musicaDeFondo.volume(0.5)
    	game.schedule(400, { musicaDeFondo.play() })
  }
   method empezarMusicaJuego(){
 	const musicaDeFondo = game.sound("musicaFondo.mp3")
    	musicaDeFondo.shouldLoop(true)
    	musicaDeFondo.volume(0.5)
    	game.schedule(400, { musicaDeFondo.play() })
  }
  method pararMusicaInicio(){
	const musicaDeFondo = game.sound("musicaInicio.mp3")
	musicaDeFondo.stop()
  }
  method pararMusicaJuego(){
	const musicaDeFondo = game.sound("musicaFondo.mp3")
	musicaDeFondo.stop()
  }*/

