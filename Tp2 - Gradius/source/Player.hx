package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Beto
 */
class Player extends FlxSprite 
{
	private var speed:Int;
	private var bullet:Balas;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		x -= width / 2;
		y -= height / 2;
		
		speed = 128;
		makeGraphic(16, 16, 0xfffb2e01);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		velocity.set(Reg.camVelocityX, 0);
		movement();
		shoot();
		//checkBorders();
	}
	
	public function checkBorders():Void
	{
		if (x < FlxG.camera.x || x > FlxG.camera.width)
		{
			velocity.x = 50;
		}
		else if (y < FlxG.camera.y || y > FlxG.camera.height)
		{
			velocity.y = 0;
		}
	}
	
	public function movement():Void
	{
		if (FlxG.keys.pressed.RIGHT)
			velocity.x += speed;
		if (FlxG.keys.pressed.LEFT)
			velocity.x -= speed;
		if (FlxG.keys.pressed.DOWN)
			velocity.y += speed;
		if (FlxG.keys.pressed.UP)
			velocity.y -= speed;	
	}
	
	
	//Dispara pero no visualiza la bala
	public function shoot():Void
	{
		if (FlxG.keys.justPressed.Z)
		{
			trace("ESTOY DISPARANDOO");
			bullet = new Balas(x + width / 2, y + height / 2);
			FlxG.state.add(bullet);
			bullet.velocity.x = 200;
		}
	}
}