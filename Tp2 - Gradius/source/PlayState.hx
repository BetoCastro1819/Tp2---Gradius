package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;

class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();
		
		var background:FlxBackdrop = new FlxBackdrop(AssetPaths.Fondo__png);
		
		var p:Player = new Player(200, 200);
		
		var guia:FlxSprite = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		guia.makeGraphic(1, 1, 0x00000000);
		guia.velocity.x = Reg.camVelocityX;
		
		FlxG.camera.follow(guia);
		
		add(guia);
		add(background);
		add(p);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}