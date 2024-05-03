package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxStarField.FlxStarField2D;

class PlayState extends FlxState
{
	public var player:Ship;
	public var enemyGroup:EnemyGroup;

	var bg:FlxStarField2D;
	override public function create()
	{
		super.create();

		bg = new FlxStarField2D(0, 0, FlxG.width, FlxG.height, 300);
		add(bg);

		addPlayer();
		addEnemies();
	}

	function addPlayer()
	{
		player = new Ship();
		player.screenCenter();
		add(player);
	}

	function addEnemies()
	{
		enemyGroup = new EnemyGroup();
		add(enemyGroup);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		handlePause();
	}

	function handlePause() {
		if (FlxG.keys.justPressed.ENTER)
		{
			
		}
	}
}
