package;

import flixel.FlxG;

class Sounds
{
	static inline var vol_sfx:Float = 1.0;
	static inline var vol_music:Float = 0.25;

	public static function World1()
	{
		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			FlxG.sound.playMusic(AssetPaths.world_1__ogg, vol_music, true);
		}
	}

	public static function MenuNavi()
	{
		FlxG.sound.play(AssetPaths.menu_click_sfx__wav, vol_sfx);
	}

	public static function MenuConfirm()
	{
		FlxG.sound.play(AssetPaths.menu_confirm_sfx__wav, vol_sfx);
	}

	public static function EnemyShoots() {}

	public static function EnemyDies() {}

	public static function PlayerShoots()
	{
		FlxG.sound.play(AssetPaths.player_shoot_sfx__wav, vol_sfx);
	}
	public static function PlayerDies() {}
}