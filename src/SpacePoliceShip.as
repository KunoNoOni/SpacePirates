package
{
	import org.flixel.*;
	
	public class SpacePoliceShip extends FlxSprite
	{
		//Variables got here
		
		public function SpacePoliceShip(X:Number=0, Y:Number=0)
		{
			super(X*20,Y*20);
			loadGraphic(Registry.spcPoliceShip,false,false,8,8,false);
			
			x +=5;
			y +=5;
		}
		
		override public function update():void
		{
			super.update();
		}
		
		
	}
}