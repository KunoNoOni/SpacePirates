package
{
	import org.flixel.*;
	
	public class WarpGate extends FlxSprite
	{
		//Variables got here
		
		public function WarpGate(X:Number=0,Y:Number=0)
		{
			super(X*20,Y*20);
			loadGraphic(Registry.warpGate,false,false,8,8,false);
			
			x +=6;
			y +=6;
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}