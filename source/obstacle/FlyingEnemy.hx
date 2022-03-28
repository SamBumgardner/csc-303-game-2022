package obstacle;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.util.FlxColor;
import obstacle.Obstacle.ObstacleParameters;

class FlyingEnemy extends Obstacle
{
    override function init(parameters:ObstacleParameters)
    {
        super.init(parameters);
        color = FlxColor.BLUE;
        acceleration.y = 50;
    }

    public static function overlapsWithPlayer(player:FlxBasic, flyingEnemy:FlyingEnemy)
    {
        player.kill();
        flyingEnemy.kill();
    }

    override function update(elapsed:Float)
    {
        if (movedOffScreen())
        {
            kill();
        }

        flap();
        super.update(elapsed);
    }

    private function flap()
    {
        velocity.y = -100;
    }
}