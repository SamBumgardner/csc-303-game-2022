package player;

import heropowers.HeroPower;
import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
	public static var SPEEDS(default, never):Array<Int> = [0, 50, 100];
	
	public var currentPower:HeroPower;
	public static var maxHealth:Int;
	public static var currentHealth:Int;

	public function new(X:Float = 0, Y:Float = 0, heroPower:HeroPower)
	{
		super(X, Y);
		currentPower = heroPower;
		if (currentPower.toString() == "Aegis"){
			maxHealth = 4;
		}
		else{
			maxHealth = 3;
		}
		currentHealth = maxHealth;
		currentPower.makeGraphic(20,20,currentPower.activeColor);
		acceleration.y = 300;
	}

	override public function update(elapsed:Float)
	{
		setSpeed();
		jump();

		if (!isOnScreen())
		{
			currentHealth = 0;
			kill();
		}
		super.update(elapsed);
	}
	private function setSpeed()
	{
		var speedSelector = 1;
		FlxG.keys.pressed.LEFT ? speedSelector-- : null;
		FlxG.keys.pressed.RIGHT ? speedSelector++ : null;
		velocity.x = SPEEDS[speedSelector];
	}

	private function jump()
	{
		if (FlxG.keys.justPressed.UP)
		{
			velocity.y = -200;
		}
	}

	override function kill()
	{
		if (currentPower.toString() == "Invincible" && currentPower.inUse == true && isOnScreen()){
		}else{
			currentHealth--;
			if (currentHealth <= 0){
				reset(FlxG.width / 2, FlxG.height / 2);
				currentHealth = maxHealth;
				currentPower.inUse = false;
			}
			
		}
		
	}
}
