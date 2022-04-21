package;

import obstacle.HorizontalObstacle;
import obstacle.VerticalObstacle;
import flixel.util.FlxColor;
import heropowers.HeroPowerSelectionState;
import heropowers.Aegis;
import heropowers.Invincible;
import heropowers.HeroPower;
import heropowers.PowerListEnum;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import obstacle.DeadlyObstacle;
import obstacle.FlyingEnemy;
import obstacle.Obstacle;
import obstacle.ObstacleGenerator;
import player.Player;
import tokens.Token;

class PlayState extends FlxState {
	var player:Player;
	var hud:Hud;

	var obstacleGeneratorTop:ObstacleGenerator<VerticalObstacle>;
	var obstacleGeneratorMid:ObstacleGenerator<VerticalObstacle>;
	var obstacleGeneratorBot:ObstacleGenerator<VerticalObstacle>;
	var heroPower:HeroPower;

	var horizontalObstacleGenerator:ObstacleGenerator<HorizontalObstacle>;
	var flyingEnemyGenerator:ObstacleGenerator<FlyingEnemy>;
	var tokenGenerator:ObstacleGenerator<Token>;

	var SECONDS_PER_OBSTACLE(default, never):Float = 1.3;
	var SECONDS_PER_DEADLY_OBSTACLE(default, never):Float = 4;
	var SECONDS_PER_FLYING_ENEMY(default, never):Float = 15;
	var SECONDS_PER_TOKEN(default, never):Float = 4;	//<

	public static var heroPowerSelection:HeroPowerEnum = Aegis;

	var ending:Bool = false; // Game Over condition

	override public function create() {
		// call super
		super.create();

		// create player
		player = new Player(FlxG.width / 4, FlxG.height / 4);

		hud = new Hud(player, 32, 32);
		setUpHeroPower(heroPowerSelection, player);
		add(heroPower);
		add(player);
		add(hud);

		// set up the obstacle types
		setUpObstacles();
		// set up the obstacles that kill the player
		setUpHorizontalObstacles();
		setUpFlyingEnemies();

		setUpTokens(); //<

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
		var generatedObstaclesTop = new FlxTypedGroup<VerticalObstacle>();
		var generatedObstaclesMid = new FlxTypedGroup<VerticalObstacle>();
		var generatedObstaclesBot = new FlxTypedGroup<VerticalObstacle>();
		final obstacleHeight = 35;
		final obstacleWidth = 10;
		final obstacleBaseSpeed = 175;
		// iterate and create some objects
		for (i in 0...5) {
			var obstacleT = new VerticalObstacle();
			var obstacleM = new VerticalObstacle();
			var obstacleB = new VerticalObstacle();
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
		var obstacleVariation = new ObstacleVariation(.9, 1, 2);
		// create an obstacle generator
		obstacleGeneratorTop = new ObstacleGenerator<VerticalObstacle>(SECONDS_PER_OBSTACLE, baseObstacleParametersTop, obstacleVariation,
			generatedObstaclesTop);
		obstacleGeneratorMid = new ObstacleGenerator<VerticalObstacle>(SECONDS_PER_OBSTACLE, baseObstacleParametersMid, obstacleVariation,
			generatedObstaclesMid);
		obstacleGeneratorBot = new ObstacleGenerator<VerticalObstacle>(SECONDS_PER_OBSTACLE, baseObstacleParametersBot, obstacleVariation,
			generatedObstaclesBot);
		// add the obstacles to the play state

		add(obstacleGeneratorTop.obstacles);
		add(obstacleGeneratorMid.obstacles);
		add(obstacleGeneratorBot.obstacles);
	}

	private function setUpHorizontalObstacles() {
		var generatedHorizontalObstacles = new FlxTypedGroup<HorizontalObstacle>();
		for (i in 0...5) {
			var obstacle = new HorizontalObstacle();
			obstacle.kill();
			generatedHorizontalObstacles.add(obstacle);
		}
		var baseHorizontalObstacleParameters = new ObstacleParameters(FlxG.width, 300, 500, 30, 15);
		var horizontalObstacleVariation = new ObstacleVariation(0, 1, 1);

		horizontalObstacleGenerator = new ObstacleGenerator<HorizontalObstacle>(SECONDS_PER_DEADLY_OBSTACLE, baseHorizontalObstacleParameters, 
			horizontalObstacleVariation, generatedHorizontalObstacles);
		add(horizontalObstacleGenerator.obstacles);
	}

	private function setUpFlyingEnemies() {
		var generatedFlyingEnemies = new FlxTypedGroup<FlyingEnemy>();

		var flyingEnemy = new FlyingEnemy();
		flyingEnemy.kill();
		generatedFlyingEnemies.add(flyingEnemy);

		var baseFlyingEnemyParameters = new ObstacleParameters(FlxG.width, FlxG.height, 50, 30, 30);
		var flyingEnemyVariation = new ObstacleVariation(-1, 0, 0);

		flyingEnemyGenerator = new ObstacleGenerator<FlyingEnemy>(SECONDS_PER_FLYING_ENEMY, 
			baseFlyingEnemyParameters, flyingEnemyVariation, generatedFlyingEnemies);
		add(flyingEnemyGenerator.obstacles);
	}	

	private function setUpTokens()
	{
		var generatedTokens = new FlxTypedGroup<Token>();
		for (i in 0...10)
		{
			var token = new Token(hud);

			token.kill();
			generatedTokens.add(token);
		}

		var baseTokenParameters = new ObstacleParameters(FlxG.width, FlxG.height, 100, 20, 20);
		var tokenVariation = new ObstacleVariation(1, 0, 0);

		tokenGenerator = new ObstacleGenerator<Token>(SECONDS_PER_TOKEN,
		baseTokenParameters, tokenVariation, generatedTokens);
		add(tokenGenerator.obstacles);
	}
	
	public function resetScore()
	{
		hud.removeScore();
	}
	
	override public function update(elapsed:Float) {
		super.update(elapsed);

		FlxG.overlap(player, obstacleGeneratorBot.obstacles, DeadlyObstacle.overlapsWithPlayer);
		FlxG.overlap(player, obstacleGeneratorMid.obstacles, DeadlyObstacle.overlapsWithPlayer);
		FlxG.overlap(player, obstacleGeneratorTop.obstacles, DeadlyObstacle.overlapsWithPlayer);
		// End anything else from happening if the game is ready to 'end'
		if (ending) {
			return;
		}

		if (FlxG.keys.justPressed.P) {
			switchToHeroPowerSelection();
		}

		FlxG.overlap(player, horizontalObstacleGenerator.obstacles, DeadlyObstacle.overlapsWithPlayer);
		FlxG.overlap(player, flyingEnemyGenerator.obstacles, FlyingEnemy.overlapsWithPlayer);
		FlxG.overlap(player, tokenGenerator.obstacles, Token.overlapsWithPlayer);	//<
		

		// End the game if the player reaches 0 lives or health
		if (player.health <= 0) {
			ending = true;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function gameOver() {
				FlxG.switchState(new GameOverState());
			});
		}
	}
}
