package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;

class PlayState extends FlxState
{
	private static inline var BAT_SPEED:Int = 350;
	
	private var cubuk:FlxSprite;
	private var top:FlxSprite;
	
	private var duvarlar:FlxGroup;
	private var solDuvar:FlxSprite;
	private var sagDuvar:FlxSprite;
	private var altDuvar:FlxSprite;
	private var ustDuvar:FlxSprite;
	
	private var tuglalar:FlxGroup;
	
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		
		cubuk = new FlxSprite(180, 220);
		cubuk.makeGraphic(40, 6, FlxColor.MAGENTA);
		cubuk.immovable = true;
		
		top = new FlxSprite(180, 160);
		top.makeGraphic(6, 6, FlxColor.MAGENTA);
		
		top.elasticity = 1;
		top.maxVelocity.set(200, 200);
		top.velocity.y = 200;
		
		duvarlar = new FlxGroup();
		
		solDuvar = new FlxSprite(0, 0);
		solDuvar.makeGraphic(10, 240, FlxColor.GRAY);
		solDuvar.immovable = true;
		duvarlar.add(solDuvar);
		
		sagDuvar = new FlxSprite(310, 0);
		sagDuvar.makeGraphic(10, 240, FlxColor.GRAY);
		sagDuvar.immovable = true;
		duvarlar.add(sagDuvar);
		
		ustDuvar = new FlxSprite(0, 0);
		ustDuvar.makeGraphic(320, 10, FlxColor.GRAY);
		ustDuvar.immovable = true;
		duvarlar.add(ustDuvar);
		
		altDuvar = new FlxSprite(0, 239);
		altDuvar.makeGraphic(320, 10, FlxColor.TRANSPARENT);
		altDuvar.immovable = true;
		duvarlar.add(altDuvar);
		
		
		tuglalar = new FlxGroup();
		
		var bx:Int = 10;
		var by:Int = 30;
		
		var tuglaRengi:Array<Int> = [0xffd03ad1, 0xfff75352, 0xfffd8014, 0xffff9024, 0xff05b320, 0xff6d65f6];
		
		for (y in 0...6)
		{
			for (x in 0...20)
			{
				var geciciTugla:FlxSprite = new FlxSprite(bx, by);
				geciciTugla.makeGraphic(15, 15, tuglaRengi[y]);
				geciciTugla.immovable = true;
				tuglalar.add(geciciTugla);
				bx += 15;
			}
			
			bx = 10;
			by += 15;
		}
		
		add(duvarlar);
		add(cubuk);
		add(top);
		add(tuglalar);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		cubuk.velocity.x = 0;
		
		#if !FLX_NO_TOUCH
		for (touch in FlxG.touches.list)
		{
			if (touch.pressed)
			{
				if (touch.x > 10 && touch.x < 270)
				cubuk.x = touch.x;
			}
		}
		for (swipe in FlxG.swipes)
		{
			if (swipe.distance > 100)
			{
				if ((swipe.angle < 10 && swipe.angle > -10) || (swipe.angle > 170 || swipe.angle < -170))
				{
					FlxG.resetState();
				}
			}
		}
		#end
		
		if (FlxG.keys.anyPressed([LEFT, A]) && cubuk.x > 10)
		{
			cubuk.velocity.x = - BAT_SPEED;
		}
		else if (FlxG.keys.anyPressed([RIGHT, D]) && cubuk.x < 270)
		{
			cubuk.velocity.x = BAT_SPEED;
		}
		
		if (FlxG.keys.justReleased.R)
		{
			FlxG.resetState();
		}
		
		if (cubuk.x < 10)
		{
			cubuk.x = 10;
		}
		
		if (cubuk.x > 270)
		{
			cubuk.x = 270;
		}
		
		FlxG.collide(top, duvarlar);
		FlxG.collide(cubuk, top, ping);
		FlxG.collide(top, tuglalar, hit);
	}
	
	private function hit(Ball:FlxObject, Brick:FlxObject):Void
	{
		Brick.exists = false;
	}
	
	private function ping(Bat:FlxObject, Ball:FlxObject):Void
	{
		var batmid:Int = Std.int(Bat.x) + 20;
		var ballmid:Int = Std.int(Ball.x) + 3;
		var diff:Int;
		
		if (ballmid < batmid)
		{
			diff = batmid - ballmid;
			Ball.velocity.x = ( -10 * diff);
		}
		else if (ballmid > batmid)
		{
			
			diff = ballmid - batmid;
			Ball.velocity.x = (10 * diff);
		}
		else
		{
			//şıçrama olayı 
			Ball.velocity.x = 2 + FlxG.random.int(0, 8);
		}
	}
}