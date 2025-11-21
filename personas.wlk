import wollok.game.*
import controles.*
import fantasma.*
import puntaje.*
import nivel1.*
import nivel2.*
import niveles.*

//Npcs
class Persona {
  var position = game.at(10, 10)
  var image = ""
  var imageMuerto=""
  var asustado = false

  method estaAsustado() = asustado

  method dejarEstarAsustado() {
     asustado=false
  }
  method esInteractivo() = true //el jugador puede interactuar (o sea pueden colisionar)
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

  method instanciar(posicion,cantidad){ // crea al npc
    self.image("npc"+cantidad.toString()+".png") // metodo carga  las imagenes a cada npc se invoca en nivel
    self.imageMuerto("npc"+cantidad.toString()+"_muerto"+".png")
    self.position(posicion)
  }

    	method esCazador(){
        return false
    }
  // que hace cuando se asusta
  method asustarse(jugador) {
    if(! self.estaAsustado()){
      puntaje.puntosNpc()
      asustado = true
      nivel1.chequearCondicionVictoria()
      nivel2.chequearCondicionVictoria()
    }
    const sonidoAsustar = game.sound("sonidoAsustar.wav")
    sonidoAsustar.volume(0.15)
    sonidoAsustar.play()
    self.image(imageMuerto)
    game.schedule(800, {   
      game.removeVisual(self)
    })  
    
  }
  method accionarObjeto(objeto){}
  
  method image() = image
  
  method image(nueva) {
    image = nueva
  }
  method imageMuerto() = imageMuerto
  
  method imageMuerto(nueva) {
    imageMuerto = nueva
  }
  method position() = position
  
  method position(nueva) {
    position = nueva
  }
  method recibirDaño(){}
}