package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.ui.FlxSlider;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class PauseState extends FlxSubState
{
	// SPEED
	// RECOIL
	// Drag X
	// Drag Y
	// Max Velocity X
	// Max Velocity Y
	var ship:Ship;

	public function new(playerInstance:Ship)
	{
		super();
		ship = playerInstance;
	}

	override function create()
	{
		super.create();

		addDebugUI();

		Sounds.MenuConfirm();

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

		// add(bg);
		// add(text);
		// add(button);
	}

	function addDebugUI()
	{
		var strang = "";
		var maxValue = 250;
		for (i in 0...6)
		{
			switch (i)
			{
				case 0:
					strang = "SPEED";
					maxValue = 200;
				case 1:
					strang = "RECOIL";
					maxValue = 100;
				case 2:
					strang = "drag_X";
					maxValue = 1500;
				case 3:
					strang = "drag_Y";
					maxValue = 1500;
				case 4:
					strang = "maxVel_X";
					maxValue = 500;
				case 5:
					strang = "maxVel_Y";
					maxValue = 500;
			}
			var debugUI = new FlxSlider(ship, strang, 0, 0, 0, maxValue, 100, 3, 10, 0xFFFFFFFF);
			debugUI.screenCenter();
			debugUI.x += 30;
			debugUI.y -= 75;
			debugUI.y += (i * 30);
			add(debugUI);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER)
		{
			closeSub();
		}
	}

	private function closeSub():Void
	{
		ship.setPhysics();
		Sounds.MenuConfirm();
		close();
	}
}