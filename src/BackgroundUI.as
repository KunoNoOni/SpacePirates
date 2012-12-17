package
{
	import org.flixel.*;
	
	public class BackgroundUI extends FlxSprite
	{
		//Variables got here
		
		public function BackgroundUI(X:Number=0, Y:Number=0)
		{
			super(X,Y);
			loadGraphic(Registry.gameUI,false,false,300,300,false);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		
	}
}