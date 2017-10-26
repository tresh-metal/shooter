import LoadListener;
class Daemon {

	public static var MAXWIDTH:Number = 200;
	public static var MAXHEIGHT:Number = 150;
	//Esta propiedad live, define si el demonio esta vivo o muerto
	private var live:Boolean;
	//Inyecto el Manager a los Demonios
	private var manager:Manager;
	//Define un nombre unico del Demonio
	private var nombre:String;
	//Declaro una variable MovieClipLoader y le instacio un objeto MovieClipLoaderm, para poder cargar la animacion 
	public var loader:MovieClipLoader;
	//MovieClip Principal
	var mainMc:MovieClip;
	//Declaro una variable que contenga mi MovieClip para Daemon
	public var mc:MovieClip;
	private var initX:Number;
	private var initY:Number;
	private var numeroRandom:Number;
	//Metodo constructor que recibe como parametros el "Nombre" del demonio y el MovieClip Principal
	public function Daemon(manager:Manager, mainMc:MovieClip, nombre:String, initX:Number) {
		this.manager = manager;
		this.mainMc = mainMc;
		this.nombre = nombre;
		this.initX = initX;
		this.initY = 0;
		this.live = true;
		this.numeroRandom = this.randRange(1, 7);
	}
	public function getLoader() {
		this.loader = new MovieClipLoader();
		this.loader.addListener(new LoadListener(this));
		return this.loader;
	}
	public function iniciar() {
		//Le pido al MainMc genera un nuevo MovieClip y se lo asigno a mc
		this.mc = this.mainMc.createEmptyMovieClip(this.nombre, mainMc.getNextHighestDepth());
		
		//Defino de forma random que esbirro invocar
		var esbirroRandom = this.randRange(1,2);
		
		//Utilizo el loader para cargar el movieClip deseado sobre la variable "mc" la cual es un movieClip (vacio)
		switch (esbirroRandom) {
			case 1:
			this.getLoader().loadClip("swf/Ghost.swf", this.mc);
			break;
			case 2:
			this.getLoader().loadClip("swf/Bicho.swf", this.mc);
			break;
			default :
			this.getLoader().loadClip("swf/Bicho.swf", this.mc);
			break;
		}
		
		//Agrego el MovieClip del "Esbirro" al MovieClip "Principal"
		this.mainMc.addChild(this.mc);
		
	}
	public function startup(target_mc) {
		//Defino la posicion x Inicial
		this.mc._x = this.initX;
		this.mc._y = this.initY;
		//Defino el tamaño inicial
		this.mc._width = 20;
		this.mc._height = 20;
	
		 this.mc._rotation = 0;
		 this.mc.swapDepths(100);
	}
	
	public function clean(){
			//El esbirro se elimina del escenario
			this.live = false;
			this.mainMc.removeChild(this.mc);	
			this.mc.removeMovieClip();
				
	}
	
	
	//Si hacen HIT sobre el MovieClip lo remuevo (Muere el esbirro)
	public function hit() {
		
		var posibilidadDeEsquivar:Number = this.randRange(1,100);
		
		if(posibilidadDeEsquivar > this.manager.porcentajeEsquivar){
			//Sumamos puntos
			this.manager.sumarPuntos(this.mc._y);
			
			//El esbirro Muere
			this.live = false;
			this.mc.removeMovieClip();
			this.mainMc.removeChild(this.mc);
			
		}else{
			//El esbirro esquiva
			this.mc.gotoAndPlay(16);
		}
		
	}
	//El metodo "mover" mueve el esbirro hacia el jugador
	public function mover() {
		//Verifico si el esbirro esta en el eje Y por debajo de 200 pixeles
		//En caso positivo, lo muevo 15 pixeles hacia abajo
		//En caso Negativo, quiere decir que llego al final y deberia invocar al metodo "Pegar al Jugador" 
		if (this.mc._y<250) {
			this.mc._y = this.mc._y+this.numeroRandom;
		} else {
			//Resto Vida
			if (this.live) {
				this.manager.solicitarMenosVida();
				this.clean();
			}
		}
		//Codigo para incrementar el tamaño del demonio
		if (this.mc._width<Daemon.MAXWIDTH) {
			this.mc._width = this.mc._width+this.numeroRandom;
		}
		if (this.mc._height<Daemon.MAXHEIGHT) {
			this.mc._height = this.mc._height+this.numeroRandom;
		}
	}
	//Funcion para generar un numero random entre min y max
	function randRange(min:Number, max:Number):Number {
		var randomNum:Number = Math.floor(Math.random()*(max-min+1))+min;
		return randomNum;
	}
}
