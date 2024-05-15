package enemies;

import flixel.util.FlxColor;

class IceHedgehog extends Enemy
{
	var drag_X:Int = 100;
	var drag_Y:Int = 100;
	public function new()
	{
		super();
		this.isHedgehog = true;
		drag.set(drag_X, drag_Y);
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