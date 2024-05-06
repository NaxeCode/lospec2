package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Enemy extends FlxSprite
{
	public function new(X:Int = 0, Y:Int = 0)
	{
		super(X, Y);

		createGraphic();
		createPhysics();
		// kill();
	}

	function createGraphic()
	{
		makeGraphic(16, 16, FlxColor.RED);
	}

	function createPhysics() {}

	override function kill()
	{
		Sounds.EnemyDies();
		super.kill();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}