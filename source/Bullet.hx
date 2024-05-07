package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Bullet extends FlxSprite
{
	public var SPEED:Int = 500;

    public function new()
    {
        super(0, 0);

        createGraphic();
		setDefaultPhysics();
        kill();
    }

    function createGraphic() {
		makeGraphic(4, 6, FlxColor.WHITE);
    }

	public function setDefaultPhysics()
	{
		this.velocity.set(SPEED, 0);
	}

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}