package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	var cubuk:FlxSprite;
	var top:FlxSprite;
	var duvarlar:FlxGroup;
	var sagDuvar:FlxSprite;
	var solDuvar:FlxSprite;
	var altDuvar:FlxSprite;
	var ustDuvar:FlxSprite;
	var tugla:FlxGroup;

	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible=false;
		
		cubuk = new FlxSprite(180, 220);
		cubuk.makeGraphic(40, 6, FlxColor.CYAN);
		cubuk.immovable = true;

		top= new FlxSprite(180,160);
		top.makeGraphic(6,6,FlxColor.RED);
		top.elasticity = 1;
		top.maxVelocity.set(200, 200);
		top.velocity.y = 200;

		duvarlar= new FlxGroup();

		solDuvar= new FlxSprite(0,0);
		solDuvar.makeGraphic(10,240,FlxColor.WHITE);
		solDuvar.immovable=true;
		duvarlar.add(solDuvar);
		
		sagDuvar= new FlxSprite(310,0);
		sagDuvar.makeGraphic(10,240,FlxColor.WHITE);
		sagDuvar.immovable=true;
		duvarlar.add(sagDuvar);

		ustDuvar = new FlxSprite(0, 239);
		ustDuvar.makeGraphic(320,10,FlxColor.WHITE);
		ustDuvar.immovable=true;
		duvarlar.add(ustDuvar);

		altDuvar = new FlxSprite(0,0);
		altDuvar.makeGraphic(10,240,FlxColor.TRANSPARENT);
		altDuvar.immovable=true;
		duvarlar.add(altDuvar);

		

		tugla = new FlxGroup();
		var tx:Int=10;
		var ty:Int=30;
		var tuglaRenk:Array<Int>=[FlxColor.RED,FlxColor.BLUE,FlxColor.GRAY,FlxColor.GREEN,FlxColor.YELLOW,FlxColor.MAGENTA];

		for (i in 0 ... 6) 
		{
			for (j in 0 ... 20) 
			{
				var geciciTugla:FlxSprite = new FlxSprite(tx, ty);
				geciciTugla.makeGraphic(15, 15, tuglaRenk[j]);
				geciciTugla.immovable = true;
				tugla.add(geciciTugla);
				tx += 15;
			}
			tx=10;
			ty+=15;
		}


		add(cubuk);
		add(top);
		add(duvarlar);
		add(tugla);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		cubuk.velocity.x=-0;
		if (FlxG.keys.anyPressed([LEFT]) && cubuk.x >0)
		{
			cubuk.velocity.x=-300;
		}
		else if(FlxG.keys.anyPressed([RIGHT]) && cubuk.x<270)
		{
			cubuk.velocity.x=300;
		}
		FlxG.collide(cubuk,top);
	}
}
