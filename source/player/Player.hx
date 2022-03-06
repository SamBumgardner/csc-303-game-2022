package player;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
	public static var SPEEDS(default, never):Array<Int> = [0, 50, 100];

	public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);

		acceleration.y = 300;
	}

	override public function update(elapsed:Float)
	{
		setSpeed();
		jump();

		if (!isOnScreen())
		{
			kill();
		}
		super.update(elapsed);
	}

	private function setSpeed()
	{
		var speedSelector = 1;
		FlxG.keys.pressed.LEFT ? speedSelector-- : null;
		FlxG.keys.pressed.RIGHT ? speedSelector++ : null;
		velocity.x = SPEEDS[speedSelector];
	}

	private function jump()
	{
		if (FlxG.keys.justPressed.UP)
		{
			velocity.y = -200;
		}
	}

	override function kill()
	{
		reset(FlxG.width / 2, FlxG.height / 2);
	}
}
