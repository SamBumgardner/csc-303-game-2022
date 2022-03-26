package obstacle;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;

class Obstacle extends FlxSprite {
	public function new(?parameters:ObstacleParameters) {
		super();

		immovable = true;

		if (parameters != null) {
			// this gives the obstacle its init values
			init(parameters);
		}
	}

	public function init(parameters:ObstacleParameters) {
		// revive the obstace to be drawn again
		super.reset(parameters.x, parameters.y);

		// set the velocity to whatever the speed is but neg
		var upOrDown = FlxG.random.int(0, 1);
		velocity.x = -parameters.speed;

		if (upOrDown == 1) {
			velocity.y = -(FlxG.random.float(parameters.speed / 2, parameters.speed));
		} else {
			velocity.y = (FlxG.random.float(parameters.speed / 2, parameters.speed));
		}

		this.y = parameters.y;

		// used to create as a rectangle
		makeGraphic(parameters.width, parameters.height);
	}

	override public function update(elapsed:Float) {
		// if the object has moved off screen
		if (movedOffScreen()) {
			// dont draw it
			kill();
		}

		yValIfWrapping();

		super.update(elapsed);
	}

	private function yValIfWrapping() {
		if (y < 0 - height) {
			y = FlxG.height;
		}

		if (y > FlxG.height) {
			y = 0 - height;
		}
	}

	private function movedOffScreen() {
		// check to see if the object has moved off screen
		return x + width < FlxG.camera.scroll.x;
	}
}

class ObstacleParameters {
	// just used to hold the parameters passed to the obstacle constructor
	public var x:Float;
	public var y:Float;
	public var speed:Float;
	public var width:Int;
	public var height:Int;

	public function new(x:Float = 0, y:Float = 0, speed:Float = 0, width:Int = 0, height:Int = 0) {
		this.x = x;
		this.y = y;
		this.speed = speed;
		this.width = width;
		this.height = height;
	}
}
