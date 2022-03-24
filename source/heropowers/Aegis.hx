package heropowers;

import player.Player;

class Aegis extends HeroPower {
	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);
		activeColor = 0xFFFFF000;
		inUse = true;
		usable = false;
	}

	override public function toString() {
		return "Aegis";
	}

	override public function update(elapsed:Float) {
		setAlpha();
		usable = false;
		if (Player.currentHealth == Player.maxHealth) {
			inUse = true;
		} else {
			inUse = false;
		}
	}
}
