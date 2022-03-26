package tokens;

import flixel.FlxBasic;
import tokens.Token.TokenParameters;


class ScoreToken extends Token
{
	public static function overlapsWithPlayer(player:FlxBasic, scoreToken:ScoreToken)
	{
		scoreToken.kill();  //Remove token
        //scoreToken.score += 1;    //Add 1 to coin score
	}
}
