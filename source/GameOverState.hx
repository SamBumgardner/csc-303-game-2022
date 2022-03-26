package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxState;
import flixel.text.FlxText;

class GameOverState extends FlxState {
	var endMessage:FlxText;

	public function new() {
		super();
	}

	override public function create() {
		#if FLX_MOUSE
		FlxG.mouse.visible = true;
		#end

		super.create();
		endMessage = new FlxText(0, 0, 0, "Game Over!", 22);
		endMessage.screenCenter();
		add(endMessage);
	}
}
