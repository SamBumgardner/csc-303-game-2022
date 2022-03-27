package player;

import flixel.util.FlxColor;
import heropowers.HeroPower;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;

class Player extends FlxSprite {
	public static var SPEEDS(default, never):Array<Int> = [0, 50, 100, 150, 200];

	public var currentPower:HeroPower;

	public var maxHealth:Int = 3;

	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);
		makeGraphic(16, 16, 0xBBBBBBBB);
		health = maxHealth;
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

	public function setPower(power:HeroPower) {
		currentPower = power;
	}

	override function hurt(damage:Float) {
		super.hurt(currentPower.adjustDamage(damage));
	}

	override function kill() {
		reset(FlxG.width / 2, FlxG.height / 2);
		health = maxHealth;
		currentPower.inUse = false;
		currentPower.usable = true;
	}
}
