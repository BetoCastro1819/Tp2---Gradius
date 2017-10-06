package;

import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	private var tilemap:FlxTilemap;
	private var player:Player;
	private var enemyGroup:FlxTypedGroup<Enemy>;
	
	override public function create():Void
	{
		super.create();
		enemyGroup = new FlxTypedGroup<Enemy>();
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.Gradius__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.NONE);
		tilemap.setTileProperties(2, FlxObject.ANY);
		loader.loadEntities(placeEntities, "entities");
		var background:FlxBackdrop = new FlxBackdrop(AssetPaths.Fondo__png);
		
		var p:Player = new Player(FlxG.camera.x + FlxG.camera.width / 4, FlxG.camera.y + FlxG.camera.height / 2, AssetPaths.nave__png);			
		var guia:FlxSprite = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		guia.makeGraphic(1, 1, 0x00000000);
		guia.velocity.x = Reg.camVelocityX;
		
		FlxG.camera.follow(guia);
		add(guia);
		add(background);
		add(tilemap);
		add(p);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var X:Int = Std.parseInt(entityData.get("x"));
		var Y:Int = Std.parseInt(entityData.get("y"));
		
		switch (entityName)
		{
			case "player":
				//player = new Player(X, Y);
				//var player:Player = new Player(FlxG.camera.x + FlxG.camera.width / 4, FlxG.camera.y + FlxG.camera.height / 2);
				//add(player);
			case "enemy":
				var e:Enemy = new Enemy(X, Y);
				e.makeGraphic(16, 16, 0xff00ff00);
				enemyGroup.add(e);
		}
	}
}
/*Beto: el nivel de ogmo son 20 pantallas (5120 x 240)
la barra negra de abajo de todo es aproposito, es para tener donde poner el score, las vidas, etclass. (En le gradius original esta hecho asi)
*/