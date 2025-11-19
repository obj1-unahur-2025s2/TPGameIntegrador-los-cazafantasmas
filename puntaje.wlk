

class Millar {
    var property position = game.at(27, 15) // Posición 3
    var property image = ""
}

class Centena {
    var property position = game.at(27, 15) // Posición 2
    var property image = ""
}

class Decimal { 
    var property position = game.at(27, 15) // Posición 1
    var property image = ""
}

class Unidad {
    var property position = game.at(27, 15) // Posición 0
    var property image = ""
}



object puntaje {
    
    // El puntaje se guarda como un número
    var property valorActual = 0

    // lo que van a  mostrar las imágenes
    var property millar = new Millar()
    var property centena = new Centena()
    var property decimal = new Decimal()
    var property unidad = new Unidad()

    
    // Este método lee la variable 'valorActual' y actualiza las 4 IMÁGENES.
    method actualizarImagenes() {

        // Descompone el número en dígitos (ej:123) -- "/" te da las veces que un número entra en otro y el "%" te da el resto
        const val_unidad  = self.valorActual() % 10
        const val_decena  = (self.valorActual() / 10).truncate(0) % 10
        const val_centena = (self.valorActual() / 100).truncate(0) % 10
        const val_mil     = (self.valorActual() / 1000).truncate(0) % 10

        // Asigna las IMÁGENES 
        self.unidad().image(self.imagenDeValor(0, val_unidad)) 
		self.decimal().image(self.imagenDeValor(1, val_decena)) 
		self.centena().image(self.imagenDeValor(2, val_centena)) 
		self.millar().image(self.imagenDeValor(3, val_mil))
    }

    // Método auxiliar para construir el nombre de la IMAGEN
    method imagenDeValor(posicion, valor) {
        return "posicion" + posicion.toString() + "_num" + valor.toString() + ".png"
    }

    // metodo para llamar desde el archivo niveles(.configurate)

    method iniciarBarraDePuntos(unValor) {
        valorActual= unValor
        self.actualizarImagenes() // Pone las imágenes iniciales

        game.addVisual(self.millar())
        game.addVisual(self.centena())
        game.addVisual(self.decimal())
        game.addVisual(self.unidad())
    }
    
    // Suma o resta puntos y actualiza las imágenes
    method sumarPuntos(cantidad) {
        valorActual = valorActual + cantidad
        valorActual = valorActual.max(0).min(9999)  // Limita el puntaje entre 0 y 9999
        self.actualizarImagenes()
    }

    method puntosActuales(){
        return valorActual
    }
 
    // metodo de puntajes segun lo que pase en el juego
    method puntosPocion() {
        // Suma 100 puntos
        self.sumarPuntos(100)
    }

    method puntosNpc() {
        // Suma 200 puntos
        self.sumarPuntos(200)
    }

    method puntosTrampa() {
        // Resta 100 puntos
        self.sumarPuntos(-100)
    }

    method puntosCazador() {
        // Resta 300 puntos
        self.sumarPuntos(-150)
    }
}