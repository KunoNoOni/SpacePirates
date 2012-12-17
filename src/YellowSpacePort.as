package
{
	import org.flixel.*;
	
	public class YellowSpacePort extends FlxSprite
	{
		//Variables got here
		
		public function YellowSpacePort(X:Number=0, Y:Number=0)
		{
			super(X*20,Y*20);
			loadGraphic(Registry.yellowSpcPort,false,false,8,8,false);
			
			x +=6;
			y +=6;
		}
		
		override public function update():void
		{
			super.update();
		}
		
		
	}
}