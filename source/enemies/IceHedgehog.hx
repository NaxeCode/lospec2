package enemies;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import stages.GardenState;

class IceHedgehog extends Enemy
{
	var drag_X:Int = 600;
	var drag_Y:Int = 600;
	public var hitCounter:Int = 5;
	public function new()
	{
		super();
		this.isHedgehog = true;
	}

	override function createGraphic()
	{
		this.makeGraphic(14, 18, FlxColor.fromInt(0xFF0dffff));
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		handleCollision();
		bounce(this);
	}

	function handleCollision()
	{
		FlxG.collide(this, GardenState.enemyGroup, (hedge:IceHedgehog, enm:Enemy) ->
		{
			hedge.velocity.x = -hedge.velocity.x;
			hedge.velocity.y = -hedge.velocity.y;
			hedge.hurt();
			enm.hurt();
			enm.drag.set(drag_X, drag_Y);
		});
	}
	public function bounce(sprite:FlxSprite):FlxSprite
	{
		// Left / Right
		if (((sprite.x + sprite.frameWidth / 2) <= 0) || (sprite.x >= FlxG.width))
		{
			sprite.velocity.x = -sprite.velocity.x;
		}
		// Up / Bottom
		if (((sprite.y + sprite.frameHeight / 2) <= 0) || (sprite.y >= FlxG.height))
		{
			sprite.velocity.y = -sprite.velocity.y;
		}
		return sprite;
	}
}