package;

import heropowers.HeroPowerSelectionState;
import heropowers.Aegis;
import heropowers.Invincible;
import heropowers.HeroPower;
import heropowers.PowerListEnum;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import obstacle.DeadlyObstacle;
import obstacle.Obstacle;
import obstacle.ObstacleGenerator;
import player.Player;

class PlayState extends FlxState {
	var player:Player;
	var hud:Hud;

	var obstacleGeneratorTop:ObstacleGenerator<Obstacle>;
	var obstacleGeneratorMid:ObstacleGenerator<Obstacle>;
	var obstacleGeneratorBot:ObstacleGenerator<Obstacle>;
	var heroPower:HeroPower;

	var deadlyObstacleGenerator:ObstacleGenerator<DeadlyObstacle>;

	var SECONDS_PER_OBSTACLE(default, never):Float = 1.3;
	var SECONDS_PER_DEADLY_OBSTACLE(default, never):Float = 4;

	public static var heroPowerSelection:HeroPowerEnum = Aegis;

	override public function create() {
		// call super
		super.create();

		// create player
		player = new Player(FlxG.width / 4, FlxG.height / 4);

		hud = new Hud(player, 32, 32);
		setUpHeroPower(heroPowerSelection, player);
		add(heroPower);
		add(player);

		// set up the obstacle types
		setUpObstacles();
		// set up the obstacles that kill the player
		setUpDeadlyObstacles();

		add(hud);
	}

	private function setUpHeroPower(heroPowerSelect:HeroPowerEnum, player:Player) {
		if (heroPowerSelection == Invincible) {
			heroPower = new Invincible(player.x, player.y, player);
		} else if (heroPowerSelection == Aegis) {
			heroPower = new Aegis(player.x, player.y, player);
		}
		player.setPower(heroPower);
		hud.startPower(heroPower);
	}

	private function switchToHeroPowerSelection() {
		FlxG.switchState(new HeroPowerSelectionState());
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
		var baseDeadlyObstacleParameters = new ObstacleParameters(FlxG.width, 300, 500, 30, 15);
		var deadlyObstacleVariation = new ObstacleVariation(-1, 0, 1, 1);

		deadlyObstacleGenerator = new ObstacleGenerator<DeadlyObstacle>(SECONDS_PER_DEADLY_OBSTACLE, baseDeadlyObstacleParameters, deadlyObstacleVariation,
			generatedDeadlyObstacles);
		add(deadlyObstacleGenerator.obstacles);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		FlxG.overlap(player, obstacleGeneratorBot.obstacles, DeadlyObstacle.overlapsWithPlayer);
		FlxG.overlap(player, obstacleGeneratorMid.obstacles, DeadlyObstacle.overlapsWithPlayer);
		FlxG.overlap(player, obstacleGeneratorTop.obstacles, DeadlyObstacle.overlapsWithPlayer);

		if (FlxG.keys.justPressed.P) {
			switchToHeroPowerSelection();
		}

		FlxG.overlap(player, deadlyObstacleGenerator.obstacles, DeadlyObstacle.overlapsWithPlayer);
	}
}
