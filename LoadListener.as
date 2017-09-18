class LoadListener{
	
	var daemon:Daemon;
	public function LoadListener(daemon:Daemon){
		this.daemon = daemon;
	}
	
	function onLoadComplete(target_mc:MovieClip, httpStatus:Number):Void {
		//SCOPE
		var home:LoadListener = this;
		
		//this.daemon.startup(target_mc);
		
		target_mc.onRelease = function(){
			home.daemon.hit();
		}		
	}
	
	function onLoadInit(target_mc){
		this.daemon.startup();
	}


}