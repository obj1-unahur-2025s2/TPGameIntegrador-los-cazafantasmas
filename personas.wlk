//npc podrian llegar a tener un leve movimiento y asustarse
import wollok.game.*
import controles.*
import fantasma.*

class Persona {
  var position = game.at(10, 10)
  var image = ""

   
  method esInteractivo() = true//el jugador puede interactuar (osea pueden colisionar)
  //movimiento de los npc
  method moverseAleatorio() {
    var time = 500
    const randomDireccion = [
      [arriba, arriba, arriba],
      [abajo, abajo, abajo],
      [izquierda, izquierda, izquierda],
      [derecha, derecha, derecha]
    ].anyOne()
    
    randomDireccion.forEach(
      { p =>
        game.schedule(
          time,
          { self.position(p.moverseAProximaPosicion(self.position())) }
        )
        time += 500
      }
    )
    game.schedule(1500, { self.moverseAleatorio() })
  }

  	method instanciar(posicion,cantidad){//crea al npc
    self.image("npc"+cantidad.toString()+".png")//metodo carga  las imagenes a cada npc se invoca en nivel
    self.position(posicion)
  }
  //que hace cuando se asusta
  method asustarse(jugador) {
    self.image("fantasma.png")
      //crear una imagen que represente cuanod un npc en general esta asustado
    jugador.modificarPuntos(self.puntaje())
    game.schedule(2000, {   
      game.removeVisual(self)
    })
  }
 method accionarObjeto(objeto){

  }
  method puntaje() = 200
  
  method image() = image
  
  method image(nueva) {
    image = nueva
  }
  
  method position() = position
  
  method position(nueva) {
    position = nueva
  }
}