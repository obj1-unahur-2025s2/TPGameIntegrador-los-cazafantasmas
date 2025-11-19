
import wollok.game.*
import fantasma.*
import puntaje.*
//items que puede usar el jugador
class Item {
  var position = game.at(0, 0)
  var image = ""
  
  method esInteractivo() = true
  //el jugador puede interactuar (osea pueden colisionar)
  
  method position(nueva) {
    position = nueva
  }
  
  method position() = position
  
  method image() = image
  
  method image(nueva) {
    image = nueva
  }
  
  method asustarse(jugador) {
    
  }
  method recibirDaño(){
  }
  method actuar(jugador)
  
  method instanciar(posicion, cantidad)
  	method esCazador(){
        return false
    }
}

class Pocion inherits Item {

  
  override method actuar(jugador) {
    if(game.hasVisual(self)){
    puntaje.puntosPocion()
    jugador.recuperarVida() 
    game.removeVisual(self)}
  }
  
  override method instanciar(posicion, cantidad) {
    //crea el item
    self.image("pocionVida.png")
    self.position(posicion)
  }

  
}

class Trampa inherits Item {
  
  override method actuar(jugador) {
    if(game.hasVisual(self)){
    puntaje.puntosTrampa()
    jugador.recibirDaño() 
    game.removeVisual(self)}
  }
  
  override method instanciar(posicion, cantidad) {
    //crea el item
    self.image("trampa.png")
    self.position(posicion)
  }
}