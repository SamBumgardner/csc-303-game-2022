package tokens;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import tokens.Token;

@:generic
class TokenGenerator<T:Token> extends FlxBasic
{
	private var spawnTimer:FlxTimer = new FlxTimer();

	public var tokens(default, null):FlxTypedGroup<T>;
	public var baseTokenParameters:TokenParameters;
	public var variation:TokenVariation;
	public var spawnDelay(default, set):Float;

	public function new(spawnDelay:Float, baseTokenParameters:TokenParameters,
		variation:TokenVariation, tokens:FlxTypedGroup<T>)
	{
		super();

		this.tokens = tokens;
		this.baseTokenParameters = baseTokenParameters;
		this.variation = variation;
		this.spawnDelay = spawnDelay;

		spawnTimer.start(spawnDelay, generateToken, 0);
	}

	public function generateToken(timer:FlxTimer)
	{
		var recycled:Token = tokens.recycle();
		recycled.init(variation.apply(baseTokenParameters));
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

class TokenVariation
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

	public inline function apply(base:TokenParameters):TokenParameters
	{
		var x = base.x;
		var y = randomize(base.y, this.y);
		var speed = randomize(base.speed, this.speed);
		var width = Std.int(randomize(base.width, this.width));
		var height = Std.int(randomize(base.height, this.height));

		return new TokenParameters(x, y, speed, width, height);
	}

	private inline function randomize(base:Float, variation:Float):Float
	{
		return base * FlxG.random.float(1, 1 + variation);
	}
}
