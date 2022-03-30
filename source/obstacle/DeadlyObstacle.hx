package obstacle;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.util.FlxColor;
import obstacle.Obstacle.ObstacleParameters;

class DeadlyObstacle extends Obstacle {
	override function init(parameters:ObstacleParameters) {
		super.init(parameters);
	}

	public static function overlapsWithPlayer(player:FlxObject, deadlyObstacle:DeadlyObstacle) {
		player.hurt(1);
		deadlyObstacle.kill();
	}
}
