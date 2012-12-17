package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
		
	public class TitleState extends FlxState
	{
		//Variables got here
		private var stars:FlxSprite;
		private var starfield:StarfieldFX;
		private var pShip:PlayerShip;
		
		public function TitleState()
		{
			super();
		}
		
		override public function create():void
		{
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			FlxG.playMusic(Registry.titleMusic);
			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(2,0);
			stars = starfield.create(0, 0, FlxG.width, FlxG.height, 200);
			add(stars);
			
			var logo:FlxText = new FlxText(FlxG.width*0.5-300,FlxG.height*0.5-300, 300, "Space Pirates: Villains of the Cosmos");
			logo.setFormat(null,20,0xFFFFFF, "center");
			add(logo);
			
			var instruct:FlxText = new FlxText(FlxG.width*0.5-300,FlxG.height*0.5-30, 300, "PRESS [X] TO BECOME A SPACE PIRATE");
			instruct.setFormat(null,10,0xFFFFFF, "center");
			add(instruct);
			
			pShip = new PlayerShip(7,9);
			add(pShip);
			pShip.scale.x = 5.00;
			pShip.scale.y = 5.00;
		}
		
		override public function update():void
		{
			if(FlxG.keys.X)
				FlxG.switchState(new InstructState());	//<--- using new state change code for flixel 2.5		
			super.update();
		}
		override public function destroy():void
		{
			starfield = null;
		}
	}
}