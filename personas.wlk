//npc podrian llegar a tener un leve movimiento y asustarse
import wollok.game.*
class Persona {
  var position=game.at(0,0)
  var image=""
  var asustado=false
  method moverse(direccion){

  }
  method asustarse(jugador){
    if(! self.estaAsustado()){ 
    self.image("")
    jugador.modificarPuntos(self.puntaje())
    asustado=true
    }
  }
  method estaAsustado(){
    return asustado
  }
  method puntaje(){
    return 300
    }
    method image(){
	return image
  }
  method image(nueva){
	image=nueva
  }
  method position(){
	return position
  }
    method position(nueva){
	position=nueva
  }
}