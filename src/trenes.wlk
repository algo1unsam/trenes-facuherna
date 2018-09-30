class Deposito {

	var property formaciones = []

	method agregarFormacion(conjuntos) {
		formaciones.add(conjuntos)
	}

	method conjuntoDeVagonesPesados() {
		return formaciones.map{ vagones => vagones.vagonesPesados() }
	}

	method formacionCompleja() {
		return formaciones.size() > 20 or formaciones.sum{ unaFormacion => unaFormacion.sumaTotalDeFormacion() } > 10000
	}

	method formacionMovilisada(formacion,locomotora) {
		if (formacion.podesMoverte()) {
		}
		else if (self.locomotoraSuelta(formacion, locomotora)) {
			formacion.agregarlocomotoras(locomotora)
		}
	}

	method locomotoraSuelta(formacion, locomotora) {
		return locomotora.arrastreUtil() >= formacion.sumaDePesoMaximoDeVagones()
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

	method kilosQueFaltaParaMoverse() {
		return self.sumaDePesoMaximoDeVagones() - self.sumaDeArrastre()
	}

	method vagonesPesados() {
		return vagones.max{ unVagon => unVagon.pesoMaximo() }
	}

	method sumaTotalDeFormacion() {
		return self.sumaDePesoMaximoDeVagones() + self.sumaDelPesoDeLasLocomotoras()
	}

	method sumaDelPesoDeLasLocomotoras() {
		return locomotoras.sum{ unaLocomotora => unaLocomotora.peso() }
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

