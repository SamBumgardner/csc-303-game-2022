package heropowers;

import flixel.input.FlxKeyManager;
import flixel.util.FlxColor;
import flixel.FlxG;

class Invincible extends HeroPower
{
    public function new(X:Float = 0, Y:Float = 0, activeColor:FlxColor)
	{
		super(X, Y, 0xFF800080);
	}

    override public function update(elapsed:Float)
        {
           if (this.active == true){
               if (FlxG.keys.anyPressed(this.hotkey)){
                   
               }
           }else{

           }
        }

}