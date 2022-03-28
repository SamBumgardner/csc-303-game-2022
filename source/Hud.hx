package;

import heropowers.HeroPower;
import player.Player;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.system.debug.Window;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Hud extends FlxTypedGroup<FlxSprite> {

    var player:Player;
    var background:FlxSprite;
    var livesSprite:FlxSprite;
    var livesCounter:FlxText;
    var scoreSprite:FlxSprite;
    var scoreCounter:FlxText;
    var abilitySprite:FlxSprite;
    var abilityText:FlxText;
    var score:Int;

    public function new(player_:Player, ?textSize:Int=16, ?spriteSize:Int=32)
    {
        super();

        player = player_;
        score = 0;

        //Transparent black
        background = new FlxSprite().makeGraphic(FlxG.width, Std.int(FlxG.height / 10), 0x55000000);

        var spriteHeight:Float = (background.height - spriteSize) / 2;
        //var textHeight:Float = (background.height - textSize) / 2;
        var textHeight:Float = 0;
        var textOffset:Float = spriteSize / 2;

        livesSprite = makeSprite(livesSprite, AssetPaths.lives__png, FlxG.width / 100, spriteHeight, spriteSize);
        livesCounter = new FlxText(livesSprite.x + livesSprite.width + textOffset, textHeight, 0, "" + player.health, textSize);
        livesCounter.scrollFactor.set(0, 0);

        scoreSprite = makeSprite(scoreSprite, AssetPaths.score__png, FlxG.width - spriteSize - (4 * textSize) - textOffset, spriteHeight, spriteSize);
        scoreCounter = new FlxText(scoreSprite.x + scoreSprite.width + textOffset, textHeight, 0, "" + score, textSize);
        scoreCounter.scrollFactor.set(0, 0);

        abilitySprite = new FlxSprite(livesCounter.x + livesCounter.width + textOffset * 2, spriteHeight).makeGraphic(spriteSize, spriteSize, 0xffffffff);
        abilityText = new FlxText(abilitySprite.x + spriteSize + textOffset, textHeight, 0, "", textSize);
        abilitySprite.scrollFactor.set(0, 0);
        abilityText.scrollFactor.set(0, 0);

        add(background);
        add(livesSprite);
        add(livesCounter);
        add(scoreCounter);
        add(scoreSprite);
        add(abilitySprite);
        add(abilityText);
    }

    override public function update(elapsed:Float)
    {
        setLivesText();
    }

    private function makeSprite(sprite:FlxSprite, assetPath:String, spriteX:Float, spriteHeight:Float, spriteSize:Int)
    {
        sprite = new FlxSprite(0, 0, assetPath);
        sprite.setGraphicSize(spriteSize, spriteSize);
        sprite.updateHitbox();
        sprite.setPosition(spriteX, spriteHeight);
        sprite.scrollFactor.set(0, 0);
        return sprite;
    }

    public function addScore(score:Int)
    {
        this.score += score;
        scoreCounter.text = "" + this.score;
    }

    public function setLivesText()
    {
        livesCounter.text = "" + player.health;
    }

    public function startPower(power:HeroPower)
    {
        abilitySprite.color = power.color;
        abilityText.text = power.toString();
    }

    public function endPower()
    {
        abilitySprite.color = 0x00000000;
        abilityText.text = "";
    }

}