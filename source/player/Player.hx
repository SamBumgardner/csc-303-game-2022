package player;

import heropowers.HeroPower;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;

class Player extends FlxSprite {
	public static var SPEED(default, never):Int = 100;

	public var currentPower:HeroPower;

	public var maxHealth:Int = 3;

	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);
		this.loadGraphic(AssetPaths.playerGraphic__png, false, 38, 38, false);
		health = maxHealth;
		acceleration.y = 330;
	}

	override public function update(elapsed:Float) {
		setSpeed();
		jump();

		if (!isOnScreen()) {
			hurt(1);
			reset(FlxG.width / 2, FlxG.height / 2);
		}

		super.update(elapsed);
	}

	private function setSpeed() {
		if (x < 4 || x > FlxG.width - width) {
			velocity.x = 0;
		}
		if (FlxG.keys.pressed.LEFT && x > 4) {
			velocity.x = -(SPEED * 1.4);
		}

		if (FlxG.keys.pressed.RIGHT && x < FlxG.width - width) {
			velocity.x = SPEED;
		}

		if (FlxG.keys.pressed.RIGHT && FlxG.keys.pressed.LEFT) {
			// adds the cancel out effect
			velocity.x = 0;
		}

		if (FlxG.keys.justReleased.LEFT || FlxG.keys.justReleased.RIGHT) {
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
		reset(FlxG.width / 4, FlxG.height / 4);
		health = maxHealth;
		currentPower.inUse = false;
		currentPower.usable = true;
		cast(FlxG.state, PlayState).resetScore(); 

	}
}
