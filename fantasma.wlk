import wollok.game.*
import items.*
import cazafantasmas.*
import personas.*
import niveles.*
import nivel1.*
import nivel2.*
import pantallaInicio.*


// el fantasma que controla el jugador
object grimly {
  var image = "FantasmaNormal.png"
  var position = game.at(14,0)

  method vidasRestantes() {
      return vidaGrimly.corazones()
  }

  method resetPosition() {
    position = game.at(14,0)
  }
  
  method recibirDaño() { // método que se ejecuta cuando grimly recibe daño
    const sonidoDaño = game.sound("sonidoTrampa.wav")
    sonidoDaño.volume(0.15)
    sonidoDaño.play()
    self.image("fantasmaDaño.png")
    game.schedule(200, { self.image("FantasmaNormal.png")})
    self.resetPosition()
    nivel1.chequearCondicionDerrota()
    nivel2.chequearCondicionDerrota()
    vidaGrimly.perderVida()
    

  }
  
  method recuperarVida() { // método que se ejecuta cuando grimly gana una vida
    const sonidoVida = game.sound("sonidoPocion.wav")
    sonidoVida.volume(0.15)
    sonidoVida.play()
    vidaGrimly.conseguirVida()
  }

 method asustar(aqui) { // método para asustar a los npc
    self.image("fantasma.png")
    const sonidoAtaque= game.sound("sonidoAtaque2.mp3")
    sonidoAtaque.volume(0.15)
    sonidoAtaque.play()
    game.schedule(500, { self.image("FantasmaNormal.png")})
    if(aqui.size() > 1){
      aqui.first().asustarse(self)
    }
    
  }

  method esCazador(){
    return false
  }
  method accionarObjeto(objeto){ // lo que ejecuta cuando toca una poción o trampa
    objeto.actuar(self)
  }
  method asustarse(cosa){}
  
  method image() = image
  
  method image(nueva) {
    image = nueva
  }
  
  method position() = position
  
  method position(nueva) {
    position = nueva
  }
}

// vida del fantasma grimly
class VisualCorazon {
    var property position
    var property image 
}

object vidaGrimly {
    
    var vidasActuales = 3

    method corazones()=vidasActuales

    // lista de corazones visuales
    const corazones = [
        new VisualCorazon(position = game.at(18, 15), image = "corazon_3.png"),
        new VisualCorazon(position = game.at(18, 15), image = "corazon_2.png"),
        new VisualCorazon(position = game.at(18, 15), image = "corazon_1.png")
    ]

    // --- INICIAR ---
    method iniciarBarraDeVida() {
        vidasActuales = 3
        
        // Recorremos la lista y agregamos todos los corazones
        corazones.forEach({ corazon => game.addVisual(corazon) })
    }

    // --- PERDER VIDA ---
    method perderVida() {
        if (vidasActuales > 0) {
            
			  // saca el corazón correspondiente, haciendo uso de la lista (posicion 0,1,2)
            const corazonASacar = corazones.get(vidasActuales - 1)
            game.removeVisual(corazonASacar)
            
            vidasActuales -= 1
        }
    }
    
    // --- RECUPERAR VIDA  ---
    method conseguirVida() {
        if (vidasActuales < 3) {
            vidasActuales += 1
            
			// agrega el corazón correspondiente, haciendo uso de la lista (posicion 0,1,2)
            const corazonAPoner = corazones.get(vidasActuales - 1)
            game.addVisual(corazonAPoner)
        }
    }

    method tieneVidas() = self.corazones() > 1
}