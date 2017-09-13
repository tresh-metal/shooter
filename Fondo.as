import LoadListener;

	class Fondo{
	
	
	//Declaro una variable MovieClipLoader y le instacio un objeto MovieClipLoader
	var mcLoader:MovieClipLoader;
	
	//Declaro una variable que referencia el MovieClip Principal
	var MainMc:MovieClip;
	
	//Declaro una variable que contenga mi MovieClip para Daemon
	var mc:MovieClip;
	
	public function Fondo(pmc:MovieClip){
		this.MainMc = pmc;
	}
	
	function iniciar(){
	
	this.mcLoader = new MovieClipLoader();
	
	//Le pido al MainMc genera un nuevo MovieClip y se lo asigno a mc
	this.mc = this.MainMc.createEmptyMovieClip("mc", MainMc.getNextHighestDepth()); 
	
	//Utilizo mcLoader para cargar el movieClip deseado sobre la variable "mc" la cual es un movieClip (vacio)
	mcLoader.loadClip("swf/Fondo.swf", mc);

	}
	
	
	
}