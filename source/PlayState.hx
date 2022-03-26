package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import obstacle.DeadlyObstacle;
import obstacle.Obstacle;
import obstacle.ObstacleGenerator;
import player.Player;
import tokens.Token;
import tokens.TokenGenerator;

class PlayState extends FlxState
{
	var player:Player;

	var obstacleGenerator:ObstacleGenerator<Obstacle>;
	var deadlyObstacleGenerator:ObstacleGenerator<DeadlyObstacle>;
	var tokenGenerator:TokenGenerator<Token>;

	var SECONDS_PER_OBSTACLE(default, never):Float = .5;
	var SECONDS_PER_DEADLY_OBSTACLE(default, never):Float = 2;
	var SECONDS_PER_TOKEN(default, never):Float = 4;


	override public function create()
	{
		super.create();

		player = new Player(FlxG.width / 2, FlxG.height / 2);
		add(player);

		setUpObstacles();
		setUpDeadlyObstacles();
		setUpTokens();
	}

	private function setUpObstacles()
	{
		var generatedObstacles = new FlxTypedGroup<Obstacle>();
		for (i in 0...10)
		{
			var obstacle = new Obstacle();
			obstacle.kill();
			generatedObstacles.add(obstacle);
		}

		var baseObstacleParameters = new ObstacleParameters(FlxG.width, FlxG.height, 200, 10, 50);
		var obstacleVariation = new ObstacleVariation(-1, .9, 1, 2);

		obstacleGenerator = new ObstacleGenerator<Obstacle>(SECONDS_PER_OBSTACLE,
			baseObstacleParameters, obstacleVariation, generatedObstacles);
		add(obstacleGenerator.obstacles);
	}

	private function setUpDeadlyObstacles()
	{
		var generatedDeadlyObstacles = new FlxTypedGroup<DeadlyObstacle>();
		for (i in 0...10)
		{
			var obstacle = new DeadlyObstacle();
			obstacle.kill();
			generatedDeadlyObstacles.add(obstacle);
		}
		var baseDeadlyObstacleParameters = new ObstacleParameters(FlxG.width, FlxG.height, 50, 50,
			50);
		var deadlyObstacleVariation = new ObstacleVariation(-1, 1, 1, 1);

		deadlyObstacleGenerator = new ObstacleGenerator<DeadlyObstacle>(SECONDS_PER_DEADLY_OBSTACLE,
			baseDeadlyObstacleParameters, deadlyObstacleVariation,
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
	
			var baseTokenParameters = new TokenParameters(FlxG.width, FlxG.height, 200, 10, 50);
			var tokenVariation = new TokenVariation(-1, 1, 1, 1);
	
			tokenGenerator = new TokenGenerator<Token>(SECONDS_PER_TOKEN,
			baseTokenParameters, tokenVariation, generatedTokens);
			add(tokenGenerator.tokens);
		}


	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, obstacleGenerator.obstacles);
		FlxG.overlap(player, deadlyObstacleGenerator.obstacles, DeadlyObstacle.overlapsWithPlayer);
		FlxG.overlap(player, tokenGenerator.tokens, Token.overlapsWithPlayer);
	}
}
