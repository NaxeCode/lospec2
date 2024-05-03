package;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class PauseState extends FlxSubState
{
	public function new()
	{
		super(0x33000000);
	}

	override function create()
	{
		super.create();

		var text = new FlxText();
		text.text = "- Paused -";
		text.color = FlxColor.PINK;
		text.size = 16;
		text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.RED, 4);
		text.screenCenter();

		var button = new FlxButton(0, 0, "Close SubState", closeSub);
		button.screenCenter();
		button.y = text.y + text.height + 16;

		var bg:FlxSprite = new FlxSprite();
		bg.makeGraphic(Std.int(text.width + 16), Std.int(text.height + button.height + 36), FlxColor.WHITE);
		FlxSpriteUtil.drawRect(bg, 1, 1, bg.width - 2, bg.height - 2, FlxColor.BLACK);
		bg.screenCenter();

		add(bg);
		add(text);
		add(button);
	}

	private function closeSub():Void
	{
		close();
	}
}