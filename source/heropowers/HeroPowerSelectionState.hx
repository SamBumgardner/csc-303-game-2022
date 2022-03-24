package heropowers;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;
import PlayState;

class HeroPowerSelectionState extends FlxState {
	override public function create() {
		var invincibleBtn:FlxButton = new FlxButton(FlxG.width / 4, FlxG.height / 2, "Invincible", setHeroPowerInvincible);
		add(invincibleBtn);

		var aegisBtn:FlxButton = new FlxButton((FlxG.width / 3) * 2, FlxG.height / 2, "Aegis", setHeroPowerAegis);
		add(aegisBtn);
	}

	function setHeroPowerInvincible():Void {
		PlayState.heroPowerSelection = "Invincible";
		FlxG.switchState(new PlayState());
	}

	function setHeroPowerAegis():Void {
		PlayState.heroPowerSelection = "Aegis";
		FlxG.switchState(new PlayState());
	}
}
