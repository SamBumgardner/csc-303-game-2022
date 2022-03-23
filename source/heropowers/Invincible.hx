package heropowers;

import flixel.util.FlxTimer;
import flixel.util.FlxTimer.FlxTimerManager;
import js.html.AbortController;
import flixel.input.FlxKeyManager;
import flixel.util.FlxColor;
import flixel.FlxG;

class Invincible extends HeroPower
{
    public function new(X:Float = 0, Y:Float = 0, activeColor:FlxColor)
	{
		super(X, Y, 0xFF800080);
	}
    public function onTimer(Timer:FlxTimer){
        this.inUse = false;
    }
    override public function update(elapsed:Float)
        {
           if (this.usable == true){
               if (FlxG.keys.anyPressed(this.hotkey)){
                   this.inUse = true;
                   this.usable = false;
                   var invincibleDuration:FlxTimer;
                   invincibleDuration.start(4, onTimer, 1);

               }
           }else{
                
           }
        }

}