// LA CASA DE PEPE Y JULIAN
object casaDePepeYJulian {

	var viveres = 50
	var gastoEnReparaciones = 0
	var property estrategiaDeAhorro = full

	method viveres() {
		return viveres
	}

	method viveresSuficientes() {
		return self.viveres() > 40
	}

	method necesitaReparaciones() {
		return gastoEnReparaciones > 0
	}

	method gastoEnReparaciones(_gastoEnReparaciones) {
		gastoEnReparaciones = _gastoEnReparaciones
	}

	method gastoEnReparaciones() {
		return gastoEnReparaciones
	}

	method estaEnOrden() {
		return self.viveresSuficientes() and not self.necesitaReparaciones()
	}

	method mantenerLaCasa() {
		self.estrategiaDeAhorro().realizarMantenimiento()
	}

	method comprarViveres(porcentaje) {
		viveres += porcentaje
		cuentasDePepeYJulian.extraerParaGastos(self.gastoEnViveres(porcentaje))
	}

	method gastoEnViveres(porcentaje) {
		return porcentaje * self.estrategiaDeAhorro().calidad()
	}

	method pagarReparaciones() {
		cuentasDePepeYJulian.extraerParaGastos(gastoEnReparaciones)
		gastoEnReparaciones = 0
	}

}

// CUENTA PEPE Y JULIAN
object cuentasDePepeYJulian {

	var cuentaParaGastos = cuentaCorriente

	method cuentaParaGastos(_cuentaParaGastos) {
		cuentaParaGastos = _cuentaParaGastos
	}

	method cuentaParaGastos() {
		return cuentaParaGastos
	}

	method extraerParaGastos(_dinero) {
		self.cuentaParaGastos().extraer(_dinero)
	}

	method depositarParaGastos(_dinero) {
		self.cuentaParaGastos().depositar(_dinero)
	}

}

// CUENTAS BANCARIAS
object cuentaCorriente {

	var dinero = 0

	method dinero() {
		return dinero
	}

	method dinero(_dinero) {
		dinero = _dinero
	}

	method depositar(_dinero) {
		dinero += _dinero
	}

	method extraer(_dinero) {
		dinero -= _dinero
	}

}

object cuentaGastos {

	var dinero = 0
	var property costoDeOperacion = 0

	method dinero() {
		return dinero
	}

	method dinero(_dinero) {
		dinero = _dinero
	}

	method depositar(_dinero) {
		dinero += (_dinero - costoDeOperacion)
	}

	method extraer(_dinero) {
		dinero -= _dinero
	}

}

object cuentaCombinada {

	var cuentaPrimaria = cuentaCorriente
	var cuentaSecundaria = cuentaGastos

	method dinero() {
		return cuentaPrimaria.dinero() + cuentaSecundaria.dinero()
	}

	method cuentaPrimaria(_cuentaPrimaria) {
		cuentaPrimaria = _cuentaPrimaria
	}

	method cuentaSecundaria(_cuentaSecundaria) {
		cuentaSecundaria = _cuentaSecundaria
	}

	method depositar(_dinero) {
		cuentaPrimaria.depositar(_dinero)
	}

	method extraer(_dinero) {
		if (cuentaPrimaria.dinero() >= _dinero) {
			cuentaPrimaria.extraer(_dinero)
		} else {
			cuentaSecundaria.extraer(_dinero)
		}
	}

}

// ESTRATEGIAS DE AHORRO
object minimo {

	var property calidad = 0

	method realizarMantenimiento() {
		if (not casaDePepeYJulian.viveresSuficientes()) {
			casaDePepeYJulian.comprarViveres(self.porcentajeAComprar())
		}
	}

	method porcentajeAComprar() {
		return 40 - casaDePepeYJulian.viveres()
	}

}

object full {

	const property calidad = 5

	method realizarMantenimiento() {
		if (casaDePepeYJulian.estaEnOrden()) {
			casaDePepeYJulian.comprarViveres(self.porcentajeALlenarViveres())
			self.mantenimientoEnReparaciones()
		} else {
			casaDePepeYJulian.comprarViveres(40)
			self.mantenimientoEnReparaciones()
		}
	}

	method porcentajeALlenarViveres() {
		return 100 - casaDePepeYJulian.viveres()
	}

	method mantenimientoEnReparaciones() {
		if (self.alcanzaParaReparaciones()) {
			casaDePepeYJulian.pagarReparaciones()
		}
	}

	method alcanzaParaReparaciones() {
		return (cuentasDePepeYJulian.cuentaParaGastos().dinero() - casaDePepeYJulian.gastoEnReparaciones()) > 1000
	}

}

