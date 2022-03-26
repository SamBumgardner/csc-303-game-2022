package tokens;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;

class Token extends FlxSprite
{
	public function new(X:Float, Y:Float, Radius:Float, YELLOW:FlxColor = 0xFFFFFF00)
	{
		super(x,y);

		acceleration.x = -200;

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
