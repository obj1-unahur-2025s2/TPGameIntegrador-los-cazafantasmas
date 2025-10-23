//items que puede usar el jugador
import wollok.game.*
import fantasma.*
class Item{
    var position= game.at(0,0)
    var image=""

    method puntaje(){

    }
}

class Posion inherits Item {
    method interactuarCon(jugador){

    }
  override puntaje(){

  }
}

class Trampa inherits Item{
    override puntaje(){

  }
}