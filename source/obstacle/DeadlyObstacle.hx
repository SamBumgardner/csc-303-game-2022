package obstacle;

import flixel.FlxBasic;
import flixel.util.FlxColor;
import obstacle.Obstacle.ObstacleParameters;

class DeadlyObstacle extends Obstacle
{
	override function init(parameters:ObstacleParameters)
	{
		super.init(parameters);
		color = FlxColor.RED;
	}

	public static function overlapsWithPlayer(player:FlxBasic, deadlyObstacle:DeadlyObstacle)
	{
		player.kill();
		deadlyObstacle.kill();
	}

	public static inline function construct()
	{
		return new DeadlyObstacle();
	}
}
