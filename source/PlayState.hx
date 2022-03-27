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
import tokens.Token;


class PlayState extends FlxState {
	var player:Player;
	var hud:Hud;

	var heroPower:HeroPower;

	var obstacleGenerator:ObstacleGenerator<Obstacle>;
	var deadlyObstacleGenerator:ObstacleGenerator<DeadlyObstacle>;
	var tokenGenerator:ObstacleGenerator<Token>;

	var SECONDS_PER_OBSTACLE(default, never):Float = .5;
	var SECONDS_PER_DEADLY_OBSTACLE(default, never):Float = 2;
	var SECONDS_PER_TOKEN(default, never):Float = 4;


	public static var heroPowerSelection:HeroPowerEnum = Aegis;

	override public function create() {
		super.create();

		player = new Player(FlxG.width / 2, FlxG.height / 2);
		hud = new Hud(player, 32, 32);
		setUpHeroPower(heroPowerSelection, player);
		add(heroPower);
		add(player);
		add(hud);

		setUpObstacles();
		setUpDeadlyObstacles();
		setUpTokens();
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
		var generatedObstacles = new FlxTypedGroup<Obstacle>();
		for (i in 0...10) {
			var obstacle = new Obstacle();
			obstacle.kill();
			generatedObstacles.add(obstacle);
		}

		var baseObstacleParameters = new ObstacleParameters(FlxG.width, FlxG.height, 200, 10, 50);
		var obstacleVariation = new ObstacleVariation(-1, .9, 1, 2);

		obstacleGenerator = new ObstacleGenerator<Obstacle>(SECONDS_PER_OBSTACLE, baseObstacleParameters, obstacleVariation, generatedObstacles);
		add(obstacleGenerator.obstacles);
	}

	private function setUpDeadlyObstacles() {
		var generatedDeadlyObstacles = new FlxTypedGroup<DeadlyObstacle>();
		for (i in 0...10) {
			var obstacle = new DeadlyObstacle();
			obstacle.kill();
			generatedDeadlyObstacles.add(obstacle);
		}
		var baseDeadlyObstacleParameters = new ObstacleParameters(FlxG.width, FlxG.height, 50, 50, 50);
		var deadlyObstacleVariation = new ObstacleVariation(-1, 1, 1, 1);

		deadlyObstacleGenerator = new ObstacleGenerator<DeadlyObstacle>(SECONDS_PER_DEADLY_OBSTACLE, baseDeadlyObstacleParameters, deadlyObstacleVariation,
			generatedDeadlyObstacles);
		add(deadlyObstacleGenerator.obstacles);
	}

	private function setUpTokens()
		{
			var generatedTokens = new FlxTypedGroup<Token>();
			for (i in 0...10)
			{
				var token = new Token();

				token.kill();
				generatedTokens.add(token);
			}
	
			var baseTokenParameters = new ObstacleParameters(FlxG.width, FlxG.height, 100, 20, 20);
			var tokenVariation = new ObstacleVariation(-1, 1, 0, 0);
	
			tokenGenerator = new ObstacleGenerator<Token>(SECONDS_PER_TOKEN,
			baseTokenParameters, tokenVariation, generatedTokens);
			add(tokenGenerator.obstacles);
		}


	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.P) {
			switchToHeroPowerSelection();
		}

		FlxG.collide(player, obstacleGenerator.obstacles);
		FlxG.overlap(player, deadlyObstacleGenerator.obstacles, DeadlyObstacle.overlapsWithPlayer);
		FlxG.overlap(player, tokenGenerator.obstacles, Token.overlapsWithPlayer);
	}
}
