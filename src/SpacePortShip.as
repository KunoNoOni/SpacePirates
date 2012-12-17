package
{
	import org.flixel.*;
	
	public class SpacePortShip extends FlxSprite
	{
		//Variables got here
		
		public function SpacePortShip(X:Number=0, Y:Number=0)
		{
			super(X*8,Y*8);
			loadGraphic(Registry.spcPortShip,false,false,8,8,false);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		
	}
}