class Deposito {

	var property formaciones = []

	method formacion(locomotora) {
		formaciones.add(locomotora)
	}

}

class Formacion {

	var property locomotoras = []
	var property vagones = []

	method agregarlocomotoras(locomotora) {
		locomotoras.add(locomotora)
	}

	method agregarVagones(vagon) {
		vagones.add(vagon)
	}

	method vagonLiviano() {
		return vagones.count{ unVagon => unVagon.pesoMaximo() < 2500 }
	}

	method velocidadMaxima() {
		return locomotoras.min{ unaLocomotora => unaLocomotora.velocidadMaxima() }.velocidadMaxima()
	}

	method formacionEficiente() {
		return locomotoras.all{ unaLocomotora => unaLocomotora.arrastreUtil() >= unaLocomotora.peso() * 5 }
	}

	method podesMoverte() {
		return self.sumaDeArrastre() >= self.sumaDePesoMaximoDeVagones()
	}

	method sumaDeArrastre() {
		return locomotoras.sum{ unaLocomotora => unaLocomotora.arrastreUtil() }
	}

	method sumaDePesoMaximoDeVagones() {
		return vagones.sum{ unVagon => unVagon.pesoMaximo() }
	}

}

class Locomotora {

	var property peso = 1
	var property pesoMaximoQueArrastra = 1
	var property velocidadMaxima = 1

	method arrastreUtil() {
		return pesoMaximoQueArrastra - peso
	}

}

class Vagon {

	var property tipoDeVagones = null

	method pesoMaximo() {
		return tipoDeVagones.pesoMaximo()
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

