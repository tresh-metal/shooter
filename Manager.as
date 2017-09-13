class Manager{
		
	//MovieClip Principal
	var mainMc:MovieClip;
	
	//Objeto de Demonios
	var demonios:Object;
	
	//Array de Demonios
	var nombres:Array;
	
	var d:Daemon;
	
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
		this.demonios[nombre] = new Daemon(nombre,this.mainMc);
		this.nombres.push(nombre);
		this.demonios[nombre].iniciar(initX);
	}
	
	//El metodo "moverEsbirros" se encargara de hacer avanzar (mover) a todos los esbirros
	public function moverEsbirros(){
		for(var i:Number = 0; i < this.nombres.length; i++){
		var nombre:String = this.nombres[i];
		this.demonios[nombre].mover();
		}
	}
	
	

	
}