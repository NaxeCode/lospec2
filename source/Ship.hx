package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Ship extends FlxSprite
{
	var up:Bool = false;
	var down:Bool = false;
	var left:Bool = false;
	var right:Bool = false;
	var shoot:Bool = false;

	static inline var SPEED:Int = 1500;

	var drag_X:Int = 1500;
	var drag_Y:Int = 1500;
	var maxVel_X:Int = 300;
	var maxVel_Y:Int = 300;

	static inline var maxBulletAmount:Int = 30;

	public var bulletPool:FlxTypedGroup<Bullet>;
	var coolingDown:Bool = false;
	var coolingDownTimer:FlxTimer;

	public function new(X:Int = 0, Y:Int = 0)
	{
		super(X, Y);

		createGraphic();
		createPhysics();
		setupGun();
	}

	function createGraphic()
	{
		makeGraphic(32, 32, FlxColor.GREEN);
	}

	function createPhysics()
	{
		this.drag.set(drag_X, drag_Y);
		this.maxVelocity.set(maxVel_X, maxVel_Y);
	}

	function setupGun()
	{
		coolingDownTimer = new FlxTimer().start(0.10, (timer:FlxTimer)->{ coolingDown = false; });
		bulletPool = new FlxTypedGroup<Bullet>(maxBulletAmount);
		for (i in 0...maxBulletAmount)
		{
			var bullet = new Bullet();
			bulletPool.add(bullet);
		}
		FlxG.state.add(bulletPool);
	}

	override function update(elapsed:Float)
	{
		updatePhysics();
		updateControls();
		super.update(elapsed);
	}

	function updatePhysics()
	{
		acceleration.set(0, 0);
	}

	function updateControls()
	{
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		shoot = FlxG.keys.anyPressed([SPACE, Z]);

		if (shoot && !coolingDown)
		{
			Sounds.PlayerShoots();
			bulletPool.recycle().setPosition(this.x + this.origin.x, this.y + this.origin.y);
			coolingDown = true;
			coolingDownTimer.reset();
		}

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up || down || left || right)
		{
			var newAngle:Float = 0;
			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
				facing = UP;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
				facing = DOWN;
			}
			else if (left)
			{
				newAngle = 180;
				facing = LEFT;
			}
			else if (right)
			{
				newAngle = 0;
				facing = RIGHT;
			}

			// determine our velocity based on angle and speed
			acceleration.setPolarDegrees(SPEED, newAngle);
		}
	}
}
