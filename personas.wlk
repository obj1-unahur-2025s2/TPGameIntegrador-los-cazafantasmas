//npc podrian llegar a tener un leve movimiento y asustarse
import wollok.game.*
import controles.*

class Persona {
  var position=game.at(10,10)
  var image="npc1.png"
  var asustado=false
  method moverseAleatorio(){
    const randomDireccion=[
    [position.up(1), position.up(2), position.up(3)],
    [position.down(1), position.down(2), position.down(3)],
    [position.left(1), position.left(2), position.left(3)],
    [position.right(1), position.right(2), position.right(3)]
    ].anyOne()

    var time = 500
    randomDireccion.forEach({p =>
      if(!posicionInvalida.posicionesInvalidas().contains(p)&& !posicionInvalida.estaEnElBorde(p)){
        game.schedule(time,{self.position(p)})
        time += 500
      }
    })
    game.schedule(2000, {self.moverseAleatorio()})
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