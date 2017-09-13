import LoadListener;

	class Daemon{
	
	//Define un nombre unico del Demonio
	private var nombre:String;
	
	//Declaro una variable MovieClipLoader y le instacio un objeto MovieClipLoader
	public var loader:MovieClipLoader;
	
	//MovieClip Principal
	var mainMc:MovieClip;
	
	//Declaro una variable que contenga mi MovieClip para Daemon
	public var mc:MovieClip;
	
	private var initX:Number;
	private var initY:Number;
	
	//Metodo constructor que recibe como parametros el "Nombre" del demonio y el MovieClip Principal
	public function Daemon(nombre:String, mainMc:MovieClip){
		this.nombre = nombre;
		this.mainMc = mainMc;
	}
	
	public function getLoader(){
		this.loader = new MovieClipLoader();
		return this.loader;
	}
	
	public function iniciar(initX:Number){
	
		this.initX = initX;
		
		//Le pido al MainMc genera un nuevo MovieClip y se lo asigno a mc
		this.mc = this.mainMc.createEmptyMovieClip(this.nombre, mainMc.getNextHighestDepth()); 
	
		this.mc._x = this.initX;
	
		//Utilizo el loader para cargar el movieClip deseado sobre la variable "mc" la cual es un movieClip (vacio)
		this.getLoader().loadClip("swf/Bicho.swf", mc);
	
		//Agrego el MovieClip del "Esbirro" al MovieClip "Principal"
		this.mainMc.addChild(this.mc);
	
	}
	
	//El metodo "mover" mueve el esbirro hacia el jugador
	public function mover(){
		
		//Verifico si el esbirro esta en el eje Y por debajo de 200 pixeles
		//En caso positivo, lo muevo 15 pixeles hacia abajo
		//En caso Negativo, quiere decir que llego al final y deberia invocar al metodo "Pegar al Jugador" 
		if(this.mc._y < 250){
			this.mc._y = this.mc._y + 15;
		}
	}

	
}
