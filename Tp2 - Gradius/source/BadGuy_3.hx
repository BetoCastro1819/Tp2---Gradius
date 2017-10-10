package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.FlxAccelerometer;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Beto Castro
 */
class BadGuy_3 extends FlxSprite 
{
	var timer:Float = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
	}
	
	override public function update(elapsed:Float):Void
	{
		if (x < FlxG.camera.scroll.x + FlxG.camera.width)
		{
			BadGuy_3Movement();
		}
	}
	
	public function BadGuy_3Movement()
    {
        timer += 1;
        if (timer > 0)
        {
            x -= 2;
        }
        else if (timer > 25)
        {
            x -= 3;
        }
        else if (timer > 75)
        {
            x -= 4;
        }
        else if (timer > 100)
        {
            x -= 5;
        }
    }
}