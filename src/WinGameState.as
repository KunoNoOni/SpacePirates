package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
		
	public class WinGameState extends FlxState
	{
		//Variables got here
		private var stars:FlxSprite;
		private var starfield:StarfieldFX;
		private var pShip:PlayerShip;


		public function WinGameState()
		{
			super();
		}
		
		override public function create():void
		{
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			FlxG.playMusic(Registry.winGameMusic);
			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(2,0);
			stars = starfield.create(0, 0, FlxG.width, FlxG.height, 200);
			add(stars);
			
			var endText:FlxText = new FlxText(FlxG.width*0.5-300,FlxG.height*0.5-300, 300, "Having accumulated 50,000 credits you fly off into the cosmos to build your empire of evil! " +
				"You think to yourself 'I think I'll start with a Space Port, I'll make it a wretched hive of scum and villainy!'");
			endText.setFormat(null,10,0xFFFFFF, "center");
			add(endText);
			
			var instruct:FlxText = new FlxText(FlxG.width*0.5-300,FlxG.height*0.5-30, 300, "PRESS [X] TO PLAY AGAIN");
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
				FlxG.switchState(new TitleState());
			super.update();
		}
		
		override public function destroy():void
		{
			starfield = null;
		}
	}
}