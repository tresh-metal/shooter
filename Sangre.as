import LoadListener;
class Sangre {

	//Declaro una variable MovieClipLoader y le instacio un objeto MovieClipLoaderm, para poder cargar la animacion 
	public var loader:MovieClipLoader;
	
	//MovieClip Principal
	var mainMc:MovieClip;
	
	//Declaro una variable que contenga mi MovieClip para Daemon
	public var mc:MovieClip;
	
	private var initX:Number;
	private var initY:Number;
	
	//Metodo constructor que recibe como parametros el "Nombre" del demonio y el MovieClip Principal
	public function Sangre(mainMc:MovieClip) {
		this.mainMc = mainMc;
		this.initX = 0;
		this.initY = 0;
	}
	
	public function getLoader() {
		this.loader = new MovieClipLoader();
		//this.loader.addListener(new LoadListener(this));
		return this.loader;
	}
	
	public function iniciar() {
		//Le pido al MainMc genera un nuevo MovieClip y se lo asigno a mc
		this.mc = this.mainMc.createEmptyMovieClip("sangre", mainMc.getNextHighestDepth());
		
		//Utilizo el loader para cargar el movieClip deseado sobre la variable "mc" la cual es un movieClip (vacio)
		this.getLoader().loadClip("swf/sangre.swf", mc);
		//Agrego el MovieClip del "Esbirro" al MovieClip "Principal"
		this.mainMc.addChild(this.mc);
	}


}
