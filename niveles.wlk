//niveles del juego
import wollok.game.*
import fantasma.*
import items.*
import cazafantasmas.*
import personas.*

object gameOver {
	method position() = game.center()
	method image() = "gameover.png"
}


//todo robado pero configura los niveles de forma general
class Nivel {

	// Elementos del nivel	
	var property elementosEnNivel = [] // Lista de elementos recolectables interactivos, excepto enemigos
	var property enemigosEnTablero = [] // Lista de enemigos interactivos
	// Abstractos

	method personaje()

	method faltanRequisitos()

	method imagenIntermedia()

	method siguienteNivel()

	// Indica si hay elementos interactivo en la posición
	method hayElementoEn(posicion) = elementosEnNivel.any({ e => e.position() == posicion and e.esInteractivo() })

	/* Metodos que tambien interactuan con los movimientos del personaje */
	method ponerSalida() {
		game.addVisual(salida)
	} // Se agrega la salida al tablero

	method teletransportar() { // Reacción a la CeldaSorpresaA
		const unaPosicion = utilidadesParaJuego.posicionArbitraria()
		if (not self.hayElementoEn(unaPosicion)) {
			self.personaje().position(unaPosicion)
		} else {
			self.teletransportar()
		}
	}

	method agregarPollo() { // Reacción a la CeldaSorpresaD
		self.ponerElementos(1, pollo)
	}

// EL NOMBRE DEL ELEMENTO ES UN OBJETO QUE GENERA UNA NUEVA INSTANCIA CON EL METODO instanciar()
	method ponerElementos(cantidad, elemento) { // debe recibir cantidad y EL NOMBRE DE UN ELEMENTO
		if (cantidad > 0) {
			const unaPosicion = utilidadesParaJuego.posicionArbitraria()
			if (not self.hayElementoEn(unaPosicion)) { // si la posicion no está ocupada
				const unaInstancia = elemento.instanciar(unaPosicion) // instancia el elemento en una posicion
				elementosEnNivel.add(unaInstancia) // Agrega el elemento a la lista
				game.addVisual(unaInstancia) // Agrega el elemento al tablero
				self.ponerElementos(cantidad - 1, elemento) // llamada recursiva al proximo elemento a agregar
			} else { // Si había elementos, hace llamada recursiva
				self.ponerElementos(cantidad, elemento)
			}
		}
	}

	method configurate() {
		// Reinicio el estado del personaje
		self.personaje().reestablecer()
			// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo()) // Inicio de nivel
		keyboard.z().onPressDo{ self.pasarDeNivel()} // Tecla secreta para pasar de nivel
		keyboard.x().onPressDo({
		}) // ??
			// El sonido para que esté accesible desde todos los niveles
		keyboard.plusKey().onPressDo({ rain.volume(1)})
		keyboard.m().onPressDo({ rain.volume(0)})
		keyboard.minusKey().onPressDo({ rain.volume(0.5)})
		keyboard.p().onPressDo({ rain.pause()})
		keyboard.r().onPressDo({ rain.resume()})
		keyboard.s().onPressDo({ rain.stop()})
	}

	method perder() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
			// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image = "imgs/fondo Completo.png"))
			// después de un ratito ...
		game.schedule(1000, { game.clear()
				// cambio de fondo
			game.addVisual(new Fondo(image = "imgs/perdimos.png"))
				// después de un ratito ...
			game.schedule(4000, { // reinicia el juego
			pantallaInicio.configurate()})
		})
	}

	method terminar() {
		// sonido al ganar el juego
		game.sound("audio/ganarNivel3.mp3").play()
			// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
			// Fondo final
		game.addVisual(new Fondo(image = "imgs/fondo ganaste.png"))
			// después de un ratito ...
		game.schedule(4000, { // Volver al inicio 
		pantallaInicio.configurate()})
	}

	method pasarDeNivel() {
		// Generar el sonido para pasar de nivel
		const pasarNivel = game.sound("audio/pasarNivel.mp3")
		pasarNivel.play()
			// Fondo base del juego vacío
		game.addVisual(new Fondo(image = "imgs/fondo Completo.png"))
			// después de un ratito ...
		game.schedule(1000, { game.clear()
				// cambio de fondo. La imagenIntermedia cambia en cada nivel
			game.addVisual(new Fondo(image = self.imagenIntermedia()))
				// después de un ratito ...
			game.schedule(4000, { // ... limpio todo de nuevo
				game.clear() // y arranco el siguiente nivel
					// Se configura el próximo nivel
				self.siguienteNivel().configurate()
			})
		})
	}
}

