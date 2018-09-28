class Deposito {

	var property formaciones = []

	method formacion(locomotora) {
		formaciones.add(locomotora)
	}

}

class Formacion {

	var property locomotoras = []
	var property vagones = []

	method agregarlocomotoras(locomotor) {
		vagones.add(locomotor)
	}

	method agregarVagones(vagon) {
		vagones.add(vagon)
	}

	method vagonLiviano() {
		return vagones.count{ unVagon => unVagon.pesoMaximo() < 2500 }
	}
	method velocidadMaxima(){
		return locomotoras.min{unaLocomotora=>unaLocomotora.velocidadMaxima()}
	}

}

class Locomotor {

	var property cantDeLocomotoras = 1
	var property peso = 1
	var property pesoMaximoQueArrastra = 1
	var property velocidadMaxima = 1

	method arrastreUtil() {
		return pesoMaximoQueArrastra - peso
	}

}

class Vagon {

	var property cantDeVagones = 1
	var property tipoDeVagones = pasajeros

	method pesoMaximo() {
		tipoDeVagones.pesoMaximo()
	}

}

object pasajeros {

	var property largoEnMetros = 1
	var property anchoUtilEnMetros = 1

	method cantidadDePasajerosALlevar() {
		if (anchoUtilEnMetros < 2.5) {
			return largoEnMetros * 8
		} else return largoEnMetros * 10
	}

	method pesoMaximo() {
		return self.cantidadDePasajerosALlevar() * 80
	}

}

object carga {

	var property cargaMaxima = 1

	method pesoMaximo() {
		return cargaMaxima + 160
	}

}

