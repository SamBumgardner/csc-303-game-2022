package obstacle;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.util.FlxColor;
import obstacle.Obstacle.ObstacleParameters;

class VerticalObstacle extends DeadlyObstacle {
	override function init(parameters:ObstacleParameters) {
		super.init(parameters);
		this.color = FlxColor.WHITE;

        var upOrDown = FlxG.random.int(0, 1);

		if (upOrDown == 1) {
			velocity.y = -(FlxG.random.float(parameters.speed / 2, parameters.speed));
		} else {
			velocity.y = (FlxG.random.float(parameters.speed / 2, parameters.speed));
		}
	}
}
