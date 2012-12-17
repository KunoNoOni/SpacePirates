package
{
	import org.flixel.*;
	
	public class PlayerShip extends FlxSprite
	{
		//Variables got here
		
		public function PlayerShip(X:Number=0, Y:Number=0)
		{
			super(X*20,Y*20);
			loadGraphic(Registry.plyShip,false,false,8,8,false);
			
			x +=10;
			y +=9;
		}
		
		override public function update():void
		{
			super.update();
		}
		
		
	}
}