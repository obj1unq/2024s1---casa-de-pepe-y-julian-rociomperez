// LA CASA DE PEPE Y JULIAN

object casaDePepeYJulian {
	
	var viveres = 50
	var necesitaReparaciones = false

	method viveresSuficientes() {
		return viveres > 40
	}
	
	method viveres() {
		return viveres 
	}
	
	method viveres(_viveres) {
		viveres = _viveres
	}
	
	method comprarViveres(_porcentajeAComprar) {
		viveres += _porcentajeAComprar
	}

	method necesitaReparaciones() {
		return necesitaReparaciones
	}
	
	method necesitaReparaciones(_necesitaReparaciones) {
		necesitaReparaciones = _necesitaReparaciones
	}	
		
	method estaEnOrden() {
		return self.viveresSuficientes() and self.necesitaReparaciones()
	}
}

// CUENTA PEPE Y JULIAN

object cuentasPepeYJulian {
	
	var cuentaAsignada = cuentaCorriente
	
	method cuentaAsignada(_cuentaAsignada) {
		cuentaAsignada = _cuentaAsignada
	}
	
	method cuentaAsignada() {
		return cuentaAsignada
	}
	
	method extraerParaGastos(_dinero) {
		cuentaAsignada.extraer(_dinero)
	}
	
}

// CUENTAS BANCARIAS

object cuentaCorriente {
	
	var saldo = 0
	
	method saldo() {
		return saldo
	}
	
	method saldo(_saldo) {
		saldo = _saldo
	}
	
	method depositar(_dinero) {
		saldo += _dinero
	}
	
	method extraer(_dinero) {
		saldo -= _dinero
	}
	
}
	
object cuentaConGastos {

	var saldo = 0
	var costoOperacion = 0
	
	method saldo() {
		return saldo
	}
	
	method depositar(_dinero) {
		saldo += _dinero - costoOperacion
	}
	
	method costoOperacion(_costoOperacion) {
		costoOperacion = _costoOperacion
	}	
	
	method extraer(_dinero) {
		saldo -= _dinero
	}
	
}

object cuentaCombinada {
	
	var cuentaPrimaria = cuentaCorriente
	var cuentaSecundaria = cuentaCorriente
	
	method saldo() {
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
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
		if (cuentaPrimaria.saldo() >= _dinero) {
			cuentaPrimaria.extraer(_dinero)
		}
		else {
			cuentaSecundaria.extraer(_dinero)
		}
	}
	
}

// ESTRATEGIAS DE AHORRO

object minimo {
	
	var calidad = 0
	
	method comprarViveres(_casa) {
		if (not _casa.viveresSuficientes()) {
			_casa.comprarViveres(self.porcentajeAComprar(_casa) * calidad)
		} 
		else {}
	}
	
	method porcentajeAComprar(_casa) {
		return 40 - _casa.viveres()
	}
	
	method calidad(_calidad) {
		calidad = _calidad
	}
	
	

}


object full {
	
}
