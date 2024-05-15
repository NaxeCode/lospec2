package;

import flixel.FlxGame;
import openfl.display.Sprite;
import stages.GardenState;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(256, 224, GardenState));
	}
}
