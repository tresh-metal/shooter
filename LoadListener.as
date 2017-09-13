class LoadListener{
	
	var o:Daemon;
	public function LoadListener(o){
		this.o = o;
	}
	
	function onLoadComplete(target_mc:MovieClip, httpStatus:Number):Void {
		//SCOPE
		var home:LoadListener = this;
		target_mc.onRelease = function(){
			home.o.hit();
		}		
	}


}