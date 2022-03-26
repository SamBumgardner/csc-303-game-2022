package player;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite {
	public static var SPEEDS(default, never):Array<Int> = [0, 50, 100, 150, 200];

	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);

		acceleration.y = 330;
	}

	override public function update(elapsed:Float) {
		setSpeed();
		jump();

		if (!isOnScreen()) {
			kill();
		}
		super.update(elapsed);
	}

	private function setSpeed() {
		var speedSelector = 2;
		if (FlxG.keys.pressed.LEFT && x > 20) {
			velocity.x = -SPEEDS[speedSelector] * 1.4;
		} else if (FlxG.keys.pressed.LEFT) {
			velocity.x = 0;
		}

		if (FlxG.keys.pressed.RIGHT && x < FlxG.width - width) {
			velocity.x = SPEEDS[speedSelector];
		} else if (FlxG.keys.pressed.RIGHT && x > (FlxG.width - width)) {
			velocity.x = 0;
		} else if (FlxG.keys.pressed.RIGHT) {
			velocity.x = 0;
		}
	}

	private function jump() {
		if (FlxG.keys.justPressed.UP) {
			velocity.y = -220;
		}
	}

	// could be changed when the life system is implemented
	override function kill() {
		reset(FlxG.width / 4, FlxG.height / 4);
	}
}
