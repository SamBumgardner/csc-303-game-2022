package obstacle;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.util.FlxColor;
import obstacle.Obstacle.ObstacleParameters;

class HorizontalObstacle extends DeadlyObstacle {
	override function init(parameters:ObstacleParameters) {
		super.init(parameters);
		velocity.y = 0;
		this.color = FlxColor.RED;
	}
}