//robado pero sirve para configurar los niveles como hijos del principal
object niveFacil inherits Nivel {

	// Personaje nivel 1
	var property personaje = new PersonajeNivel1(nivelActual = self)
	// cajasEnTablero se utiliza al  momento de usar ponerCajas()
	const property cajasEnTablero = #{}

	override method faltanRequisitos() = not (self.todasLasCajasEnDeposito() && personaje.llavesAgarradas() == 3)

	// hayCaja lo utiliza ponerCajas como condición para agregar una en la posición
	method hayCaja(posicion) = self.cajasEnTablero().any({ b => b.position() == posicion })

	method todasLasCajasEnDeposito() = not self.cajasEnTablero().any{ b => !b.estaEnDeposito()}

	// Se activa con la tecla "n"
	method estadoActual() {
		var palabras = ""
		if (not self.todasLasCajasEnDeposito()) {
			palabras = palabras + "Aún faltan cajas en el depósito."
		}
		if (personaje.llavesAgarradas() < 3) {
			palabras = palabras + "No encontré todas las llaves."
		}
		return palabras
	}

	// Este método es exclusivo del nivel 1
	method ponerCajas(cantidad) { // debe recibir cantidad
		const unaPosicion = utilidadesParaJuego.posicionArbitraria()
		if (cantidad > 0) {
			if (not self.hayElementoEn(unaPosicion)) { // si la posicion no esta ocupada
				const unaCaja = new Caja(position = unaPosicion, nivelActual = self) // instancia el bloque en una posicion
				cajasEnTablero.add(unaCaja) // Agrega el bloque a la lista
				game.addVisual(unaCaja) // Agrega el bloque al tablero
				self.ponerCajas(cantidad - 1) // llamada recursiva al proximo bloque a agregar
			} else {
				self.ponerCajas(cantidad)
			}
		}
	}

	override method configurate() {
		super()
			// otros visuals
		game.addVisual(deposito)
			// La cantidad de cajas depende de la dificultad seleccionada
		self.ponerCajas(dificultad.cajas())
		self.ponerElementos(3, llave)
		self.ponerElementos(3, pollo)
		self.ponerElementos(1, sorpresaA)
		self.ponerElementos(1, sorpresaB)
		self.ponerElementos(1, sorpresaC)
		self.ponerElementos(1, sorpresaD)
			// Se agregan las visuales de estado de Cantidad de Oro, Vida, Llaves, Energía
		vidaVisual.iniciarGrafico(personaje.vida(), "imgs/vi.png", "imgs/da.png")
		energiaVisual.iniciarGrafico(personaje.energia(), "imgs/ene.png", "imgs/rgia.png")
		llavesVisual.iniciarGrafico(personaje.llavesAgarradas(), "", "")
			// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personaje)
			// teclado
			/*Movimientos del personaje*/
		keyboard.right().onPressDo{ personaje.moverDerecha()}
		keyboard.left().onPressDo{ personaje.moverIzquierda()}
		keyboard.up().onPressDo{ personaje.moverArriba()}
		keyboard.down().onPressDo{ personaje.moverAbajo()}
		keyboard.q().onPressDo{ personaje.agarrarElemento()}
		keyboard.n().onPressDo({ // al presionar "n" finaliza el juego o da indicaciones
			if (not self.faltanRequisitos()) {
				game.say(personaje, "¡¡¡Ganamos!!!")
				game.schedule(1500, { self.pasarDeNivel()})
			} else {
				game.say(personaje, self.estadoActual())
			}
		})
	}

