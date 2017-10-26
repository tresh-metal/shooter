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
	//Acumula el puntaje obtenido
	var puntaje:Number = 0;
	//Nivel de escenario y dificultad	
	var nivel:Number = 0;
	//Objeto que maneja los escenarios
	var scenery:Scenery;
	
	//InputField para mostrar el puntaje en pantalla
	var puntajeTextField:TextField;
	
	
	//Informa el Nivel
	var nivelTextField:TextField;
	
	//Informa el porcentaje de esquivar
	var esquivarTextField:TextField;
	
	//Informa el porcentaje de invocacion
	var invocacionTextField:TextField;
	
	
	//Porcentaje de invacacion. Esto define las probabilidades por ciclo de que se invoque un esbirro. 
	//A mayor porcentaje, se invocaran demonios mas rapidamente
	var porcentajeInvocacion:Number = 5;
	//Nivel de esquivar. Porcentaje que define la probabilidad de esquivar de un esbirro
	var porcentajeEsquivar:Number = 35;
	//Cantidad de esbirros maxiama
	var cantidadEsbirrosMaxima:Number = 500;
	
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
		
		//Inicio textField informativos
		this.iniciarInformacion();
		
	}
	
	public function iniciarInformacion(){
		//Formato del TextField
		var myformat:TextFormat = new TextFormat(); 
		myformat.size = 18; 
		
		//Inicio el textField que informa el nivel de la partida
		this.nivelTextField = this.mainMc.createTextField("nivel", 800, 5, 370, 100, 20);
		this.nivelTextField.textColor = 0xF7FE2E;
		this.nivelTextField.setNewTextFormat(myformat);
		this.nivelTextField.text = "Nivel: " + this.nivel;
		
				//Inicio el textField que informa el porcentaje de  esquivar actual
		this.esquivarTextField = this.mainMc.createTextField("esquivar", 801, 445, 370, 50, 20);
		this.esquivarTextField.textColor = 0xF7FE2E;
		this.esquivarTextField.setNewTextFormat(myformat);
		this.esquivarTextField.text = "E: " + this.porcentajeEsquivar;
		
				//Inicio el textField que informa el nivel de invocacion
		this.invocacionTextField = this.mainMc.createTextField("invocacion", 802, 500, 370, 50, 20);
		this.invocacionTextField.textColor = 0xF7FE2E;
		this.invocacionTextField.setNewTextFormat(myformat);
		this.invocacionTextField.text = "I: " + this.porcentajeInvocacion;
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
		//Cada vez que sube el nivel aumento el porcentaje de invocacion (probabilidad de mas demonios)
		this.porcentajeInvocacion = this.porcentajeInvocacion + 2;
		//Aumento el porcentaje de esquivar
		this.porcentajeEsquivar = this.porcentajeEsquivar + 5;		
		//Informo el nuevo nivel
		this.nivelTextField.text = "Nivel: " + this.nivel;
		this.esquivarTextField.text = "E: " + this.porcentajeEsquivar + "%";
		this.invocacionTextField.text = "I: " + this.porcentajeInvocacion + "%";
		this.scenery.cargarFondo(this.nivel);
	}
	

	public function sumarPuntos(nuevosPuntos:Number){
		//Calculo el nuevo puntaje
		this.puntaje = this.puntaje + nuevosPuntos;
		//Actualizo la caja en pantalla
		this.puntajeTextField.text = this.puntaje.toString();
		
		//Sube a nivel 1
		if(this.puntaje > 500 and this.nivel == 0){
			this.cambiarNivel();
		}
		//Sube a nivel 2
		if(this.puntaje > 1500 and this.nivel == 1){
			this.cambiarNivel();
		}
		//Sube a nivel 3
		if(this.puntaje > 2500 and this.nivel == 2){
			this.cambiarNivel();
		}
		//Sube a nivel 4
		if(this.puntaje > 3500 and this.nivel == 3){
			this.cambiarNivel();
		}
		//Sube a nivel 5
		if(this.puntaje > 4500 and this.nivel == 4){
			this.cambiarNivel();
		}
		//GameOver (Faltaria jefe final)
		if(this.puntaje > 6000 and this.nivel == 5){
			this.gameOverNow();
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
	
	//Metodo invocado por cada ciclo para ver si se genera un demonio
	public function generarDemoniosRandom() {
		//Genero un numero random entre 1 y 100
		var numeroRandom = this.randRange(1, 100);
		//Si el numero que se genero, es menor al porcentajeInvocacion, entonces invoco un demonio
		if (numeroRandom<this.porcentajeInvocacion and this.numeroDemonio<this.cantidadEsbirrosMaxima) {
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
	//El metodo "moverEsbirros" se encargara de generar los ciclos, donde pueden:
	//1. hacer avanzar (mover) a todos los esbirros
	//2. Invocar un nuevo esbirro (Mediante probabilidad random que aumenta segun el nivel)
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
