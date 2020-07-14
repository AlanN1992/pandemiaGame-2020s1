class Persona {
	var property estaAislada = false
	var property respetaCuarentena = false 
	var infectada = false

	
	method estaInfectada() {
		return infectada
		// implementar
	}
	
	method infectarse() {
		infectada = true
		// implementar 
	}
	
	method diaInfectado(dia){
		return dia
	}
}

