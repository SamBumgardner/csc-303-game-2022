package;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.system.debug.Window;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Hud extends FlxTypedGroup<FlxSprite> {

    var background:FlxSprite;
    var livesSprite:FlxSprite;
    var livesCounter:FlxText;
    var scoreSprite:FlxSprite;
    var scoreCounter:FlxText;
    var abilitySprite:FlxSprite;
    var abilityBar:FlxSprite;
    var lives:Int;
    var score:Int;

    public function new(?textSize:Int=16, ?spriteSize:Int=32)
    {
        super();
        //Transparent black
        background = new FlxSprite().makeGraphic(FlxG.width, Std.int(FlxG.height / 10), 0x55000000);

        var spriteHeight:Float = (background.height - spriteSize) / 2;
        //var textHeight:Float = (background.height - textSize) / 2;
        var textHeight:Float = 0;
        var textOffset:Float = spriteSize / 2;

        livesSprite = new FlxSprite(0, 0, AssetPaths.lives__png);
        livesSprite.setGraphicSize(spriteSize, spriteSize);
        livesSprite.updateHitbox();
        livesSprite.setPosition(FlxG.width / 100, spriteHeight);
        livesCounter = new FlxText(livesSprite.x + livesSprite.width + textOffset, textHeight, 0, "3", textSize);

        scoreSprite = new FlxSprite(0, 0, AssetPaths.score__png);
        scoreSprite.setGraphicSize(spriteSize, spriteSize);
        scoreSprite.updateHitbox();
        scoreSprite.setPosition(FlxG.width - FlxG.width / 10 - spriteSize, spriteHeight);
        scoreCounter = new FlxText(scoreSprite.x + scoreSprite.width + textOffset, textHeight, 0, "3", textSize);

        abilitySprite = new FlxSprite(livesCounter.x + livesCounter.width + textOffset * 2, spriteHeight).makeGraphic(spriteSize, spriteSize, 0xffffffff);
        abilityBar = new FlxSprite(abilitySprite.x + abilitySprite.width + textOffset, spriteHeight).makeGraphic(Std.int(FlxG.width / 5), spriteSize, 0xffffffff);

        add(background);
        add(livesSprite);
        add(livesCounter);
        add(scoreCounter);
        add(scoreSprite);
        add(abilitySprite);
        add(abilityBar);
    }

    public function addScore(score:Int)
    {
        this.score += score;
        scoreCounter.text = "" + this.score;
    }

    public function incrementLives()
    {
        livesCounter.text = "" + (++lives);
    }

    public function decrementLives()
    {
        livesCounter.text = "" + (--lives);
    }

    public function startAbility()
    {
        //TODO: Integrate with sam's abilities branch
        return;
    }

    public function endAbility()
    {
        //TODO: Integrate with sam's abilities branch
        return;
    }

}