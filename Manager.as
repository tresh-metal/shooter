class Manager {
	//MovieClip Principal
	var mainMc:MovieClip;
	//Objeto de Demonios
	var demonios:Object;
	//Array de Demonios
	var nombres:Array;
	var numeroDemonio:Number = 1;
	//Vida
	var vida:Vida;
	//Define si el juego Termino
	var gameOver:Boolean = false;
	
	var puntaje:Number = 0;
	
	var puntuacionPantalla:TextField; 
	
	public function setPuntuacionPantalla(param_puntuacion:TextField){
		this.puntuacionPantalla = param_puntuacion;
	}
	
	public function sumarPuntos(nuevosPuntos:Number){
		//Calculo el nuevo puntaje
		this.puntaje = this.puntaje + nuevosPuntos;
		//Actualizo la caja en pantalla
		this.puntuacionPantalla.text = this.puntaje.toString();
		
	}
	
	public function Manager(mainMc:MovieClip) {
		this.mainMc = mainMc;
		this.demonios = new Object();
		this.nombres = new Array();
	}
	//El metodo "iniciar" será el encargado de invocar los esbirros
	public function iniciar() {
		//Inicio la Vida
		this.iniciarVida();
		//Invoco Demonios
		this.invocarDemonio();
	}
	public function iniciarVida() {
		this.vida = new Vida(this, this.mainMc);
		this.vida.iniciar();
	}
	public function solicitarMenosVida() {
		this.vida.menosVida();
		this.sangrar();
	}
	public function sangrar() {
		var sangre = new Sangre(this.mainMc);
		sangre.iniciar();
	}
	public function gameOverNow() {
		this.gameOver = true;
		this.cleanUp();
		gotoAndPlay(4);
	}
	
	public function cleanUp(){
		
		//Removemos la vida
		this.vida.clean();
		
		//Removemos demonios
		for (var i:Number = 0; i<this.nombres.length; i++) {
				var nombre:String = this.nombres[i];
				this.demonios[nombre].clean();
			}
		
	}
	
	public function generarDemoniosRandom() {
		//Genero un numero random entre 1 y 100
		var numeroRandom = this.randRange(1, 100);
		//Si el numero que se genero, es mayor a 50, entonces invoco un demonio
		if (numeroRandom>95 and this.numeroDemonio<30) {
			this.invocarDemonio();
		}
	}
	//El metodo "invocarDemonio" instancia un objeto del tipo demonio y lo inicia en el escenario
	public function invocarDemonio() {
		//Genero el nombre del demonio
		var nombre:String = "Demonio"+this.numeroDemonio;
		this.numeroDemonio++;
		//Genero una posicion inicial random
		var initX = this.randRange(1, 320);

		//Instancio un nuevo demonio y lo almaceno en la coleccion "demonios"
		this.demonios[nombre] = new Daemon(this, this.mainMc, nombre, initX);
		//Guardo el nombre del demonio en un array para recorrerlo mas adelante
		this.nombres.push(nombre);
		//Inicializo el demonio (Carga el demonio.swf sobre el escenario)
		this.demonios[nombre].iniciar();
	}
	//El metodo "moverEsbirros" se encargara de hacer avanzar (mover) a todos los esbirros
	public function moverEsbirros() {
		if (this.gameOver == false) {
			this.generarDemoniosRandom();
			//Uso un For para  recorrer todos los demonios y moverlos
			for (var i:Number = 0; i<this.nombres.length; i++) {
				var nombre:String = this.nombres[i];
				this.demonios[nombre].mover();
			}
		}
	}
	//Funcion para generar un numero random entre min y max
	function randRange(min:Number, max:Number):Number {
		var randomNum:Number = Math.floor(Math.random()*(max-min+1))+min;
		return randomNum;
	}
}
