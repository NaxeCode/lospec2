package enemies;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class IceHedgehog extends Enemy
{
	var drag_X:Int = 100;
	var drag_Y:Int = 100;
	public var hitCounter:Int = 5;
	public function new()
	{
		super();
		this.isHedgehog = true;
		// drag.set(drag_X, drag_Y);
	}

	override function createGraphic()
	{
		this.makeGraphic(14, 18, FlxColor.fromInt(0xFF0dffff));
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		bounce(this);
	}

	public function bounce(sprite:FlxSprite):FlxSprite
	{
		// Left
		if (((sprite.x + sprite.frameWidth / 2) <= 0))
		{
			sprite.velocity.x = -sprite.velocity.x;
		}
		// Right
		else if ((sprite.x >= FlxG.width))
		{
			sprite.velocity.x = -sprite.velocity.x;
		}
		// UP
		if (((sprite.y + sprite.frameHeight / 2) <= 0))
		{
			sprite.velocity.y = -sprite.velocity.y;
		}
		// Bottom
		else if ((sprite.y >= FlxG.height))
		{
			sprite.velocity.y = -sprite.velocity.y;
		}
		return sprite;
	}
}