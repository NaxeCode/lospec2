package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Bullet extends FlxSprite
{
    static inline var SPEED:Int = 500;

    public function new()
    {
        super(0, 0);

        createGraphic();
        setPhysics();
        kill();
    }

    function createGraphic() {
        makeGraphic(6, 6, FlxColor.WHITE);
    }

    function setPhysics() {
        this.velocity.y = -SPEED;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}