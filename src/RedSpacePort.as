package
{
	import org.flixel.*;
	
	public class RedSpacePort extends FlxSprite
	{
		//Variables got here
		
		public function RedSpacePort(X:Number=0, Y:Number=0)
		{
			super(X*20,Y*20);
			loadGraphic(Registry.redSpcPort,false,false,8,8,false);
			
			x +=6;
			y +=6;
		}
		
		override public function update():void
		{
			super.update();
		}
		
		
	}
}