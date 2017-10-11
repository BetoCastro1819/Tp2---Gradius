package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Boss extends FlxSprite 
{
	var timer:Float = 0;
	var bullet:Balas;
	var shootDelay:Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
			
	}
	override public function update(elapsed:Float):Void
	{
		BossMovement();	
		shootDelay += elapsed;
		if (shootDelay > 0.6)
		{
			shoot();
			shoot2();
			shoot3();
			shootDelay = 0;
		}
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
	
	public function shoot():Void
	{
		bullet = new Balas(x + width / 2, y + height / 2);
		FlxG.state.add(bullet);
		bullet.velocity.x = -200;
	}
	public function shoot2():Void
	{
		bullet = new Balas(x + width / 4, y + height / 8); 
		FlxG.state.add(bullet);
		bullet.velocity.x = -200;
	}
	public function shoot3():Void
	{
		bullet = new Balas(x + width / 4, y + height - 11.625); 
		FlxG.state.add(bullet);
		bullet.velocity.x = -200;
	}
}