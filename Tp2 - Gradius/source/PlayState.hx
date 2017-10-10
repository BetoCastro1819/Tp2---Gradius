package;

import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	private var tilemap:FlxTilemap;
	private var player:Player;
	private var allEnemiesGroup:FlxGroup;
	private var enemyGroup1:FlxTypedGroup<BadGuy_1>;
	private var enemyGroup2:FlxTypedGroup<BadGuy_2>;
	private var enemyGroup3:FlxTypedGroup<BadGuy_3>;
	private var arrayLives:FlxTypedGroup<FlxSprite>;
	private var spriteLife:FlxSprite;
	private var respawnDelay:Float = 0;
	
	override public function create():Void
	{
		super.create();
		
		FlxG.worldBounds.width = 5120;
		FlxG.worldBounds.height = 240;
		
		arrayLives = new FlxTypedGroup<FlxSprite>();
		//Global.lives = 3;
		for ( i in 0...Global.lives)
		{
			spriteLife = new FlxSprite((FlxG.camera.scroll.x + i * 25) - 15, FlxG.camera.height - 20, AssetPaths.nave__png);
			spriteLife.scale.x = 0.3;
			spriteLife.scale.y = 0.3;
			spriteLife.velocity.x = Reg.camVelocityX;
			arrayLives.add(spriteLife);
		}
		
		allEnemiesGroup = new FlxGroup();
		enemyGroup1 = new FlxTypedGroup<BadGuy_1>();
		enemyGroup2 = new FlxTypedGroup<BadGuy_2>();
		enemyGroup3 = new FlxTypedGroup<BadGuy_3>();
		
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.GradiusOld__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.NONE);
		tilemap.setTileProperties(22, FlxObject.ANY);
		tilemap.setTileProperties(23, FlxObject.ANY);
		tilemap.setTileProperties(4, FlxObject.ANY);
		tilemap.setTileProperties(5, FlxObject.ANY);
		loader.loadEntities(placeEntities, "entities");
		
		allEnemiesGroup.add(enemyGroup1);
		allEnemiesGroup.add(enemyGroup2);
		allEnemiesGroup.add(enemyGroup3);		
		
		var background:FlxBackdrop = new FlxBackdrop(AssetPaths.Fondo__png);
		
		var guia:FlxSprite = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		guia.makeGraphic(1, 1, 0x00000000);
		guia.velocity.x = Reg.camVelocityX;
		FlxG.camera.follow(guia);
		
		add(guia);
		add(background);
		add(tilemap);
		add(player);
		add(allEnemiesGroup);
		add(arrayLives);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		colisiones();
		
		if (!player.alive && Global.lives >= 0)
		{
			respawnDelay += elapsed;
			if (respawnDelay >= 1)
			{
				player.reset(FlxG.camera.scroll.x + 20, (FlxG.camera.height / 2) - 10);
				respawnDelay = 0;
			}
		}
	}
	
	private function colisiones():Void
	{
		FlxG.collide(tilemap, player, playerTilemapColision);
		FlxG.collide(allEnemiesGroup, player, playerEnemyColision);
		FlxG.collide(tilemap, player.bullet, playerBulletTilemapColision);
		FlxG.collide(allEnemiesGroup, player.bullet, playerBulletEnemy);
	}
	
	private function playerBulletTilemapColision(tile:FlxTilemap, bullet:Balas):Void
	{
		if (bullet.alive)
			bullet.kill();
	}
	
	private function playerBulletEnemy(b: Balas, e:FlxSprite)
	{
		b.kill();
		e.kill();
	}
	
	private function playerEnemyColision(e:FlxSprite, p:Player):Void
	{
		player.kill();
		e.kill();
		Global.lives--;
		arrayLives.remove(arrayLives.getFirstAlive(), true);
	}
	private function playerTilemapColision(t:FlxTilemap, p:Player)
	{
		player.kill();
		Global.lives--;
		arrayLives.remove(arrayLives.getFirstAlive(), true);	
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var X:Int = Std.parseInt(entityData.get("x"));
		var Y:Int = Std.parseInt(entityData.get("y"));
		
		switch (entityName)
		{
			case "personaje":
				player = new Player(X, Y, AssetPaths.nave__png);
			case "Enemigo1":
				var badGuy_1 = new BadGuy_1(X, Y, AssetPaths.nave_enemiga1__png);
				enemyGroup1.add(badGuy_1);
			case "Enemigo2":
				var badGuy_2 = new BadGuy_2(X, Y, AssetPaths.nave_enemiga2__png);
				enemyGroup2.add(badGuy_2);
			case "Enemigo3":
				var badGuy_3 = new BadGuy_3(X, Y, AssetPaths.nave_enemiga3__png);
				enemyGroup3.add(badGuy_3);
		}
	}
	
	private function enemyMovement_1():Void
	{
		
	}
}
/*Beto: el nivel de ogmo son 20 pantallas (5120 x 240)
la barra negra de abajo de todo es aproposito, es para tener donde poner el score, las vidas, etclass. (En le gradius original esta hecho asi)
*/