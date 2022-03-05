package obstacle;

import flixel.FlxSprite;

class Obstacle extends FlxSprite
{
	public function new(X:Float, Y:Float, Speed:Int, Width:Int, Height:Int)
	{
		super(X, Y);

		velocity.x = -Speed;

		makeGraphic(Width, Height);

		immovable = true;
	}
}
