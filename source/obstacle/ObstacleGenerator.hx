package obstacle;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import obstacle.Obstacle;

@:generic
class ObstacleGenerator<T:Obstacle> extends FlxBasic
{
	private var spawnTimer:FlxTimer = new FlxTimer();

	public var obstacles(default, null):FlxTypedGroup<T>;
	public var baseObstacleParameters:ObstacleParameters;
	public var variation:ObstacleVariation;
	public var spawnDelay(default, set):Float;

	public function new(spawnDelay:Float, baseObstacleParameters:ObstacleParameters,
			variation:ObstacleVariation, obstacles:FlxTypedGroup<T>)
	{
		super();

		this.obstacles = obstacles;
		this.baseObstacleParameters = baseObstacleParameters;
		this.variation = variation;
		this.spawnDelay = spawnDelay;

		spawnTimer.start(spawnDelay, generateObstacle, 0);
	}

	public function generateObstacle(timer:FlxTimer)
	{
		var recycled:Obstacle = obstacles.recycle();
		recycled.init(variation.apply(baseObstacleParameters));
	}

	public function set_spawnDelay(spawnDelay:Float):Float
	{
		this.spawnDelay = spawnDelay;
		if (spawnTimer.active == true)
		{
			spawnTimer.time = this.spawnDelay;
		}
		return this.spawnDelay;
	}
}

class ObstacleVariation
{
	public var y:Float;
	public var speed:Float;
	public var width:Float;
	public var height:Float;

	public function new(y:Float = 0, speed:Float = 0, width:Float = 0, height:Float = 0)
	{
		this.y = y;
		this.speed = speed;
		this.width = width;
		this.height = height;
	}

	public inline function apply(base:ObstacleParameters):ObstacleParameters
	{
		var x = base.x;
		var y = randomize(base.y, this.y);
		var speed = randomize(base.speed, this.speed);
		var width = Std.int(randomize(base.width, this.width));
		var height = Std.int(randomize(base.height, this.height));

		return new ObstacleParameters(x, y, speed, width, height);
	}

	private inline function randomize(base:Float, variation:Float):Float
	{
		return base * FlxG.random.float(1, 1 + variation);
	}
}
