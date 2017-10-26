
class Scenery {
	
	//MovieClip Principal
	var mainMc:MovieClip;
	
	//Declaro una variable que contenga mi MovieClip para Daemon
	public var mc:MovieClip;
	
	//Defino un objeto que contiene los diferentes escenarios
	var backgrounds:Array = new Array("background/Fondo1.swf","background/Fondo2.swf","background/Fondo3.swf","background/Fondo4.swf","background/Fondo6.swf","background/Fondo5.swf");
	
	var nombreNivelActual:String;
	
	//Loader para cargar los diferentes escenarios
	public var loader:MovieClipLoader;
	
	public function Scenery(mainMc:MovieClip){
		this.mainMc = mainMc;
	}
	
	public function getLoader() {
		this.loader = new MovieClipLoader();
		//this.loader.addListener(new LoadListener(this));
		return this.loader;
	}
	
	
	public function cargarFondo(nivel:Number) {
		this.nombreNivelActual = "Nivel" + nivel.toString();
		this.mc = this.mainMc.createEmptyMovieClip(this.nombreNivelActual,1);
		this.getLoader().loadClip(this.backgrounds[nivel], this.mc);
		this.mainMc.addChild(this.mc);
	}
	
	public function limpiarFondo(){
		this.mainMc.removeChild(this.mc);
		this.mc.removeMovieClip();
		
	}
	
	
}
	
	
	
	