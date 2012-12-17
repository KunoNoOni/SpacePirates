package
{
	import org.flixel.*;
	//import org.flixel.plugin.photonstorm.*;
	
	public class SelectBox extends FlxSprite
	{
		//Variables got here
		
		public function SelectBox(X:Number=0, Y:Number=0)
		{
			super(X*20,Y*20);
			loadGraphic(Registry.selectOverlay,false,false,20,20,false);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}