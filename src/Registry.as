package
{
	import org.flixel.*;

	public class Registry
	{
		//public static var levelIndex:int = 0;
		public static var muteMusic:Boolean = false;

		[Embed(source = 'Sprites/background.png')] static public var gameUI:Class;
		[Embed(source = 'Sprites/playerShip.png')] static public var plyShip:Class;
		[Embed(source = 'Sprites/spacePortShip.png')] static public var spcPortShip:Class;
		[Embed(source = 'Sprites/spacePoliceShip.png')] static public var spcPoliceShip:Class;
		[Embed(source = 'Sprites/blueSpacePort.png')] static public var blueSpcPort:Class;
		[Embed(source = 'Sprites/redSpacePort.png')] static public var redSpcPort:Class;
		[Embed(source = 'Sprites/yellowSpacePort.png')] static public var yellowSpcPort:Class;
		[Embed(source = 'Sprites/warpGate.png')] static public var warpGate:Class;
		[Embed(source = 'Sprites/SelectBox.png')] static public var selectOverlay:Class;
			
		//[Embed(source = 'Maps/mapCSV_Group1_set1P1.csv', mimeType = 'application/octet-stream')] static public var set1P1:Class;
		
		[Embed(source = 'sounds/defend.mp3')] static public var defendSnd:Class;
		[Embed(source = 'sounds/Game.mp3')] static public var gameMusic:Class;
		[Embed(source = 'sounds/move.mp3')] static public var moveSnd:Class;
		[Embed(source = 'sounds/playerFire.mp3')] static public var playerFireSnd:Class;
		[Embed(source = 'sounds/police.mp3')] static public var policeSnd:Class;
		[Embed(source = 'sounds/policeFire.mp3')] static public var policeFireSnd:Class;
		[Embed(source = 'sounds/TitleSP.mp3')] static public var titleMusic:Class;
		[Embed(source = 'sounds/WinGame.mp3')] static public var winGameMusic:Class;
		
		public function Registry()
		{
		}
	}
}