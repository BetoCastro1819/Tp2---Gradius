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
	public var bullet:Balas;
	private var shootDelay:Float = 0;
	private var delay:Float;
	public var dead:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0,?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		width = 65 / 2;
		scale.set(0.5, 0.5);
		offset.set(16, 0);
		speed = 128;
		delay = 0.3;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		velocity.set(Reg.camVelocityX, 0);
		movement();
		shootDelay += elapsed;
		shoot();
		checkBorders();
	}
	
	public function death():Void
	{
		if (Global.lives <= 0)
		{
			dead = true;
		}
	}
	
	public function checkBorders():Void
	{
		if (x < FlxG.camera.scroll.x)
			x = FlxG.camera.scroll.x;
		if (x > (FlxG.camera.scroll.x + FlxG.camera.width) - width)
			x = FlxG.camera.scroll.x + FlxG.camera.width - width;
		if (y < 0)
			y = 0;
		if (y > FlxG.camera.height - height)
			y = FlxG.camera.height - height;
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
	
	public function shoot():Void
	{
		if (FlxG.keys.justPressed.Z && shootDelay >= delay)
		{
			shootDelay = 0;
			bullet = new Balas(x + width - 3, y + height / 2 - 2);
			FlxG.state.add(bullet);
			bullet.velocity.x = 200;	
		}
	}
}