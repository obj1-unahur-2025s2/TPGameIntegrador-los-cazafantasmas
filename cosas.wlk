import wollok.game.*
import controles.*
import fantasma.*

object casa {
	method crearCasa() {
	  //habitacion1
    const fondoCasa = new Mueble(image="piso.png",position = game.at(0, 0))
    const paredes_1= new Mueble(image="paredes1.png",position = game.at(0, 7))
    const paredBlanca_1= new Mueble(image="paredBlanca.png",position= game.at(0,13))
    const bibliotecaIzq_1 = new Mueble (image="biblioteca.png",position = game.at(1,13))
    const bibliotecaDer_1 = new Mueble (image= "biblioteca.png",position = game.at(5,13)) 
    const velaColganteIzq_1 = new Mueble (image="velaColgante.png",position = game.at(2,14))
    const velaColganteDer_1 = new Mueble(image="velaColgante.png",position = game.at(4,14))
    const chimenea_1 = new Mueble(image="chimenea.png",position = game.at(3,13))
    const cuadro_1 = new Mueble(image="cuadro.png",position = game.at(3,14))
    const sillonIzq_1 = new Mueble(image= "sillon.png",position = game.at(2,11))
    const sillonDer_1 = new Mueble(image= "sillon.png",position = game.at(4,11))
    const mesaConCopas_1 = new Mueble(image= "mesaConCopas.png",position = game.at(3,11))
    const mesaConCandelabroIzq_1 = new Mueble(image="mesaConCandelabro.png",position = game.at(1,8))
    const mesaConCandelabroDer_1 = new Mueble(image="mesaConCandelabro.png",position = game.at(6,8))
    const macetaFloreada_1 = new Mueble(image= "macetaFloreada.png",position = game.at(4,13))
    const alfombraRoja_1= new Mueble(image="alfombra.png",position = game.at(2,10))
    const tamborConWisky_1 = new Mueble(image="tamborConWisky.png",position = game.at(6,13))
    const gato_1 = new Mueble(image="gato.png",position=game.at(4,10))
    const apoyaPies_1 = new Mueble(image="apoyaPies.png",position=game.at(2,10))


        //habitacion2
    const paredes_2= new Mueble(image="paredes_2.png",position = game.at(20,0 ))
    const paredBlanca_2 = new Mueble(image="paredBlanca_2.png",position= game.at(21,8))
    const bibliotecaConPuertas_2= new Mueble(image="bibliotecaConPuertas.png",position= game.at(23,8))
    const armarioConLibro_2 = new Mueble(image="armarioConLibro.png",position= game.at(21,1))
    const cuadroComida_2 =new Mueble(image="cuadroComida.png",position= game.at(27,9))
    const cuadroFlor_2 =new Mueble(image="cuadroFlor.png",position= game.at(22,9))
    const cuadroMasion_2 =new Mueble(image="cuadroMasion.png",position= game.at(26,9))
    const mesaConJarronAmarillo_2 = new Mueble(image="mesaConJarronAmarillo.png",position=game.at(23,1))
    const mesaConJarronAzul_2 = new Mueble(image="mesaConJarronAzul.png",position=game.at(27,1))
    const muebleConCajones = new Mueble(image="mesaConCajon.png",position=game.at(21,8))
    const mesaConCandelabro_2 = new Mueble(image="mesaConCandelabro.png",position=game.at(28,8)) 
    const mesaConCopasYWisky_2 = new Mueble(image="mesaConCopasYWisky.png",position=game.at(24,8)) 
    const mesaConSillas_2  = new Mueble(image="mesaConSillas.png",position=game.at(22,4)) 
    const mesaConCopas_2 = new Mueble(image="mesaConCopas.png",position=game.at(26,6)) 
    const mesitaDeLuz_2 = new Mueble(image="mesitaDeLuz.png",position=game.at(25,8)) 
    const muebleConLibro_2 = new Mueble(image="muebleConLibro.png",position=game.at(25,1)) 
    const sillonDoble_2 = new Mueble(image="sillonDoble.png",position=game.at(26,8)) 
    const sillonLateral_2 = new Mueble(image="sillonLateral.png",position=game.at(28,6)) 
    const alfombraRoja_2= new Mueble(image="alfombra.png",position = game.at(25,5))
    const apoyaPies_2 = new Mueble(image="apoyaPies.png",position=game.at(27,5))


        //habitacion3
    const paredes_3= new Mueble(image="paredes_3.png",position = game.at(10, 8))
    const paredBlanca_3= new Mueble(image="paredBlanca_3.png",position= game.at(10,13))
    const mesitaDeLuzIzq_3= new Mueble(image="mesitaDeLuz.png",position=game.at(12 , 13))
    const mesitaDeLuzDer_3= new Mueble(image="mesitaDeLuz.png",position=game.at(15 , 13))
    const mesaConJarronAmarillo_3 = new Mueble(image="mesaConJarronAmarillo.png",position=game.at(16 , 9))
    const muebleConCandelabroYLibro_3 = new Mueble(image="muebleConCandelabroYLibro.png",position= game.at(11 , 9))
    const cuadroHombre_3= new Mueble (image="cuadroHombre.png",position=game.at(15 , 14))
    const cuadroMujer_3= new Mueble (image= "cuadroMujer.png",position= game.at(12 , 14))
    const cama_3 = new Mueble(image= "cama.png",position= game.at(13 , 12))
    
    game.addVisual(fondoCasa)
    game.addVisual(paredBlanca_1)
    game.addVisual(paredes_1)
    game.addVisual(bibliotecaIzq_1)
    game.addVisual(velaColganteIzq_1)
    game.addVisual(chimenea_1)
    game.addVisual(cuadro_1)
    game.addVisual(bibliotecaDer_1)
    game.addVisual(macetaFloreada_1)
    game.addVisual(alfombraRoja_1)
    game.addVisual(velaColganteDer_1)
    game.addVisual(gato_1)
    game.addVisual(tamborConWisky_1)
    game.addVisual(apoyaPies_1)
    game.addVisual(paredBlanca_3)
    game.addVisual(cuadroMujer_3)
    game.addVisual(cuadroHombre_3)
    game.addVisual(cama_3)
    game.addVisual(mesitaDeLuzIzq_3)
    game.addVisual(mesitaDeLuzDer_3)
    game.addVisual(paredes_3)
    game.addVisual(paredBlanca_2)
    game.addVisual(paredes_2)
    game.addVisual(bibliotecaConPuertas_2)
    game.addVisual(cuadroComida_2)
    game.addVisual(cuadroFlor_2)
    game.addVisual(cuadroMasion_2)
    game.addVisual(muebleConCajones)
    game.addVisual(mesaConCandelabro_2)
    game.addVisual(mesaConCopasYWisky_2)
    game.addVisual(alfombraRoja_2)
    game.addVisual(apoyaPies_2)
    game.addVisual(sillonDoble_2)
    game.addVisual(mesitaDeLuz_2)
    game.addVisual(sillonIzq_1)
    game.addVisual(sillonDer_1)
    game.addVisual(mesaConCopas_1)
    game.addVisual(mesaConCandelabroIzq_1)
    game.addVisual(mesaConCandelabroDer_1)
    game.addVisual(muebleConCandelabroYLibro_3)
    game.addVisual(mesaConJarronAmarillo_3)
    game.addVisual(armarioConLibro_2)
    game.addVisual(mesaConJarronAmarillo_2)
    game.addVisual(mesaConJarronAzul_2)
    game.addVisual(mesaConSillas_2)
    game.addVisual(mesaConCopas_2)
    game.addVisual(muebleConLibro_2)
    game.addVisual(sillonLateral_2)
	}
}


//esta clase representa a todos los items del juego
class Mueble {
    const property image 
	var property position 
	method asustarse(jugador){}
	method chocarse(jugador){}
    method recibirDaño(){
        
    }
}