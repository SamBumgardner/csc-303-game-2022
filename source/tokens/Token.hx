package tokens;

import flixel.FlxBasic;
import flixel.util.FlxColor;
import obstacle.Obstacle;

class Token extends Obstacle
{

	private static var HUD:Hud;

	public function new(?parameters:ObstacleParameters, hud:Hud) {
		super(parameters);
		HUD = hud;
	}

	override function init(parameters:ObstacleParameters)
	{
		super.init(parameters);
		color = FlxColor.YELLOW;
	}

	public static function overlapsWithPlayer(player:FlxBasic, scoreToken:Token)
	{
		scoreToken.kill();  //Remove token when collide with player
		//var hud:Hud;
		HUD.addScore(1);    //Add 1 to coin score when player collides
	}	
}
	