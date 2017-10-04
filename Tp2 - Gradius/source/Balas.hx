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
	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		
		makeGraphic(2, 2, 0xfffb2e01);
		velocity.x = 200;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		//borderCheck();
	}
	
	//Ver que carajo pasa
	public function borderCheck():Void
	{
		if (x < FlxG.camera.x || x > FlxG.camera.x + FlxG.camera.width)
		{
			kill();
			trace("la bala murio");
		}
	}
}