package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxSpriteUtil;

class EnemyGroup extends FlxTypedGroup<Enemy>
{
	static inline var enemyCount:Int = 10;

	public function new()
	{
		super(enemyCount);

		addEnemies();
	}

	function addEnemies()
	{
		for (i in 0...enemyCount)
		{
			var enemy = new Enemy(0, 0);
			add(enemy);
		}

		FlxSpriteUtil.space(cast this.members, 100, 100, 35, null, false);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}