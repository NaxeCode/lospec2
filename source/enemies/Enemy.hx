package enemies;

import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Enemy extends FlxSprite
{
	var flickering:Bool = false;

	public var health:Int = 5;
	public var isHedgehog:Bool = false;

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

	public function hurt()
	{
		if (flickering)
			return;
		health -= 1;
		if (health <= 0)
			this.kill();
		FlxSpriteUtil.flicker(this, 1, 0.04, true, true, (flkr:FlxFlicker) ->
		{
			flickering = false;
		});
		flickering = true;
	}
}