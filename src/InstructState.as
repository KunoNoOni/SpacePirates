package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
		
	public class InstructState extends FlxState
	{
		//Variables got here
		private var stars:FlxSprite;
		private var starfield:StarfieldFX;
		private var pShip:PlayerShip;

		public function InstructState()
		{
			super();
		}
		
		override public function create():void
		{
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			//FlxG.playMusic(Registry.titleMusic);
			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(2,0);
			stars = starfield.create(0, 0, FlxG.width, FlxG.height, 200);
			add(stars);
			
			var endText:FlxText = new FlxText(FlxG.width*0.5-300,FlxG.height*0.5-300, 300, "Today you begin your life as a Space Pirate! You've entered " +
				"Sector 1 just as the warp gate exploded! You've heard Sector 1 has 5 star bases in it ripe for the plundering but beware of the Space Police" +
				" in this Sector. All you need is 50000 credits to begin your evil empire! Reading over your notes, you see the most you can get from" +
				" a Blue Starbase is 1000 Credits, 3000 Credits from a Red Starbase and 5000 Credits from a Yellow Starbase. You see a starbase ahead of you, " +
				"time to begin!");
			endText.setFormat(null,10,0xFFFFFF, "center");
			add(endText);
			
			var instruct:FlxText = new FlxText(FlxG.width*0.5-300,FlxG.height*0.5-30, 300, "PRESS [X] TO LAND AT THE STARBASE ");
			instruct.setFormat(null,10,0xFFFFFF, "center");
			add(instruct);
			
			pShip = new PlayerShip(7,9);
			add(pShip);
			//pShip.x-10;
			//pShip.y-9;
			pShip.scale.x = 5.00;
			pShip.scale.y = 5.00;
			
		}
		
		override public function update():void
		{
			if(FlxG.keys.X)
				FlxG.switchState(new PlayState());
			super.update();
		}
		
		override public function destroy():void
		{
			starfield = null;
		}
	}
}