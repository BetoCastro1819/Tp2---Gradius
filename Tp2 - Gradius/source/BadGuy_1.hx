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
	private var originalY:Float;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
	}
	
	override public function update(elapsed:Float):Void
	{
		if (alive)
		{
			//x -= 100;
		}
	}
	
	public function movement():Void
	{
		if (y > originalY + 10)
		{
			velocity.y = -20;
		}
		else if (y < originalY - 10)
		{
			velocity.y = 20;
		}
	}
}