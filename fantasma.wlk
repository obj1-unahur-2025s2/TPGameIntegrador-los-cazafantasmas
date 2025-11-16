//el fantasma que controla el jugador
import wollok.game.*
import items.*
import cazafantasmas.*
import personas.*
import niveles.*
import nivel1.*
import nivel2.*
import pantallaInicio.*


object grimly {
  var image = "FantasmaNormal.png"
  var position = game.at(14,0)

  method resetPosition() {
    position = game.at(14,0)
  }
  
  method recibirDaño() {
    const sonidoDaño = game.sound("sonidoTrampa.wav")
    sonidoDaño.volume(0.15)
    sonidoDaño.play()
    self.image("fantasmaDaño.png")
    game.schedule(200, { self.image("FantasmaNormal.png")})
    if(not vida.tieneVidas()){
      gameOver.perder()
    }
    self.resetPosition()
    vida.perderVida()

  }
  
  method recuperarVida() {
    const sonidoVida = game.sound("sonidoPocion.wav")
     sonidoVida.volume(0.15)
     sonidoVida.play()
    vida.conseguirVida()
  }

 method asustar(aqui) {
    self.image("fantasma.png")
    game.schedule(500, { self.image("FantasmaNormal.png")})
    if(aqui.size() > 1){
      aqui.first().asustarse(self)
    }
    
  }


  method accionarObjeto(objeto){
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

object vida {
    
    var property vidasActuales = 3

    // Lista de Corazones Visuales
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

    method tieneVidas() = vidasActuales > 1
}