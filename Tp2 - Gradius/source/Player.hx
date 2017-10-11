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
	public var bouncy:BubbleBullet;
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
		shootBubbleBullet();
		checkBorders();
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
	
	/* Esto debia ser un ataque de los enemigos, pero no logro que al ser balas de ellos, estas colisionen con el tilemap
	 * La bala gracias a la propiedad de "elasticity", rebota con el ambiente.
	 * Pero ahora no logro ni que funcione la velocidad en x,y.
	 */
	public function shootBubbleBullet():Void
	{
		if (FlxG.keys.justPressed.X)
		{
			bouncy = new BubbleBullet(x, y);
			FlxG.state.add(bouncy);
			bouncy.velocity.x = 200;	
			bouncy.velocity.y = 200;
		}
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