package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Beto
 */
class Balas extends FlxSprite 
{
	public function new(?X:Float, ?Y:Float, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(2, 2, 0xfffb2e01);
		velocity.x = 200;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
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