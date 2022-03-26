package obstacle;

import flixel.FlxG;
import flixel.FlxSprite;

class Obstacle extends FlxSprite {
	public function new(?parameters:ObstacleParameters) {
		super();

		immovable = true;

		if (parameters != null) {
			init(parameters);
		}
	}

	public function init(parameters:ObstacleParameters) {
		super.reset(parameters.x, parameters.y);

		velocity.x = -parameters.speed;

		//	setGraphicSize(parameters.width, parameters.height);
		loadGraphic(AssetPaths.barbedWireGraphic__jpg, false, parameters.width, parameters.height, false, "Obsticle");
	}

	override public function update(elapsed:Float) {
		if (movedOffScreen()) {
			kill();
		}

		super.update(elapsed);
	}

	private function movedOffScreen() {
		return x + width < FlxG.camera.scroll.x;
	}
}

class ObstacleParameters {
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
