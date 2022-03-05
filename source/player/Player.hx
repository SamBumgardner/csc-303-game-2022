package player;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
	public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);

		acceleration.y = 150;
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.W || FlxG.keys.justPressed.UP)
		{
			velocity.y = -200;
		}
		super.update(elapsed);
	}
}
