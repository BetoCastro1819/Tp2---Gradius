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
	private var acum:Int = 0;	
	private var boss:Boss;
	private var cajita:Cajita;
	var camVelocityX:Float;
	var guia:FlxSprite;
	
	
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
		
		boss = new Boss();
		cajita = new Cajita();
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
		var boss = new Boss(5026, 15, AssetPaths.Boss__png);
		allEnemiesGroup.add(enemyGroup1);
		allEnemiesGroup.add(enemyGroup2);
		allEnemiesGroup.add(enemyGroup3);		
		cajita.makeGraphic(2, 2, 0xff000000);
		
		var background:FlxBackdrop = new FlxBackdrop(AssetPaths.Fondo__png);
		
		guia = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		guia.makeGraphic(1, 1, 0x00000000);
		guia.velocity.x = Reg.camVelocityX;		
		FlxG.camera.follow(guia);
		
		var cajOption = new FlxSprite(227,227);
		var cajOption2 = new FlxSprite(214, 227);
		var cajOption3 = new FlxSprite(201, 227);
		var cajOption4 = new FlxSprite(188, 227);
		cajOption.makeGraphic(8, 8, 0xffffffff);
		cajOption2.makeGraphic(8,8, 0xffffffff);
		cajOption3.makeGraphic(8,8, 0xffffffff);
		cajOption4.makeGraphic(8, 8, 0xffffffff);
		cajOption.velocity.x = Reg.camVelocityX;
		cajOption2.velocity.x = Reg.camVelocityX;
		cajOption3.velocity.x = Reg.camVelocityX;
		cajOption4.velocity.x = Reg.camVelocityX;
		
		add(guia);
		add(background);
		add(tilemap);
		add(player);
		add(allEnemiesGroup);
		add(arrayLives);
		add(boss);
		add(cajOption);
		add(cajOption2);
		add(cajOption3);
		add(cajOption4);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		colisiones();
		//trace(guia.x);
		if (guia.x > 4992)
		{
			guia.x = 4992;
			guia.velocity.x = 0;
		}
		
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
		FlxG.collide(cajita, player, playerCajitaColision);
	}
	
	function playerCajitaColision(c:Cajita, p:Player):Void 
	{
		trace("culo");
		p.kill();		
	}
	
	private function playerBulletTilemapColision(tile:FlxTilemap, bullet:Balas):Void
	{
		if (bullet.alive)
			bullet.kill();
	}
	
	private function playerBulletEnemy(b: Balas, e:FlxSprite)
	{		
		var cajita = new Cajita(e.x + 5, e.y + 5,AssetPaths.cajita__png);
		b.kill();
		e.kill();
		add(cajita);
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
			case "Boss":
                var boss = new Boss(X, Y, AssetPaths.Boss__png);               
		}
	}
	
	private function enemyMovement_1():Void
	{
		
	}
}
