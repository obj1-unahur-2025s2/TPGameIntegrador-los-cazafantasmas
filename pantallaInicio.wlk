import wollok.game.*
import niveles.*
import fantasma.*
import personas.*
import cazafantasmas.*
import puntaje.*
import cosas.*
import items.*
import controles.*
import nivel1.*
import nivel2.*

//configuracion de la pantalla de inicio antes de elegir el nivel
object pantallaInicio {

// La pantalla de configuración inicial
	const fondoEmpezar = new Fondo(image = "fondoInicio.jpg") 
	
	method configurate() {
		game.addVisual(fondoEmpezar)
		game.addVisual(grimly)
		controles.configurarTeclas()
		keyboard.space().onPressDo({ game.addVisual(fondoEmpezar)
			game.schedule(2000, { game.stop()})
		})
		//musica.empezarMusicaInicio()
		//musica.pararMusicaJuego()
		
	}

}

object musica {
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
  }
}

