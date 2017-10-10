package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Beto Castro
 */
class BadGuy_1 extends FlxSprite 
{
	var timer:Float = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		this.kill();
	}
	
	override public function update(elapsed:Float):Void
	{
		BadGuy_1Movement();
	}
	
	public function BadGuy_1Movement()
    {
        timer += 1;
        if (timer > 0 && timer < 50){
            x -= 1;
        }
        if (timer > 50 && timer < 100){
            y -= 1;
        }
        if (timer > 100 && timer < 150){
            x -= 1;
        }
        if (timer > 150 && timer < 200){
            y += 1;
        }
        if(timer > 200){
            timer = 0;
        }
    }
}