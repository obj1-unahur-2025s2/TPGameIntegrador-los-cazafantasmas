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
    estadoJuego.cambiarNivelActual("")
    grimly.resetPosition()
    game.removeTickEvent("cazador")
    posicionesInvalidas.cargarInicio()
    controles.configurarTeclas()
    game.addVisual(fondoEmpezar)
    game.addVisual(grimly)
    musica.configurar()
    musica.empezarMusicaInicio()
  }
}

object musica {
  const property musicaInicio = game.sound("musicaInicio.wav")
  const property musicaJuego = game.sound("musicaFondo.mp3")

  var configurada = false
  // Inicializamos con el objeto nulo
  var sonidoActual = musicaNula 

  method configurar() {
  // Es crucial que la configuración se haga *después* de que se obtienen los sonidos.
    if (not configurada) {
        musicaInicio.shouldLoop(true)
        musicaInicio.volume(0.20)
        musicaJuego.shouldLoop(true)
        musicaJuego.volume(0.10)
        configurada = true
    }
  }

  method cambiarASonido(nuevoSonido) {
    if (sonidoActual != nuevoSonido) {
    // 1. Detener el sonido actual. Si es 'musicaNula', el método .stop() no hace nada.
        sonidoActual.stop()
    // 2. Actualizar el estado y empezar el nuevo sonido.
        sonidoActual = nuevoSonido
        sonidoActual.play()
    }   
  }

  method empezarMusicaInicio() {
    self.cambiarASonido(musicaInicio)
  }

  method empezarMusicaJuego() {
    self.cambiarASonido(musicaJuego)
  }

  method pararMusica(unSonido) {
    if (sonidoActual == unSonido) {
   // Detener la música y volver al estado Nulo.
        unSonido.stop()
        sonidoActual = musicaNula
    }
  }

  method pararMusicaInicio() {
    self.pararMusica(musicaInicio)
  }

  method pararMusicaJuego() {
    self.pararMusica(musicaJuego)
  }
}

object musicaNula {
// Implementa los métodos que llamarás en 'sonidoActual'
  method stop() {} 
  method play() {}
  method shouldLoop(loop) {} // No hace nada
  method volume(vol) {} // No hace nada
}


// objeto musica como estaba antes 
/*object musica {
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
*/


