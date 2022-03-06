package obstacle;

import flixel.FlxG;
import flixel.FlxSprite;

class Obstacle extends FlxSprite
{
	public function new(?parameters:ObstacleParameters)
	{
		super();

		immovable = true;

		if (parameters != null)
		{
			init(parameters);
		}
	}

	public function init(parameters:ObstacleParameters)
	{
		super.reset(parameters.x, parameters.y);

		velocity.x = -parameters.speed;

		makeGraphic(parameters.width, parameters.height);
	}

	override public function update(elapsed:Float)
	{
		if (movedOffScreen())
		{
			kill();
		}

		super.update(elapsed);
	}

	private function movedOffScreen()
	{
		return x + width < FlxG.camera.scroll.x;
	}

	public static inline function construct()
	{
		return new Obstacle();
	}
}

class ObstacleParameters
{
	public var x:Float;
	public var y:Float;
	public var speed:Float;
	public var width:Int;
	public var height:Int;

	public function new(x:Float = 0, y:Float = 0, speed:Float = 0, width:Int = 0, height:Int = 0)
	{
		this.x = x;
		this.y = y;
		this.speed = speed;
		this.width = width;
		this.height = height;
	}
}
