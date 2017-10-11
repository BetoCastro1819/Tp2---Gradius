package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Beto Castro
 */
class BubbleBullet extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(10, 10, 0xffffffff);
		elasticity = 1;
		velocity.x = 200;
		velocity.y = 200;
	}
	
	override public function update(elapsed:Float):Void
	{
		borderCheck();
	}
	
	public function borderCheck():Void
	{
		if (x < FlxG.camera.scroll.x || x > (FlxG.camera.scroll.x + FlxG.camera.width) - width)
		{
			kill();			
		}
	}
}