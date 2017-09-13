class LoadListener{
	
	var xx:Number;
	var yy:Number;
	
	public function LoadListener(xx:Number,yy:Number){
		this.xx = xx;
		this.yy = yy;
	}
	
	function onLoadComplete(target_mc:MovieClip, httpStatus:Number):Void {
	target_mc.content.width = 150;
    target_mc.content.height = 150;
	target_mc._x = this.randRange(10,300);
	target_mc._y = 0;
	}
	
	function onLoadInit(target_mc:MovieClip):Void {
		
	}
	
	function randRange(min:Number, max:Number):Number { 
    var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min; 
    return randomNum; 
	} 

}