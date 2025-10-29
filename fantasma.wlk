//el fantasma que controla el jugador
import wollok.game.*
import items.*
import cazafantasmas.*
import personas.*

object grimly {
  var image = "fantasmaNormal.png"
  var position = game.origin()
  var puntaje = 0
  var vida = 3
  
  method resetPosition() {
    position = game.origin()
  }
  
  method vida() = vida
  
  method noTieneMasVidas() = vida == 0
  
  method recibirDaño() {
    vida = (vida - 1).max(0)
    self.resetPosition()
  }
  
  method recuperarVida() {
    vida = (vida + 1).min(3)
  }
  
  method modificarPuntos(num) {
    puntaje = (puntaje + num).max(0)
    //puntaje.actualizarVisual(puntaje) esto es para que se vea en la pantalla el puntaje
  }
  
  method asustar() {
    self.image("fantasma.png")
    game.onCollideDo(self, { p => p.asustarse(self) })
    game.schedule(400, { self.image("fantasmaNormal.png") })
  }
  
  method morir() {
    //que pasa cuando el fantasma muere
    image = ""
    const muerte = game.sound(".mp3")
    muerte.play()
    //game.schedule(2000, { => gameOver.perder()}) configurarlo en nivel
  }
  
  method image() = image
  
  method image(nueva) {
    image = nueva
  }
  
  method position() = position
  
  method position(nueva) {
    position = nueva
  }
}