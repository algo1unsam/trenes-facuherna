class Deposito {

	var property formaciones = []

	method agregarFormacion(conjuntos) {
		formaciones.add(conjuntos)
	}

	method conjuntoDeVagonesPesados() {
		return formaciones.map{ vagones => vagones.vagonesPesados() }
	}

	method necesitaConductorExperimentado() {
		return formaciones.any{ unaFormacion => unaFormacion.formacionCompleja() }
	}

	method formacionMovilisada(formacion, locomotora) {
		if (formacion.podesMoverte()) {
		} else if (self.locomotoraSuelta(formacion, locomotora)) {
			formacion.agregarlocomotoras(locomotora)
		}
	}

	method locomotoraSuelta(formacion, locomotora) {
		return locomotora.arrastreUtil() >= formacion.kilosQueFaltaParaMoverse()
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
		return vagones.count{ unVagon => self.esLiviano(unVagon) }
	}

	method esLiviano(unVagon) {
		return unVagon.pesoMaximo() < 2500
	}

	method velocidadMaxima() = self.velocidadMaximaLocomotora().min(self.velocidadMaximaLegal())

	method velocidadMaximaLegal()

	method velocidadMaximaLocomotora() {
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

	method formacionCompleja() {
		return (locomotoras.size() + vagones.size()) > 20 or self.sumaTotalDeFormacion() > 10000
	}

	method cantidadDePasajeros() {
		return vagones.sum{ unVagon => unVagon.cantidadDePasajerosALlevar() }
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

class VagonPasajeros {

	var property largoEnMetros = 1
	var property anchoUtilEnMetros = 1
	var property cantidadDeBanios = 1

	method cantidadDePasajerosALlevar() {
		if (anchoUtilEnMetros < 2.5) {
			return largoEnMetros * 8
		} else return largoEnMetros * 10
	}

	method pesoMaximo() {
		return self.cantidadDePasajerosALlevar() * 80
	}

}

class VagonCarga {

	var property cargaMaxima = 1

	method cantidadDePasajerosALlevar() = 0

	method pesoMaximo() {
		return cargaMaxima + 160
	}

	method cantidadDeBanios() = 0

}

class CortaDistancia inherits Formacion {

	method estaBienArmada() = self.podesMoverte() and not self.formacionCompleja()

	override method velocidadMaximaLegal() = 60

}

class LargaDistancia inherits Formacion {

	const origen = null
	const destino = null

	method estaBienArmada() = self.podesMoverte() and self.tieneSuficientesBanios()

	method tieneSuficientesBanios() = self.cantidadDeBanios() >= self.cantidadDePasajeros() / 50

	method cantidadDeBanios() = vagones.sum{ vagon => vagon.cantidadDeBanios() }

	override method velocidadMaximaLegal() = if (origen.esGrande() and destino.esGrande()) 200 else 150

}

class Ciudad {

	const property esGrande = false

}

class FormacionAltaVelocidad inherits LargaDistancia {

	override method estaBienArmada() {
		return super()and self.velocidadMaxima() >= 250 and vagones.all{ unVagon => self.esLiviano(unVagon) }
	}

	override method velocidadMaximaLegal() = 400

}

