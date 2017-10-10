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
	var bullet:Balas;
	var shootDelay:Float = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
	}
	
	override public function update(elapsed:Float):Void
	{
		if (x < FlxG.camera.scroll.x + FlxG.camera.width)
		{
			BadGuy_1Movement();
			shootDelay += elapsed;
			if (shootDelay > 0.1)
			{
				shoot();
				shootDelay = 0;
			}
		}
	}
	
	public function BadGuy_1Movement()
    {
        timer += 1;
        if (timer > 0 && timer < 50)
		{
            x -= 1;
        }
        if (timer > 50 && timer < 100)
		{
            y -= 1;
        }
        if (timer > 100 && timer < 150)
		{
            x -= 1;
        }
        if (timer > 150 && timer < 200)
		{
            y += 1;
        }
        if (timer > 200)
		{
            timer = 0;
        }
    }
	
	public function shoot():Void
	{
		bullet = new Balas(x + width/2, y + height / 2);
		FlxG.state.add(bullet);
		bullet.velocity.x = -200;
	}
}