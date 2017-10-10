package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Boss extends FlxSprite 
{
	var timer:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
			
	}
	override public function update(elapsed:Float):Void
	{
		BossMovement();	
	}
	public function BossMovement()
	{
		timer += 1;
		
		if (timer > 0 && timer < 90)
		{
			y += 1;
		}
		if (timer > 90 && timer < 180)
		{
			y -= 1;
		}
		if (timer > 180)
		{
			timer = 0;
		}
	}
	
	
}