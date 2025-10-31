import wollok.game.*
import fantasma.*

//items que puede usar el jugador
class Item {
  var position = game.at(0, 0)
  var image = ""
  
  method puntaje()
  
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
  method modificarPuntos(num){
  }
  method actuar(jugador)
  
  method instanciar(posicion, cantidad)
}

class Pocion inherits Item {
  override method puntaje() = 150
  
  override method actuar(jugador) {
    if(game.hasVisual(self)){
    jugador.recuperarVida()
    jugador.modificarPuntos(self.puntaje())
    game.removeVisual(self)}
  }
  
  override method instanciar(posicion, cantidad) {
    //crea el item
    self.image("pocionVida.png")
    self.position(posicion)
  }
}

class Trampa inherits Item {
  override method puntaje() = -100
  
  override method actuar(jugador) {
    if(game.hasVisual(self)){
    jugador.modificarPuntos(self.puntaje())
    jugador.resetPosition()
    game.removeVisual(self)}
  }
  
  override method instanciar(posicion, cantidad) {
    //crea el item
    self.image("trampa.png")
    self.position(posicion)
  }
}