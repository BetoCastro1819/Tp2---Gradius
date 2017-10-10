package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Beto Castro
 */
class BadGuy_2 extends FlxSprite 
{
	
	var timer:Float = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//velocity.x = -100;
		//loadGraphic(AssetPaths.nave_enemiga2__png);
		
	}
	
	override public function update(elapsed:Float):Void
	{
		BadGuy_2Movement();
	}
	
	public function BadGuy_2Movement()
    {
        timer += 1;
        if (timer > 0 && timer < 100)
        {
            x -= 1;
            y += 0.5;
        }
        if (timer > 100 && timer < 200)
        {
            x -= 1;
            y -= 0.5;
        }
        if (timer > 200)
        {
            timer = 0;
        }

    }
	
}