package;

import lime.system.System;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;

class GameOverState extends FlxState {
	var endMessage:FlxText;
	var tryAgainButton:FlxButton;
	var exitButton:FlxButton;

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

		tryAgainButton = new FlxButton((FlxG.width / 2) - 80, (FlxG.height / 2) + 50, "Try Again?", tryAgain);
		add(tryAgainButton);

		exitButton = new FlxButton((FlxG.width / 2) + 10, (FlxG.height / 2) + 50, "Exit?", exit);
		add(exitButton);
	}

	private function tryAgain() {
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() {
			FlxG.switchState(new PlayState());
		});
	}

	private function exit() {
		System.exit(0);
	}
}
