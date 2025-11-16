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


object nivel1 inherits Nivel {
	const enemigos = [new Cazafantasma()]
  	const pociones = [new Pocion(),new Pocion()]
  	const trampas = [new Trampa()]
  	const property personas = [new Persona(),new Persona(),new Persona()]
	
	override method configurate() {
		super()
		const fondoCasa_level1 = new Fondo(image="fondoCasa_level1.png",position = game.at(0, 0))
		game.addVisual(fondoCasa_level1)
		vida.iniciarBarraDeVida()
		puntaje.iniciarBarraDePuntos(0)
		self.ponerElementos(1, enemigos)
		self.ponerElementos(2, pociones)
		self.ponerElementos(1, trampas)
		self.ponerElementos(3, personas)
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
	  
}

