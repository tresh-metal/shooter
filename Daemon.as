import LoadListener;

	class Daemon{
	
	//Declaro una variable loadListener y le instancio un objeto LoadListener
	public var loadListener:LoadListener;
	
	//Declaro una variable MovieClipLoader y le instacio un objeto MovieClipLoader
	public var mcLoader:MovieClipLoader;
	
	//Declaro una variable que referencia el MovieClip Principal
	var MainMc:MovieClip;
	
	//Declaro una variable que contenga mi MovieClip para Daemon
	public var mc:MovieClip;
	
	public var myPoint:Object;
	
	public function Daemon(pmc:MovieClip){
		this.MainMc = pmc;
	}
	
	function iniciar(name:String,xx:Number,yy:Number){
	this.myPoint = {x:10, y:10};
	
	this.loadListener  = new LoadListener(xx,yy);
	this.mcLoader = new MovieClipLoader();
		
	//Agrego al objeto MovieClipLoader un Listener que envia info a la consola
	mcLoader.addListener(loadListener);
	
	//Le pido al MainMc genera un nuevo MovieClip y se lo asigno a mc
	this.mc = this.MainMc.createEmptyMovieClip(name, MainMc.getNextHighestDepth()); 
	
	this.mc.localToGlobal(this.myPoint);
	
	//Utilizo mcLoader para cargar el movieClip deseado sobre la variable "mc" la cual es un movieClip (vacio)
	mcLoader.loadClip("swf/Bicho.swf", mc);

	}
	
}
