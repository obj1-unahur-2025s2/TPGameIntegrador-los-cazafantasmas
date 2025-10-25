//el fantasma que controla el jugador
import wollok.game.*
import items.*
import cazafantasmas.*
import personas.*
import controles.*


object fantasma {
  var image= "FantasmaNormal.png"
  var position = game.origin()
  var puntaje=0
  var vida=3

  method moverse(direccion){

  }
  method resetPosition() {
		position = game.origin()
	}
  method noTieneMasVidas() = vida == 0

  method recibirDaño(){
	vida=(vida-1).max(0)
	self.resetPosition()
  }
  method modificarPuntos(num){
	puntaje+=num
  }
  method asustar(){
	self.image("fantasma.png")
	game.whenCollideDo(self, {p=>p.asustarse(self)})
	game.schedule(500, {self.image("FantasmaNormal.png")})
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
/*
//esto es robado pero define el punaje
class Indicador {

	// creacion imagenes de numeros
	var property decimal = new Visual(position = self.positionDecimal())
	var property unidad = new Visual(position = self.positionUnidad())

	// El nombre que se usa para la imagen del indicador
	method nombreImagenIndicador()

	/* Asignar las imágenes para un número de dos cifras */
/*	method definirImagenesContador(unNumero) {
		const numeroUnidad = unNumero % 10
		const numeroDecena = (unNumero * 0.1).truncate(0)
			// Asigno la imagen para decimal
		self.decimal().image(self.imagenDeValor(numeroDecena))
			// Asigno la imagen para decimal
		self.unidad().image(self.imagenDeValor(numeroUnidad))
	}

	method imagenDeValor(unValor) {
		return "imgs/" + self.nombreImagenIndicador() + " (" + unValor.toString() + ").png"
	}

	// La posición del decimal
	method positionDecimal()

	// La posición de la unidad
	method positionUnidad()

	// iniciar graficos de numero y titulo
	method iniciarGrafico(valorInicial, partTituloDecimal, partTituloUnidad) {
		// Definir las imagenes para decimal y unidad
		self.definirImagenesContador(valorInicial)
			// agregar visual unidad y decimal
		game.addVisual(self.decimal())
		game.addVisual(self.unidad())
			// agregar visual de titulo (la posición es la misma que la de los números)
		game.addVisual(new Visual(position = self.positionDecimal(), image = partTituloDecimal))
		game.addVisual(new Visual(position = self.positionUnidad(), image = partTituloUnidad))
	}

	// Actualiza las imágenes según un nuevo valor
	method actualizarDato(nuevoValor) {
		self.definirImagenesContador(nuevoValor)
	}

}
//tambien robado pero otra forma de agregarlo
object reloj {
	
	var tiempo = 0
	
	method text() = tiempo.toString()
	method position() = game.at(1, game.height()-1)
	
	method pasarTiempo() {
		tiempo = tiempo +1
	}
	method iniciar(){
		tiempo = 0
		game.onTick(100,"tiempo",{self.pasarTiempo()})
	}
	method detener(){
		game.removeTickEvent("tiempo")
	}
}*/