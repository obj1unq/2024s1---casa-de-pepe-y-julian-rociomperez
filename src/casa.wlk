// LA CASA DE PEPE Y JULIAN
object casaDePepeYJulian {

	var viveres = 50
	var gastoEnReparaciones = 0
	var property cuentaAsignadaParaGastos = cuentaCorriente
	var property estrategiaDeAhorro = full

	method viveres() {
		return viveres
	}

	method viveresSuficientes() {
		return self.viveres() > 40
	}

	method necesitaReparaciones() {
		return self.gastoEnReparaciones() > 0
	}

	method aumentaGastoEnReparaciones(monto) {
		gastoEnReparaciones += monto
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
		self.estrategiaDeAhorro().realizarMantenimiento(self)
	}

	method comprarViveres(porcentaje) {
		viveres += porcentaje
		cuentaAsignadaParaGastos.extraer(self.dineroEnViveres(porcentaje))
	}

	method dineroEnViveres(porcentaje) {
		return porcentaje * self.estrategiaDeAhorro().calidad()
	}

	method pagarReparaciones() {
		cuentaAsignadaParaGastos.extraer(gastoEnReparaciones)
		gastoEnReparaciones = 0
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

	var property cuentaPrimaria = cuentaCorriente
	var property cuentaSecundaria = cuentaGastos

	method dinero() {
		return cuentaPrimaria.dinero() + cuentaSecundaria.dinero()
	}

	method depositar(_dinero) {
		self.cuentaPrimaria().depositar(_dinero)
	}

	method extraer(_dinero) {
		if (self.sePuedeExtraerEnCuentaPrimaria(_dinero)) {
			self.cuentaPrimaria().extraer(_dinero)
		} else {
			self.cuentaSecundaria().extraer(_dinero)
		}
	}
	
	method sePuedeExtraerEnCuentaPrimaria(_dinero) {
		return self.cuentaPrimaria().dinero() >= _dinero
	}

}

// ESTRATEGIAS DE AHORRO
object minimo {

	var property calidad = 0

	method realizarMantenimiento(casa) {
		if (not casa.viveresSuficientes()) {
			casa.comprarViveres(self.porcentajeAComprar(casa))
		}
	}

	method porcentajeAComprar(casa) {
		return 40 - casa.viveres()
	}

}

object full {

	const property calidad = 5

	method realizarMantenimiento(casa) {
		if (casa.estaEnOrden()) {
			casa.comprarViveres(self.porcentajeDeViveresALlenar(casa))
		} else {
			casa.comprarViveres(40)
		}
		self.mantenimientoEnReparaciones(casa)
	}

	method porcentajeDeViveresALlenar(casa) {
		return 100 - casa.viveres()
	}

	method mantenimientoEnReparaciones(casa) {
		if (self.alcanzaParaReparaciones(casa)) {
			casa.pagarReparaciones()
		}
	}

	method alcanzaParaReparaciones(casa) {
		return (casa.cuentaAsignadaParaGastos().dinero() - casa.gastoEnReparaciones()) > 1000
	}

}

// Si se agregan mas casas no es posible usar las estrategias de ahorro.
// Se podrian usar si en los metodos se usaria un parámetro casa (algo mas general) en vez de 
// invocar a una sola casa casaDePepeYJulian. 
// LA CASA DE PEPITA
object casaDePepita {

	var viveres = 70
	var gastoEnReparaciones = 100
	const property cuentaAsignadaParaGastos = cuentaCorriente
	var property estrategiaDeAhorro = minimo

	method viveres() {
		return viveres
	}

	method viveresSuficientes() {
		return self.viveres() > 40
	}

	method necesitaReparaciones() {
		return self.gastoEnReparaciones() > 0
	}

	method aumentaGastoEnReparaciones(monto) {
		gastoEnReparaciones += monto
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
		self.estrategiaDeAhorro().realizarMantenimiento(self)
	}

	method comprarViveres(porcentaje) {
		viveres += porcentaje
		cuentaAsignadaParaGastos.extraer(self.dineroEnViveres(porcentaje))
	}

	method dineroEnViveres(porcentaje) {
		return porcentaje * self.estrategiaDeAhorro().calidad()
	}

	method pagarReparaciones() {
		cuentaAsignadaParaGastos.extraer(gastoEnReparaciones)
		gastoEnReparaciones = 0
	}

}

