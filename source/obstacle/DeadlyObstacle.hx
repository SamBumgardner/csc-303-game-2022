package obstacle;

import flixel.math.FlxRect;
import flixel.FlxBasic;
import flixel.util.FlxColor;
import obstacle.Obstacle.ObstacleParameters;

class DeadlyObstacle extends Obstacle {
	override function init(parameters:ObstacleParameters) {
		super.init(parameters);

		var sizingRect:FlxRect = new FlxRect(0, 0, parameters.width, parameters.height);
		loadGraphic(AssetPaths.lava__jpg);
		this.width = parameters.width;
		this.height = parameters.height;
		this.clipRect = sizingRect;
	}

	public static function overlapsWithPlayer(player:FlxBasic, deadlyObstacle:DeadlyObstacle) {
		player.kill();
		deadlyObstacle.kill();
	}
}
