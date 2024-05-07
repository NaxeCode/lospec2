package;

import flixel.util.FlxColor;

class IceHedgehog extends Enemy
{
	public function new()
	{
		super();
	}

	override function createGraphic()
	{
		this.makeGraphic(14, 18, FlxColor.fromInt(0xFF0dffff));
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}