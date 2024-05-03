package;

import flixel.FlxG;

class Sounds
{
	public static function playMenuConfirm()
	{
		FlxG.sound.play(AssetPaths.menu_confirm_sfx__wav);
	}
}