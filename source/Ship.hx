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

	public var SPEED:Int = 65;

	public var RECOIL:Int = 20;

	public var drag_X:Int = 1000;
	public var drag_Y:Int = 1000;
	public var maxVel_X:Int = 250;
	public var maxVel_Y:Int = 250;

	static inline var maxBulletAmount:Int = 30;

	public var bulletPool:FlxTypedGroup<Bullet>;
	var coolingDown:Bool = false;
	var coolingDownTimer:FlxTimer;

	public function new(X:Int = 0, Y:Int = 0)
	{
		super(X, Y);

		createGraphic();
		setPhysics();
		setupGun();
		FlxG.watch.add(this, "maxVelocity");
		FlxG.watch.add(this, "velocity");
	}

	function createGraphic()
	{
		makeGraphic(32, 32, FlxColor.GREEN);
	}

	public function setPhysics()
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
		// acceleration.set(0, 0);
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
			velocity.y += RECOIL;
			Sounds.PlayerShoots();
			bulletPool.recycle().setPosition(this.x + this.origin.x, this.y + this.origin.y);
			coolingDown = true;
			coolingDownTimer.reset();
		}

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		var tempSpeed:Float = SPEED;

		if (up && left || up && right || down && left || down && right)
			this.maxVelocity.set(maxVel_X / 1.4, maxVel_Y / 1.4);
		else
			this.maxVelocity.set(maxVel_X, maxVel_Y);

		if (up)
			velocity.y -= tempSpeed;
		if (down)
			velocity.y += tempSpeed;
		if (left)
			velocity.x -= tempSpeed;
		if (right)
			velocity.x += tempSpeed;

		// determine our velocity based on angle and speed
		// velocity.setPolarDegrees(SPEED, newAngle);
	}

	function handleMovementOLD()
	{
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		shoot = FlxG.keys.anyPressed([SPACE, Z]);
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
		}
	}
}
