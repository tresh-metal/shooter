class Manager{
		
	//MovieClip Principal
	var mainMc:MovieClip;
	
	//Objeto de Demonios
	var demonios:Object;
	
	//Array de Demonios
	var nombres:Array;
		
	public function Manager(mainMc:MovieClip){
		this.mainMc = mainMc;
		this.demonios = new Object();
		this.nombres = new Array();
	}
	
	//El metodo "iniciar" será el encargado de invocar los esbirros
	public function iniciar(){
		this.invocarDemonio("D1",1);
		this.invocarDemonio("D2",150);
		this.invocarDemonio("D3",300);
	}
	
	//El metodo "invocarDemonio" instancia un objeto del tipo demonio y lo inicia en el escenario
	public function invocarDemonio(nombre:String,initX:Number){
		
		//Instancio un nuevo demonio y lo almaceno en la coleccion "demonios"
		this.demonios[nombre] = new Daemon(this.mainMc,nombre,initX);
		
		//Guardo el nombre del demonio en un array para recorrerlo mas adelante
		this.nombres.push(nombre);
		
		//Inicializo el demonio (Carga el demonio.swf sobre el escenario)
		this.demonios[nombre].iniciar();
	}
	
	//El metodo "moverEsbirros" se encargara de hacer avanzar (mover) a todos los esbirros
	public function moverEsbirros(){
		//Uso un For para  recorrer todos los demonios y moverlos
		for(var i:Number = 0; i < this.nombres.length; i++){
		var nombre:String = this.nombres[i];
		this.demonios[nombre].mover();
		}
	}
	
	

	
}