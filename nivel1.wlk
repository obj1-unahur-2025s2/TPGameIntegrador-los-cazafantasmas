//niveles del juego
import wollok.game.*
import niveles.*
import fantasma.*
import personas.*
import cazafantasmas.*
import puntaje.*
import cosas.*
import items.*
import controles.*

object nivel1 inherits Nivel {
  const enemigos = [new Cazafantasma ()]
  const pociones = [new Pocion(), new Pocion(), new Pocion()]
  const trampas = [new Trampa(), new Trampa()]
  const personas = [new Persona(), new Persona(),new Persona(),new Persona()]

  override method configurate() {
		super()
		
		self.ponerElementos(1, enemigos)
		self.ponerElementos(3, pociones)
		self.ponerElementos(2, trampas)
		self.ponerElementos(4, personas)
		game.addVisual(grimly)
		enemigos.forEach({e => e.acercarseA(grimly)
							   game.whenCollideDo(e, {grimly => e.atrapar(grimly)})
		 })

		trampas.forEach({t => game.whenCollideDo(t, {grimly => grimly.accionarObjeto(t)})})
		personas.forEach({p => p.moverseAleatorio() })
		pociones.forEach({po => game.whenCollideDo(po, {grimly => grimly.accionarObjeto(po)})})
    	
	/*
		// Se agregan las visuales de estado de Cantidad de Oro, Vida, Llaves, Energía
		vidaVisual.iniciarGrafico(personaje.vida(), "imgs/vi.png", "imgs/da.png")
		puntajeVisual.iniciarGrafico(personaje.puntaje(), "imgs/ene.png", "imgs/rgia.png")
	*/
			
	}
}

