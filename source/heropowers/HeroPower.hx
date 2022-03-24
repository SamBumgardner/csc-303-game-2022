package heropowers;

import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class HeroPower extends FlxSprite
{
    public var hotkey:Array<FlxKey>;
    public var activeColor:FlxColor;
    public var usable:Bool;
    public var inUse:Bool;
    
    
    public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
        alpha = .5;
        hotkey = [FlxKey.K];
        usable = true;
        inUse = false;
        
	}
    public function setAlpha(){
        if (usable){
            alpha = .5;
        }else if (!usable && inUse){
            alpha = 1;	
        }
        else{
            alpha = 0;
        }
    }
    override public function update(elapsed:Float)
        {
            
        }

}