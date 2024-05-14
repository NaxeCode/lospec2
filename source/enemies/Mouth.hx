package enemies;

import flixel.util.FlxColor;

class Mouth extends Enemy
{
	public function new()
	{
		super();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}

class BadMouth extends Mouth
{
	public function new()
	{
		super();
	}

	override function createGraphic()
	{
		this.makeGraphic(14, 18, FlxColor.fromInt(0xFFff08ff));
	}
}

class Gossip extends Mouth
{
	public function new()
	{
		super();
	}

	override function createGraphic()
	{
		this.makeGraphic(14, 18, FlxColor.fromInt(0xFF6e0085));
	}
}