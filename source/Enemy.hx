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
		makeGraphic(32, 32, FlxColor.RED);
	}

	function createPhysics() {}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}