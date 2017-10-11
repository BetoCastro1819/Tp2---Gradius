package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.FlxAccelerometer;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Beto Castro
 */
class BadGuy_1 extends FlxSprite 
{
	var timer:Float = 0;
	var shootTimer:Float = 0;
	var bullet:Balas;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, AssetPaths.nave_enemiga1__png);
	}
	
	override public function update(elapsed:Float):Void
	{
		if (x < FlxG.camera.scroll.x + FlxG.camera.width)
		{
			BadGuy_1Movement();
			shootTimer += elapsed;
			if (shootTimer > 0.3)
			{
				enemyShoot();
				shootTimer = 0;
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
	
	public function enemyShoot()
	{
		bullet = new Balas(x + width - 3, y + height / 2 - 2);
		FlxG.state.add(bullet);
		bullet.velocity.x = -200;
	}
}