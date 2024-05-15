package enemies;

import enemies.Mouth.BadMouth;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

enum EnemyType
{
	ICEHEDGE;
}
class EnemyGroup extends FlxTypedGroup<Enemy>
{
	static inline var enemyCount:Int = 10;

	var spawnTimer:FlxTimer;

	public function new()
	{
		super(enemyCount);

		// setTimer();
		addIceHedgehog();
	}

	private function addIceHedgehog()
	{
		var hedge = new IceHedgehog();
		hedge.screenCenter();
		hedge.x += 50;
		add(hedge);

		var mouth = new Mouth();
		mouth.screenCenter();
		mouth.y += 50;
		mouth.x += 35;
		add(mouth);
		mouth = new Mouth();
		mouth.screenCenter();
		mouth.y -= 50;
		mouth.x += 35;
		add(mouth);
	}

	public function addEnemies(howMany:Int = 1, enemyType:EnemyType)
	{
		for (i in 0...howMany)
		{
			var en = new IceHedgehog();
			add(en);
		}

		// FlxSpriteUtil.space(cast this.members, FlxG.width / 10, FlxG.height / 10, 35, null, false);
	}

	function setTimer()
	{
		spawnTimer = new FlxTimer().start(1, (timer:FlxTimer) ->
		{
			var enemy = recycle();
			enemy.setPosition(FlxG.width, FlxG.random.int(0, FlxG.height - 16));
			enemy.velocity.x = -80;
		}, 0);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}