package utils;

import flixel.FlxSprite;

class HelperFunctions
{
	public static function moveTowardsWithForce(objCurrent:FlxSprite, objTarget:FlxSprite, forceX:Int, forceY:Int)
	{
		var xDiff = (objCurrent.x + objCurrent.origin.x) - (objTarget.x + objTarget.origin.x);
		var yDiff = (objCurrent.y + objCurrent.origin.y) - (objTarget.y + objTarget.origin.y);

		var angle = Math.atan2(yDiff, xDiff);

		objCurrent.velocity.set(Math.cos(angle) * forceX, Math.sin(angle) * forceY);
	}
}