	// Se utiliza en pasarDeNivel()
	override method imagenIntermedia() {
		return "imgs/fondoFinNivel1.png"
	}

	// Se utiliza en pasarDeNivel()
	override method siguienteNivel() = nivel2

}

//robado pero sirve para configurar los niveles como hijos del principal
object niveDificil inherits Nivel {

	// Personaje nivel 1
	var property personaje = new PersonajeNivel1(nivelActual = self)
	// cajasEnTablero se utiliza al  momento de usar ponerCajas()
	const property cajasEnTablero = #{}

	override method faltanRequisitos() = not (self.todasLasCajasEnDeposito() && personaje.llavesAgarradas() == 3)

	// hayCaja lo utiliza ponerCajas como condición para agregar una en la posición
	method hayCaja(posicion) = self.cajasEnTablero().any({ b => b.position() == posicion })

	method todasLasCajasEnDeposito() = not self.cajasEnTablero().any{ b => !b.estaEnDeposito()}

	// Se activa con la tecla "n"
	method estadoActual() {
		var palabras = ""
		if (not self.todasLasCajasEnDeposito()) {
			palabras = palabras + "Aún faltan cajas en el depósito."
		}
		if (personaje.llavesAgarradas() < 3) {
			palabras = palabras + "No encontré todas las llaves."
		}
		return palabras
	}

	// Este método es exclusivo del nivel 1
	method ponerCajas(cantidad) { // debe recibir cantidad
		const unaPosicion = utilidadesParaJuego.posicionArbitraria()
		if (cantidad > 0) {
			if (not self.hayElementoEn(unaPosicion)) { // si la posicion no esta ocupada
				const unaCaja = new Caja(position = unaPosicion, nivelActual = self) // instancia el bloque en una posicion
				cajasEnTablero.add(unaCaja) // Agrega el bloque a la lista
				game.addVisual(unaCaja) // Agrega el bloque al tablero
				self.ponerCajas(cantidad - 1) // llamada recursiva al proximo bloque a agregar
			} else {
				self.ponerCajas(cantidad)
			}
		}
	}

	override method configurate() {
		super()
			// otros visuals
		game.addVisual(deposito)
			// La cantidad de cajas depende de la dificultad seleccionada
		self.ponerCajas(dificultad.cajas())
		self.ponerElementos(3, llave)
		self.ponerElementos(3, pollo)
		self.ponerElementos(1, sorpresaA)
		self.ponerElementos(1, sorpresaB)
		self.ponerElementos(1, sorpresaC)
		self.ponerElementos(1, sorpresaD)
			// Se agregan las visuales de estado de Cantidad de Oro, Vida, Llaves, Energía
		vidaVisual.iniciarGrafico(personaje.vida(), "imgs/vi.png", "imgs/da.png")
		energiaVisual.iniciarGrafico(personaje.energia(), "imgs/ene.png", "imgs/rgia.png")
		llavesVisual.iniciarGrafico(personaje.llavesAgarradas(), "", "")
			// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personaje)
			// teclado
			/*Movimientos del personaje*/
		keyboard.right().onPressDo{ personaje.moverDerecha()}
		keyboard.left().onPressDo{ personaje.moverIzquierda()}
		keyboard.up().onPressDo{ personaje.moverArriba()}
		keyboard.down().onPressDo{ personaje.moverAbajo()}
		keyboard.q().onPressDo{ personaje.agarrarElemento()}
		keyboard.n().onPressDo({ // al presionar "n" finaliza el juego o da indicaciones
			if (not self.faltanRequisitos()) {
				game.say(personaje, "¡¡¡Ganamos!!!")
				game.schedule(1500, { self.pasarDeNivel()})
			} else {
				game.say(personaje, self.estadoActual())
			}
		})
	}

	// Se utiliza en pasarDeNivel()
	override method imagenIntermedia() {
		return "imgs/fondoFinNivel1.png"
	}

	// Se utiliza en pasarDeNivel()
	override method siguienteNivel() = nivel2

}
