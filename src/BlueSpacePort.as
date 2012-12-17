package
{
	import org.flixel.*;
	
	public class BlueSpacePort extends FlxSprite
	{
		//Variables got here
		
		public function BlueSpacePort(X:Number=0, Y:Number=0)
		{
			super(X*20,Y*20);
			loadGraphic(Registry.blueSpcPort,false,false,8,8,false);
			
			//trace("0BlueSpacePort's X is "+x);
			//trace("0BlueSpacePort's Y is "+y);
			
			x +=6;
			y +=6;
			
			//trace("1BlueSpacePort's X is "+x);
			//trace("1BlueSpacePort's Y is "+y);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		
	}
}