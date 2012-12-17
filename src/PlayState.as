package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayState extends FlxState
	{
		//Variables go here
		private var UI:FlxSprite = new FlxSprite;
		private var pShip:PlayerShip;
		private var policeShip:SpacePoliceShip;
		private var bSpacePort:BlueSpacePort;
		private var rSpacePort:RedSpacePort;
		private var ySpacePort:YellowSpacePort;
		//private var wGate:WarpGate;
		private var crds:FlxText;
		private var fuel:FlxText;
		private var fuelCost:FlxText;
		private var errorMsg:FlxText;
		private var errorMsg2:FlxText;
		private var options:FlxText;
		private var sector:FlxText;
		private var shipStats:FlxText;
		private var pointer:SelectBox;
		private var mousePosX:Number;
		private var mousePosY:Number;
		private var Credits:Number = 0;
		private var Fuel:Number = 1000;
		private var Goal:Number = 50000;
		private var FuelCost:Number=0;
		private var Sector:Number = 1;
		private var option:Number = 0; 
		private var randomNum:Number;
		private var pShipShields:Number=100;
		private var policeShipShields:Number = 100;
		private var theBases:Number=0;
		private var chance:Number=0;
		private var chanceToFlee:Number=0;
		private var policeFund:Number=1000;
		private var combat:Boolean = false;
		private var policeOptions:Boolean=false;
		private var defense:Boolean=false;
		private var fled:Boolean = false;
		private var spacePortsLocationsX:Array = [0,0,0,0,0];
		private var spacePortsLocationsY:Array = [0,0,0,0,0];
		private var spacePortsType:Array = [0,0,0,0,0];
				
		override public function create():void
		{	
			UI.loadGraphic(Registry.gameUI,false,false,300,300,false);
			add(UI);
			//UI.x = 0;
			//UI.y = 0;
			crds = new FlxText(0,4,100, "Credits: "+Credits);
			crds.setFormat(null,8,0xFFFFFF, "left");
			add(crds);
			fuel = new FlxText(90,4,100, "Fuel: "+Fuel);
			fuel.setFormat(null,8,0xFFFFFF, "left");
			add(fuel);
			fuelCost = new FlxText(165,4,100, "Fuel Cost: "+FuelCost);
			fuelCost.setFormat(null,8,0xFFFFFF, "left");
			add(fuelCost);
			sector = new FlxText(250,4,100, "Sector: "+Sector);
			sector.setFormat(null,8,0xFFFFFF, "left");
			add(sector);
			options = new FlxText(0,0,10,"");
			errorMsg = new FlxText(0,0,10,"");
			errorMsg2 = new FlxText(0,0,10,"");
			shipStats = new FlxText(0,0,10,"");
			createSpacePorts();
			//createSpaceWarp();
			policeShip = new SpacePoliceShip(0,0);
			add(policeShip);
			policeShip.visible = false;
			pShip = new PlayerShip(spacePortsLocationsX[0],spacePortsLocationsY[0]);
			add(pShip);
			pointer = new SelectBox(0,1);
			add(pointer);
			FlxG.playMusic(Registry.gameMusic);
		}	
		
		override public function update():void
		{
			if(FlxG.keys.justPressed("M"))
			{
				Registry.muteMusic = true;
			}
			
			if(FlxG.keys.justPressed("U"))
			{
				Registry.muteMusic = false;
			}
			
			if(Registry.muteMusic)
			{
				FlxG.music.volume = 0;
			}
			else
			{
				FlxG.music.volume = 1;
			}
			
			mousePosX = FlxU.floor(FlxG.mouse.screenX/20);
			mousePosY = FlxU.floor(FlxG.mouse.screenY/20);
			//trace("mousePosX = "+mousePosX+" mousePosY = "+mousePosY);
			//trace("pointer.x = "+pointer.x+" pointer.y = "+pointer.y);
			
			if(pointer.x > 300)
				pointer.x = 300;
			else
				pointer.x = mousePosX*20;
			
			if(pointer.x < 0)
				pointer.x = 0;
			else
				pointer.x = mousePosX*20;
			
			if(pointer.y > 200)
				pointer.y = 200;
			else
				pointer.y = mousePosY*20;

			if(pointer.y < 20)
				pointer.y = 20;
			else
				pointer.y = mousePosY*20;
			
			if(pointer.y <=200)
			{
				FuelCost = FlxVelocity.distanceBetween(pShip,pointer);
			 	fuelCost.text = "Fuel Cost: "+FuelCost;
			}
			//trace("policeOptions = "+policeOptions);
			if(FlxG.mouse.justReleased() && !combat)
			{
				if(!policeOptions)
				{
					if(pointer.y <=200)	
					{
						if(Fuel > FuelCost)
						{
							for(theBases=0;theBases<5;theBases++)
							{				
								if(spacePortsLocationsX[theBases] == (Math.floor(pointer.x/20)) && spacePortsLocationsY[theBases] == (Math.floor(pointer.y/20)))
								{
									FlxG.play(Registry.moveSnd,0.5);
									policeShip.visible = false;
									//trace("switching fled to false because I'm moving!");
									fled = false;
									policeOptions = false;
									errorMsg.kill();
									errorMsg = new FlxText(0,0,10,"");
									pShip.x = (mousePosX*20)+10;
									pShip.y = (mousePosY*20)+9;
									Fuel -=FuelCost;
									fuel.text = "Fuel: "+Fuel;
								}
							}	
						}
						else
						{
							errorMsg = new FlxText(0,220,300, "Error: You do not have enough fuel to make this journey.");
							errorMsg.setFormat(null,10,0xFFFFFF, "left");
							add(errorMsg);
						}
					}
				}	
			}
			
			/*if(FlxG.keys.justReleased("Q"))
			{
				trace("combat = "+combat);
				trace("policeOptions = "+policeOptions);
			}*/
			
			for(theBases=0;theBases<5;theBases++)
			{				
				if(spacePortsLocationsX[theBases] == (Math.floor(pShip.x/20)) && spacePortsLocationsY[theBases] == (Math.floor(pShip.y/20)))
				{
					if(!fled)
					{	
						spacePortOptions();
					}
				}
			}
			
			if(policeOptions && !fled)
			{
				spacePoliceOptions();
			}
			
			if(combat)
			{
				SpaceCombat();
			}
			
			if(fled)
			{
				options.text = "";
				errorMsg2.text = "";
			}
			
			if(Credits >= Goal)
			{
				FlxG.switchState(new WinGameState());
			}
			
			super.update();
			
		}
		
		private function createSpacePorts():void
		{
			//var spacePortsLocationsX:Array = [0,0,0,0,0];
			//var spacePortsLocationsY:Array = [0,0,0,0,0];
			var rndNum:Number = 0;
			var rndNum2:Number = 0;
			var d6:Number=0;
			var bases:Number;
			var checkX:Number;
			var checkY:Number;
			var match:Number;
			var done:Boolean = false;
			
			//trace("Entering For Loop.");
			//This is for Sector 1
			for(bases=0;bases<5;bases++)
			{	
				d6 = Math.floor(Math.random()*6)+1;
				rndNum = Math.floor((Math.random()*300)/20);
				rndNum2 = Math.floor(((Math.random()*180)+20)/20);
				
				spacePortsLocationsX[bases] = rndNum;
				spacePortsLocationsY[bases] = rndNum2;
			}
			
			for(var i:int=0;i<5;i++)
			{
				checkX = spacePortsLocationsX[i];
				checkY = spacePortsLocationsY[i];
				for(var ii:int=0;ii<5;ii++)
				{	
					if(checkX ==spacePortsLocationsX[ii])
					{
						match +=1;
						if(match >1)
						{
							while(spacePortsLocationsX[i] != spacePortsLocationsX[ii])
							{
								rndNum = Math.floor((Math.random()*300)/20);
								spacePortsLocationsX[ii]=rndNum;
								
							}
						}
					}
					match = 0;
					if(checkY ==spacePortsLocationsY[ii])
					{
						match +=1;
						if(match >1)
						{
							while(spacePortsLocationsY[i] != spacePortsLocationsY[ii])
							{
								rndNum2 = Math.floor(((Math.random()*180)+20)/20);
								spacePortsLocationsY[ii]=rndNum2;
								
							}
						}
					}
				}
				
				for(bases=0;bases<5;bases++)
				{
					d6 = getRandomNumber(6);
					if(d6 == 1 || d6 == 2 || d6 == 3 )
					{
						bSpacePort = new BlueSpacePort(spacePortsLocationsX[bases],spacePortsLocationsY[bases]);
						spacePortsType[bases] = 1;
						add(bSpacePort);
					}
					else if(d6 == 4 || d6 == 5)
					{
						rSpacePort = new RedSpacePort(spacePortsLocationsX[bases],spacePortsLocationsY[bases]);
						spacePortsType[bases] = 2;
						add(rSpacePort);
					}
					else if(d6 == 6)
					{
						ySpacePort = new YellowSpacePort(spacePortsLocationsX[bases],spacePortsLocationsY[bases]);
						spacePortsType[bases] = 3;
						add(ySpacePort);
					}
				}
				
			}
		}
		
		private function spacePortOptions():void 
		{
			//trace("Player is at a StarPort");
			//trace("policeOptions = "+policeOptions);
			if(!policeOptions)
			{				
				//trace("Player is at a StarPort");
				options.kill();
				options = new FlxText(0,240,300, "Steal (C)redits or (F)uel");
				options.setFormat(null,10,0xFFFFFF, "left");
				add(options);
				
				if(FlxG.keys.justReleased("C"))
				{
					for(theBases=0;theBases<5;theBases++)
					{	
						if(spacePortsLocationsX[theBases] == (Math.floor(pShip.x/20)) && spacePortsLocationsY[theBases] == (Math.floor(pShip.y/20)))
						{
							switch(spacePortsType[theBases])
							{
								case 1:
								{
									chance = 51;
									break;
								}
								case 2:
								{
									chance = 31;
									break;
								}
								case 3:
								{
									chance = 11;
									break;
								}
							}
						}
					}
					//trace("chance = "+chance);
					randomNum = getRandomNumber(100);
					if( randomNum < chance)
					{
						for(theBases=0;theBases<5;theBases++)
						{	
							if(spacePortsLocationsX[theBases] == (Math.floor(pShip.x/20)) && spacePortsLocationsY[theBases] == (Math.floor(pShip.y/20)))
							{
								switch(spacePortsType[theBases])
								{
									case 1:
									{
										randomNum = getRandomNumber(1000);
										break;
									}
									case 2:
									{
										randomNum = getRandomNumber(3000);
										break;
									}
									case 3:
									{
										randomNum = getRandomNumber(5000);
										break;
									}
								}
							}
						}
						errorMsg.kill();
						errorMsg = new FlxText(0,220,300, "You steal "+randomNum+" credits!");
						errorMsg.setFormat(null,10,0xFFFFFF, "left");
						add(errorMsg);
						Credits +=randomNum;
						crds.text = "Credits: "+Credits
					}
					else
					{
						//trace("COPS!");
						FlxG.play(Registry.policeSnd,0.5);
						errorMsg.kill();
						errorMsg = new FlxText(0,220,300, "Someone contacted the Police!");
						errorMsg.setFormat(null,10,0xFFFFFF, "left");
						add(errorMsg);
						policeShip.x = (Math.floor(pShip.x/20))*20;
						policeShip.y = (Math.floor(pShip.y/20))*20;
						policeShip.x +=2;
						policeShip.y +=3;
						policeShip.visible = true;
						policeOptions = true;
						spacePoliceOptions();
					}
				}
				else if(FlxG.keys.justReleased("F"))
				{
					randomNum = getRandomNumber(100);
					errorMsg.kill();
					errorMsg = new FlxText(0,220,300, "You steal "+randomNum+" fuel!");
					errorMsg.setFormat(null,10,0xFFFFFF, "left");
					add(errorMsg);
					if(randomNum < 51)
					{
						//randomNum = getRandomNumber(1000)+99;
						Fuel +=randomNum;
						trace("randomNum = "+randomNum);
						fuel.text = "Fuel: "+Fuel
					}
					else
					{
						//trace(Math.floor(pShip.x/20));
						//trace(Math.floor(pShip.y/20));
						FlxG.play(Registry.policeSnd,0.5);
						errorMsg.kill();
						errorMsg = new FlxText(0,220,300, "Someone contacted the Police!");
						errorMsg.setFormat(null,10,0xFFFFFF, "left");
						add(errorMsg);
						policeShip.x = (Math.floor(pShip.x/20))*20;
						policeShip.y = (Math.floor(pShip.y/20))*20;
						policeShip.x +=2;
						policeShip.y +=3;
						policeShip.visible = true;
						policeOptions = true;
						spacePoliceOptions();
					}
				}
			}
		}

		private function spacePoliceOptions():void
		{
			//trace("We're doing spacePoliceOptions!");
			options.kill();
			options = new FlxText(0,240,300, "(A)ttack Police or (R)un");
			options.setFormat(null,10,0xFFFFFF, "left");
			add(options);
			if(FlxG.keys.justReleased("A"))
			{
				//goto combat screen
				//trace("switching policeOptions to false");
				//trace("switching combat to true");
				policeOptions = false;
				combat = true;
				shipStats.visible = true;
				errorMsg2 = new FlxText(0,0,10, "");
				//trace("Going to combat!");
			}
			else if(FlxG.keys.justReleased("R")) 
			{
				randomNum = getRandomNumber(100);
				for(theBases=0;theBases<5;theBases++)
				{	
					if(spacePortsLocationsX[theBases] == (Math.floor(pShip.x/20)) && spacePortsLocationsY[theBases] == (Math.floor(pShip.y/20)))
					{
						switch(spacePortsType[theBases])
						{
							case 1:
							{
								chanceToFlee = 51;
								break;
							}
							case 2:
							{
								chanceToFlee = 31;
								break;
							}
							case 3:
							{
								chanceToFlee = 11;
								break;
							}
						}
					}
				}
				if(randomNum <chanceToFlee)
				{
					//Let the player know he can escape
					errorMsg.kill();
					errorMsg = new FlxText(0,220,300, "Hurry, while they still don't see you!");
					errorMsg.setFormat(null,10,0xFFFFFF, "left");
					add(errorMsg);
					policeOptions = false;
					fled = true;
				}
				else
				{
					//goto combat screen
					errorMsg2.kill();
					errorMsg2 = new FlxText(0,240,300, "The Space Police engage your ship in combat.");
					errorMsg2.setFormat(null,10,0xFFFFFF, "left");
					add(errorMsg2);
					policeOptions = false;
					//trace("switching combat to true because you failed to run from the police!");
					combat = true;
					shipStats.visible = true;
					//errorMsg2 = new FlxText(0,0,10, "");
				}
			}
			//trace("Exiting spacePoliceOptions!");
		}
		private function SpaceCombat():void
		{
			//trace("Entering Space Combat!");
			var playersTurn:Boolean = true;
			var d20:Number=0;
			var damage:Number;
			var d6:Number=0;
			var rand:Number=0;
			
			//trace(pShipShields+" "+policeShipShields+" "+combat+" "+playersTurn);
			
			/*if(FlxG.keys.justReleased("T"))
			{
				trace("Defense = "+defense);
			}*/
			
			if(!pShipShields <=0 || !policeShipShields <=0 || !combat)
			{
				if(playersTurn)
				{					
					//trace("inside while loop");
					shipStats.kill();
					shipStats = new FlxText(0,280,300, "Player's Ship: "+pShipShields+" Police Ship: "+policeShipShields);
					shipStats.setFormat(null,10,0xFFFFFF, "left");
					add(shipStats);
					options.kill();
					options = new FlxText(0,260,300, "(A)ttack (D)efend r(E)treat");
					options.setFormat(null,10,0xFFFFFF, "left");
					add(options);
					if(FlxG.keys.justReleased("A"))
					{
						d20 = getRandomNumber(20);
						if(d20 >=13)
						{
							FlxG.play(Registry.playerFireSnd,0.5);
							damage = getRandomNumber(25);
							errorMsg.kill();
							errorMsg = new FlxText(0,220,300, "You hit for "+damage+" points of damage!");
							errorMsg.setFormat(null,10,0xFFFFFF, "left");
							add(errorMsg)
							policeShipShields -= damage;
							playersTurn = false;
						}
						else
						{
							errorMsg.kill();
							errorMsg = new FlxText(0,220,300, "You Miss!");
							errorMsg.setFormat(null,10,0xFFFFFF, "left");
							add(errorMsg)
							playersTurn = false;
						}
					}
					if(FlxG.keys.justReleased("D"))
					{
						FlxG.play(Registry.defendSnd,0.5);
						errorMsg.kill();
						errorMsg = new FlxText(0,220,300, "Next hit will be 1/2 damage");
						errorMsg.setFormat(null,10,0xFFFFFF, "left");
						add(errorMsg)
						defense=true;
					}
					if(FlxG.keys.justReleased("E"))
					{
						d6 = getRandomNumber(6);
						if(d6 <=3)
						{
							options.kill();
							shipStats.kill();
							errorMsg2.kill();
							errorMsg.kill();
							errorMsg = new FlxText(0,220,300, "Aft shields to full, let's get out of here!");
							errorMsg.setFormat(null,10,0xFFFFFF, "left");
							add(errorMsg)
							//trace("switching combat to false INSIDE SPACE COMBAT!!!!");
							combat = false;
							playersTurn = false;
							fled = true;
							pShipShields = 100;
							policeShipShields = 100;
							shipStats.visible = false;
							policeOptions = false;
						}
						else
						{
							errorMsg.kill();
							errorMsg = new FlxText(0,220,300, "The Police maneuver to block you!");
							errorMsg.setFormat(null,10,0xFFFFFF, "left");
							add(errorMsg)
							playersTurn = false;
						}
					}
					
				}
				//PoliceShip's Turn
				if(!playersTurn && combat)
				{
					d20 = getRandomNumber(20);
					if(d20 >=13)
					{
						damage = getRandomNumber(25);
						errorMsg2.kill();
						if(defense)
						{
							FlxG.play(Registry.policeFireSnd,0.5);
							//trace("Damage would have been "+damage+" had you not defended!");
							pShipShields -=Math.floor(damage/2);
							errorMsg2 = new FlxText(0,240,300, "The Police hit you for "+Math.floor(damage/2)+" points of damage!");
							errorMsg2.setFormat(null,10,0xFFFFFF, "left");
							add(errorMsg2);
							defense = false;
						}
						else
						{
							FlxG.play(Registry.policeFireSnd,0.5);
							errorMsg2 = new FlxText(0,240,300, "The Police hit you for "+damage+" points of damage!");
							errorMsg2.setFormat(null,10,0xFFFFFF, "left");
							add(errorMsg2);
							pShipShields -=damage;
						}
						playersTurn = true;
					}
					else
					{
						errorMsg2.kill();
						errorMsg2 = new FlxText(0,240,300, "The Police have missed!");
						errorMsg2.setFormat(null,10,0xFFFFFF, "left");
						add(errorMsg2);
						playersTurn = true;
					}
				}
			}
			if(pShipShields<=0)
			{
				options.kill();
				errorMsg2.kill();
				errorMsg.kill();
				errorMsg = new FlxText(0,220,300, "The Police have taken all your Credits!");
				errorMsg.setFormat(null,10,0xFFFFFF, "left");
				add(errorMsg)
				policeFund += Credits;
				Credits = 0;
				crds.text = "Credits: "+Credits;
				policeShip.x = 0;
				policeShip.y = 0;
				policeShip.visible = false;
				//trace("switching combat to false because you lost all your money");
				combat = false;
				pShipShields = 100;
				policeShipShields = 100;
				shipStats.visible = false;
			}
			else if(policeShipShields <=0)
			{
				options.kill();
				errorMsg2.kill();
				errorMsg.kill();
				errorMsg = new FlxText(0,220,300, "You found "+policeFund+" Credits!");
				errorMsg.setFormat(null,10,0xFFFFFF, "left");
				add(errorMsg)
				Credits += policeFund;
				crds.text = "Credits: "+Credits;
				policeFund = 1000;
				policeShip.x = 0;
				policeShip.y = 0;
				policeShip.visible = false;
				//trace("switching combat to false because you won combat!");
				combat = false;
				pShipShields = 100;
				policeShipShields = 100;
				shipStats.visible = false;
			}
			//trace("exiting Space Combat");
		}
		
		private function getRandomNumber(X:Number):Number
		{
			var num:Number;
			
			return num = Math.floor((Math.random()*X)+1);
			
		}
	}
}
