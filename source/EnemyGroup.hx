package;

import Mouth.BadMouth;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

class EnemyGroup extends FlxTypedGroup<Enemy>
{
	static inline var enemyCount:Int = 10;
	var spawnTimer:FlxTimer;

	public function new()
	{
		super(enemyCount);

		addEnemies();
		setTimer();
	}

	function addEnemies()
	{
		for (i in 0...Std.int(enemyCount / 2))
		{
			var enemy = new IceHedgehog();
			enemy.kill();
			add(enemy);
			var enemy = new BadMouth();
			enemy.kill();
			add(enemy);
		}

		// FlxSpriteUtil.space(cast this.members, FlxG.width / 10, FlxG.height / 10, 35, null, false);
	}

	function setTimer()
	{
		spawnTimer = new FlxTimer().start(1, (timer:FlxTimer) ->
		{
			var enemy = recycle();
			enemy.setPosition(FlxG.width, FlxG.random.int(0, FlxG.height - 16));
			enemy.velocity.x = -100;
		}, 0);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}