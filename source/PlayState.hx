package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import obstacle.Obstacle;
import player.Player;

class PlayState extends FlxState
{
	var player:Player;
	var obstacles:FlxGroup;

	override public function create()
	{
		super.create();

		player = new Player(300, 300);
		add(player);

		obstacles = new FlxGroup();
		for (i in 0...10)
		{
			var x = 200 + i * 200;
			var y = 0;
			var speed = 200;
			var width = 100;
			var height = FlxG.random.int(100, 250);
			obstacles.add(new Obstacle(x, y, speed, width, height));
		}
		add(obstacles);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, obstacles);
	}
}
