package obstacle;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import obstacle.Obstacle;

@:generic
class ObstacleGenerator<T:Obstacle> extends FlxBasic {
	private var spawnTimer:FlxTimer = new FlxTimer();

	public var obstacles(default, null):FlxTypedGroup<T>;
	public var baseObstacleParameters:ObstacleParameters;
	public var variation:ObstacleVariation;
	public var spawnDelay(default, set):Float;

	public function new(spawnDelay:Float, baseObstacleParameters:ObstacleParameters, variation:ObstacleVariation, obstacles:FlxTypedGroup<T>) {
		// call parent constructor
		super();

		// set to the obstacle objects
		this.obstacles = obstacles;
		// the base parameters used to create the obstacles
		this.baseObstacleParameters = baseObstacleParameters;
		// the variation that will be applied to the obstacles
		this.variation = variation;
		// the delay between obstacle spawning
		this.spawnDelay = spawnDelay;
		// start the spawn timer
		// used to spawn in an obstacle
		spawnTimer.start(spawnDelay, generateObstacle, 0);
	}

	public function generateObstacle(timer:FlxTimer) {
		var recycled:Obstacle = obstacles.recycle();
		recycled.init(variation.apply(baseObstacleParameters));
	}

	public function set_spawnDelay(spawnDelay:Float):Float {
		this.spawnDelay = spawnDelay;
		if (spawnTimer.active == true) {
			spawnTimer.time = this.spawnDelay;
		}
		return this.spawnDelay;
	}
}

class ObstacleVariation {
	public var y:Float;
	public var speed:Float;
	public var width:Float;
	public var height:Float;

	public function new(y:Float = 0, speed:Float = 0, width:Float = 0, height:Float = 0) {
		// constructor
		this.y = y;
		this.speed = speed;
		this.width = width;
		this.height = height;
	}

	public inline function apply(base:ObstacleParameters):ObstacleParameters {
		// creates a new obstacle parameter obj that has different parametes than it
		// used to
		var x = base.x;
		var speed = base.speed;
		var width = Std.int(randomize(base.width, this.width));
		var height = Std.int(randomize(base.height, this.height));
		var yRet;

		if (base.y == 0) {
			yRet = 0.0;
		} else {
			yRet = FlxG.height - height;
		}
		return new ObstacleParameters(x, yRet, speed, width, height);
	}

	private inline function randomize(base:Float, variation:Float):Float {
		// returns a float that is base * a random float b/t 1 and the variation + 1
		return base * FlxG.random.float(1, 1 + variation);
	}
}
