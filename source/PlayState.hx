package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import obstacle.DeadlyObstacle;
import obstacle.Obstacle;
import obstacle.ObstacleGenerator;
import player.Player;

class PlayState extends FlxState {
	var player:Player;

	var obstacleGeneratorTop:ObstacleGenerator<Obstacle>;
	var obstacleGeneratorMid:ObstacleGenerator<Obstacle>;
	var obstacleGeneratorBot:ObstacleGenerator<Obstacle>;
	var deadlyObstacleGenerator:ObstacleGenerator<DeadlyObstacle>;

	var SECONDS_PER_OBSTACLE(default, never):Float = 1.3;
	var SECONDS_PER_DEADLY_OBSTACLE(default, never):Float = 4;

	override public function create() {
		// call super
		super.create();

		// create player
		player = new Player(FlxG.width / 4, FlxG.height / 4);
		add(player);

		// set up the obstacle types
		setUpObstacles();
		// set up the obstacles that kill the player
		setUpDeadlyObstacles();
	}

	private function setUpObstacles() {
		// create new obstacle group
		var generatedObstaclesTop = new FlxTypedGroup<Obstacle>();
		var generatedObstaclesMid = new FlxTypedGroup<Obstacle>();
		var generatedObstaclesBot = new FlxTypedGroup<Obstacle>();
		final obstacleHeight = 35;
		final obstacleWidth = 10;
		final obstacleBaseSpeed = 175;
		// iterate and create some objects
		for (i in 0...5) {
			var obstacleT = new Obstacle();
			var obstacleM = new Obstacle();
			var obstacleB = new Obstacle();
			// make the obstacles not drawn or interacted with
			obstacleT.kill();
			obstacleM.kill();
			obstacleB.kill();
			// add them to the group
			generatedObstaclesTop.add(obstacleT);
			generatedObstaclesMid.add(obstacleM);
			generatedObstaclesBot.add(obstacleB);
		}

		// create a set of obstacle parameters
		var baseObstacleParametersTop = new ObstacleParameters(FlxG.width, 0, obstacleBaseSpeed, obstacleWidth, obstacleHeight);
		var baseObstacleParametersMid = new ObstacleParameters(FlxG.width, 200, obstacleBaseSpeed, obstacleWidth, obstacleHeight);
		var baseObstacleParametersBot = new ObstacleParameters(FlxG.width, 400, obstacleBaseSpeed, obstacleWidth, obstacleHeight);
		// create a variation object
		var obstacleVariation = new ObstacleVariation(-1, .9, 1, 2);
		// create an obstacle generator
		obstacleGeneratorTop = new ObstacleGenerator<Obstacle>(SECONDS_PER_OBSTACLE, baseObstacleParametersTop, obstacleVariation, generatedObstaclesTop);
		obstacleGeneratorMid = new ObstacleGenerator<Obstacle>(SECONDS_PER_OBSTACLE, baseObstacleParametersMid, obstacleVariation, generatedObstaclesMid);
		obstacleGeneratorBot = new ObstacleGenerator<Obstacle>(SECONDS_PER_OBSTACLE, baseObstacleParametersBot, obstacleVariation, generatedObstaclesBot);
		// add the obstacles to the play state

		add(obstacleGeneratorTop.obstacles);
		add(obstacleGeneratorMid.obstacles);
		add(obstacleGeneratorBot.obstacles);
	}

	private function setUpDeadlyObstacles() {
		var generatedDeadlyObstacles = new FlxTypedGroup<DeadlyObstacle>();
		for (i in 0...5) {
			var obstacle = new DeadlyObstacle();
			obstacle.kill();
			generatedDeadlyObstacles.add(obstacle);
		}
		var baseDeadlyObstacleParameters = new ObstacleParameters(FlxG.width, FlxG.height, 500, 30, 15);
		var deadlyObstacleVariation = new ObstacleVariation(-1, 0, 1, 1);

		deadlyObstacleGenerator = new ObstacleGenerator<DeadlyObstacle>(SECONDS_PER_DEADLY_OBSTACLE, baseDeadlyObstacleParameters, deadlyObstacleVariation,
			generatedDeadlyObstacles);
		add(deadlyObstacleGenerator.obstacles);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		FlxG.overlap(player, obstacleGeneratorBot.obstacles, Obstacle.overlapsWithPlayer);
		FlxG.overlap(player, obstacleGeneratorMid.obstacles, Obstacle.overlapsWithPlayer);
		FlxG.overlap(player, obstacleGeneratorTop.obstacles, Obstacle.overlapsWithPlayer);
		FlxG.overlap(player, deadlyObstacleGenerator.obstacles, DeadlyObstacle.overlapsWithPlayer);
	}
}
