package heropowers;

import flixel.input.keyboard.FlxKey;
import flixel.FlxSprite;
import player.Player;

class HeroPower extends FlxSprite {
	public var hotkey:Array<FlxKey>;
	public var usable:Bool;
	public var inUse:Bool;
	public var owner:Player;

	public function new(X:Float = 0, Y:Float = 0, player:Player) {
		super(X, Y);
		owner = player;

		// loadGraphicFromSprite(owner);
		this.loadGraphic(AssetPaths.playerGraphicShield2__png, false, 42, 42, false);
		setGraphicSize(Std.int(width * 1.5), Std.int(height * 1.5));
		// alpha = .5;
		hotkey = [FlxKey.K];
		usable = true;
		inUse = false;
	}

	public function setAlpha() {
		if (usable) {
			alpha = .5;
		} else if (!usable && inUse) {
			alpha = 1;
		} else {
			alpha = 0;
		}
	}

	public function adjustDamage(damage:Float) {
		return damage;
	}

	override public function update(elapsed:Float) {
		if (owner.health > owner.maxHealth) {
			owner.health = owner.maxHealth;
			usable = true;
		}
		x = owner.x - (width - owner.width) / 2;
		y = owner.y - (height - owner.height) / 2;
		super.update(elapsed);
	}
}
