package tokens;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;

class Token extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x,y);

		this.makeGraphic(20,20, FlxColor.YELLOW, false);
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
