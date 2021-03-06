import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image() {
		// reeemplazarlo por los distintos colores de acuerdo a la cantidad de infectados
		// también vale reemplazar estos dibujos horribles por otros más lindos
		return "blanco.png"
	}
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}
	
	method moverDerecha() { self.position(self.position().right(1)) }
	method moverIzquierda() { self.position(self.position().left(1)) }
	method moverArriba() { self.position(self.position().up(1)) }
	method moverAbajo() { self.position(self.position().down(1)) }

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		// despues agregar la curacion
	}
	
	method personaSeMudaA(persona, manzanaDestino) {
		// implementar
	}
	
	method cantidadContagiadores() {
		return 0
		// reemplazar por la cantidad de personas infectadas que no estan aisladas
	}
	
	method noInfectades() {
		return personas.filter({ pers => not pers.estaInfectada() })
	}
	
	method cantidadGente(){ return personas.size() }
	
	method cantInfectados() {
		return (self.cantidadGente() - self.noInfectades().size())
	} 	 	
	
	method cantidadInfectadosNoAislados(){
		const noAislados = personas.filter ({pers => pers.estaInfectada()})
		return (noAislados.count({pers => not pers.estaAislada()}))
	}
	
	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores)) {
					persona.infectarse()
				}
			})
		}
	}
	
	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	
	method agregarGente(newPerson){
		personas.add(newPerson)
	}
}
