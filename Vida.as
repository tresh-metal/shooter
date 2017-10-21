import LoadListener;
class Vida {

	//Declaro una variable MovieClipLoader y le instacio un objeto MovieClipLoaderm, para poder cargar la animacion 
	public var loader:MovieClipLoader;
	
	//MovieClip Principal
	var mainMc:MovieClip;
	
	//Declaro una variable que contenga mi MovieClip para Daemon
	public var mc:MovieClip;
	
	private var initX:Number;
	private var initY:Number;
	
	//Esta propiedad define la vida del jugador
	var vida:Number;
	
	var fotograma:Number;
	
	//Inyecto el Manager a los Demonios
	private var manager:Manager;

	
	//Metodo constructor que recibe como parametros el "Nombre" del demonio y el MovieClip Principal
	public function Vida(mananger:Manager,mainMc:MovieClip) {
		this.mainMc = mainMc;
		this.manager= mananger;
		this.initX = 0;
		this.initY = 0;
		this.vida = 3;
		this.fotograma = 1;
	}
	
	public function getLoader() {
		this.loader = new MovieClipLoader();
		//this.loader.addListener(new LoadListener(this));
		return this.loader;
	}
	
	public function clean(){
		this.mainMc.removeChild(this.mc);	
			this.mc.removeMovieClip();
	}
	
	public function iniciar() {
		//Le pido al MainMc genera un nuevo MovieClip y se lo asigno a mc
		this.mc = this.mainMc.createEmptyMovieClip("vida", mainMc.getNextHighestDepth());
		
		//Utilizo el loader para cargar el movieClip deseado sobre la variable "mc" la cual es un movieClip (vacio)
		this.getLoader().loadClip("swf/vida.swf", mc);
		//Agrego el MovieClip del "Esbirro" al MovieClip "Principal"
		this.mainMc.addChild(this.mc);
	}
	
	public function startup(){
	}
	
	public function menosVida(){
		//Resto vida
		if(this.vida > 0){
		this.vida = this.vida - 1;
		
		this.fotograma = this.fotograma + 1;
		
		//Muevo 1 el fotrograma
		this.mc.gotoAndPlay(this.fotograma);
		
		}
		//Cuando la vida es 0 ejecuto gameOver
		if(this.vida == 0){
			this.manager.gameOverNow();
		}
	}

}
