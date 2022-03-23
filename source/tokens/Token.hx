package tokens;

import flixel.FlxG;
import flixel.FlxSprite;

class Token extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x,y);
	}

	public function init(parameters:TokenParameters)
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
}

class TokenParameters
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