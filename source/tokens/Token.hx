package tokens;

import flixel.FlxBasic;
import flixel.util.FlxColor;
import obstacle.Obstacle;

class Token extends Obstacle
{
	override function init(parameters:ObstacleParameters)
	{
		super.init(parameters);
		color = FlxColor.YELLOW;
	}

	public static function overlapsWithPlayer(player:FlxBasic, scoreToken:Token)
	{
		scoreToken.kill();  //Remove token when collide with player
		//scoreToken.score += 1;    //Add 1 to coin score when player collides
	}	
}
	