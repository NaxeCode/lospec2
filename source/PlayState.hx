package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxStarField.FlxStarField2D;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	public var player:Ship;
	public var enemyGroup:EnemyGroup;

	var bg:FlxStarField2D;
	override public function create()
	{
		super.create();

		// Fade from black slowly
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		Sounds.World1();
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
		handleCollisions();
		handlePause();
	}

	function handleCollisions()
	{
		FlxG.overlap(player.bulletPool, enemyGroup, (blt:Bullet, enm:Enemy) ->
		{
			blt.kill();
			enm.kill();
		});
	}

	function handlePause() {
		if (FlxG.keys.justPressed.ENTER)
		{
			openSubState(new PauseState(player));
		}
	}
}
