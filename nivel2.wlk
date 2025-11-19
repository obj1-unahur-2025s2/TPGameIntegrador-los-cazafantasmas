//niveles del juego
import wollok.game.*
import niveles.*
import fantasma.*
import personas.*
import cazafantasmas.*
import puntaje.*
import items.*
import controles.*
import pantallaInicio.*


object nivel2 inherits Nivel {
  const enemigos = [new Cazafantasma(),new Cazafantasma()]
  const pociones = [new Pocion()]
  const trampas = [new Trampa(), new Trampa(),new Trampa()]
  const property personas = [new Persona(),new Persona(),new Persona(),new Persona()]
  

  override method configurate() {
		super()
		estadoJuego.cambiarNivelActual("nivel2")
		const fondoCasa_level2 = new Fondo(image="fondoCasa_level2.png",position = game.at(0, 0))
		game.addVisual(fondoCasa_level2)
		vidaGrimly.iniciarBarraDeVida()
		puntaje.iniciarBarraDePuntos(0)
		self.ponerElementos(2, enemigos)
		self.ponerElementos(1, pociones)
		self.ponerElementos(3, trampas)
		self.ponerElementos(4, personas)
		personas.forEach({p=>p.dejarEstarAsustado()})
		grimly.resetPosition()
		game.addVisual(grimly)
		enemigos.forEach({e => e.acercarseA(grimly)
							   game.whenCollideDo(e, {grimly => e.atrapar(grimly)})
		 })

		trampas.forEach({t => game.whenCollideDo(t, {grimly => grimly.accionarObjeto(t)})})
		personas.forEach({p => p.moverseAleatorio() })
		pociones.forEach({po => game.whenCollideDo(po, {grimly => grimly.accionarObjeto(po)})})
	}

	
	method chequearCondicionVictoria() {    
			// .all() revisa si TODOS en la lista cumplen la condición
			const todasAsustadas = self.personas().all({ p => p.estaAsustado() })
		
			if (todasAsustadas) {
      			gameWin.ganar()

			 } 

	}
	method cantEnemigos(){
		return enemigos.size()
	}
}

