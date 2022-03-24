package heropowers;

import flixel.util.FlxTimer;
import flixel.FlxG;

class Invincible extends HeroPower
{
    public var invincibleDuration:FlxTimer = new FlxTimer();
    public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
        activeColor = 0xFFF33383;
       
	}
    public function onTimer(Timer:FlxTimer){
        inUse = false;
    }
    override public function toString(){
        return "Invincible";
    }

    override public function update(elapsed:Float)
        {
            setAlpha();
           if (usable == true){
               if (FlxG.keys.anyPressed(hotkey)){
                   inUse = true;
                   usable = false;
                   invincibleDuration.start(4, onTimer, 1);
               }
           }else{
                if(FlxG.keys.justPressed.L){
                    usable = true;
                }
           }
        }

}