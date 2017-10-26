import Scenery;

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
	
	var nivel:Number = 0;
	
	var scenery:Scenery;
	
	var puntajeTextField:TextField
	
	/**
	*Constructor, Metodo que se ejectua al instanciar por primera vez el objeto
	*/
	public function Manager(mainMc:MovieClip) {
		this.mainMc = mainMc;
		this.demonios = new Object();
		this.nombres = new Array();
		
		//Inicio el escenario
		this.scenery = new Scenery(mainMc);
		this.scenery.cargarFondo(this.nivel);
		
		//Puntaje
		this.iniciarPuntaje();
		
	}
	
	public function iniciarPuntaje(){
		this.puntajeTextField = this.mainMc.createTextField("puntaje", 500, 450, 5, 100, 32);
		this.puntajeTextField.textColor = 0xec5c5c;
		var myformat:TextFormat = new TextFormat(); 
		myformat.size = 30; 
		this.puntajeTextField.setNewTextFormat(myformat);
	}
	
	public function cambiarNivel(){
		this.nivel++;
		this.scenery.cargarFondo(this.nivel);
	}
	

	public function sumarPuntos(nuevosPuntos:Number){
		//Calculo el nuevo puntaje
		this.puntaje = this.puntaje + nuevosPuntos;
		//Actualizo la caja en pantalla
		this.puntajeTextField.text = this.puntaje.toString();
		
		if(this.puntaje > 500 and this.nivel == 0){
			this.cambiarNivel();
		}
		if(this.puntaje > 1500 and this.nivel == 1){
			this.cambiarNivel();
		}
		
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
		//Removemos Fondo
		this.scenery.limpiarFondo();
		
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
