package heropowers;

import player.Player;

class Aegis extends HeroPower {
	public function new(X:Float = 0, Y:Float = 0, player:Player) {
		super(X, Y, player);
		// color = 0xFFFFF000;
		inUse = true;
		usable = false;
		player.maxHealth = 4;
		player.health = 4;
	}

	override public function toString() {
		return "Aegis";
	}

	override public function update(elapsed:Float) {
		setAlpha();
		usable = false;
		if (owner.health == owner.maxHealth) {
			inUse = true;
		} else {
			inUse = false;
		}
		super.update(elapsed);
	}
}
