package obstacle;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import obstacle.Obstacle.ObstacleParameters;

class FlyingEnemy extends Obstacle
{
    private var flapTimer:FlxTimer = new FlxTimer();
    private var flapDelay:Float = 1.5;

    override function init(parameters:ObstacleParameters)
    {
        super.init(parameters);
        color = FlxColor.BLUE;

        makeGraphic(parameters.width, parameters.height);

        acceleration.y = 200;

        // Initial flap call to prevent enemy from falling
        flap(flapTimer);
        // Looping timer to flap enemy up
        flapTimer.start(flapDelay, flap, 0);
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

        super.update(elapsed);
    }

    public function flap(timer:FlxTimer)
    {
        velocity.y = -165;
    }
} 