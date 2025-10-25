//los cazafantasmas que van a ser enemigos
import wollok.game.*
import fantasma.*
/*
class Cazafantasma {
  var position=game.at(0,0)
  var image=""
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
	method asustarse(jugador){
  }
  method moverse(direccion){
    game.onTick(1500, "cazador", { self.direccionCambiante()
			position = direccion.proximaPosicion(self.position())
		})
	}//robado supuestamente persigue al fantasma
  method atacar(jugador){
	jugador.recibirDaño()
	self.resetPosition()
  }
  method puntaje(){
	return -500
  }
  method resetPosition() {
		position = game.at(numero + 1, numero + 1)
	}
//esto tambien es robado  
    	method acercarseHorizontalA(unPersonaje) {
		return if (self.estaALaIzquierdaDe(unPersonaje)) {
			self.position().x() + 1
		} else {
			self.position().x() - 1
		}
	}

	method acercarseVerticalA(unPersonaje) {
		return if (self.estaAbajoDe(unPersonaje)) {
			self.position().y() + 1
		} else {
			self.position().y() - 1
		}
	}

	method estaALaIzquierdaDe(unElemento) = unElemento.position().x() > self.position().x()

	method estaAbajoDe(unElemento) = unElemento.position().y() > self.position().y()
}
*/