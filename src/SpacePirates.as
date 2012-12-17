package
{
	import org.flixel.*;
	
	[SWF(width="600", height="600", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
		
	public class SpacePirates extends FlxGame
	{
		public function SpacePirates()
		{
			super(600,600,TitleState,2);
			//forceDebugger = true;
			//FlxG.visualDebug = true;
			//FlxG.debug = true;
		}
	}
}