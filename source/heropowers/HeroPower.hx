package heropowers;

import flixel.input.keyboard.FlxKey;
import flixel.input.keyboard.FlxKeyList;
import openfl.ui.Keyboard;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;

class HeroPower extends FlxSprite
{
    public var hotkey:Array<FlxKey>;
    public var activeColor:FlxColor;
    public var usable:Bool;
    public var inUse:Bool;
    public function new(X:Float = 0, Y:Float = 0,
         activeColor:FlxColor)
	{
		super(X, Y);
        hotkey = [FlxKey.K];
        this.activeColor = activeColor;
        this.usable = true;
        this.inUse = false;
        this.makeGraphic(50, 50, activeColor);
	}

}