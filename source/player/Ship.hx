package player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

class Ship extends FlxSprite
{
	var health:Int = 5;
	var flickering:Bool = false;

	var up:Bool = false;
	var down:Bool = false;
	var left:Bool = false;
	var right:Bool = false;
	var shoot:Bool = false;

	public var SPEED:Int = 40;

	public var RECOIL:Int = 20;

	public var drag_X:Int = 1000;
	public var drag_Y:Int = 1000;
	public var maxVel_X:Int = 150;
	public var maxVel_Y:Int = 150;

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
		makeGraphic(16, 16, FlxColor.fromInt(0xFF007062));
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

	var dir:String = "";
	function updateControls()
	{
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		shoot = FlxG.keys.anyPressed([SPACE, Z]);

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
		{
			dir = "up";
			velocity.y -= tempSpeed;
		}
		if (down)
		{
			dir = "down";
			velocity.y += tempSpeed;
		}
		if (left)
		{
			dir = "left";
			velocity.x -= tempSpeed;
		}
		if (right)
		{
			dir = "right";
			velocity.x += tempSpeed;
		}

		if (up && left)
			dir = "upL";
		if (up && right)
			dir = "upR";
		if (down && left)
			dir = "downL";
		if (down && right)
			dir = "downR";

		if (shoot && !coolingDown)
		{
			var tempRecoilY = 0;
			var tempRecoilX = 0;
			Sounds.PlayerShoots();
			var bllt = bulletPool.recycle();
			bllt.setPosition(this.x + this.origin.x, this.y + this.origin.y);
			switch (dir)
			{
				case "upL":
					tempRecoilY += RECOIL;
					tempRecoilX += RECOIL;
					bllt.velocity.set(-bllt.SPEED, -bllt.SPEED);
				case "upR":
					bllt.velocity.set(bllt.SPEED, -bllt.SPEED);
				case "downL":
					bllt.velocity.set(-bllt.SPEED, bllt.SPEED);
				case "downR":
					bllt.velocity.set(bllt.SPEED, bllt.SPEED);
				case "up":
					bllt.velocity.set(0, -bllt.SPEED);
				case "down":
					bllt.velocity.set(0, bllt.SPEED);
				case "left":
					bllt.velocity.set(-bllt.SPEED, 0);
				case "right":
					bllt.velocity.set(bllt.SPEED, 0);
			}
			velocity.y += tempRecoilY;
			velocity.y += tempRecoilX;
			coolingDown = true;
			coolingDownTimer.reset();
		}
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
	public function hurt()
	{
		if (flickering)
			return;
		health -= 1;
		if (health <= 0)
			this.kill();
		FlxSpriteUtil.flicker(this, 1, 0.04, true, true, (flkr:FlxFlicker) ->
		{
			flickering = false;
		});
		flickering = true;
	}
}
