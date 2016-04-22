package;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxAxes;

class MenuState extends FlxState
{
	var _btnBasla:FlxButton;
	var _btnCikis:FlxButton;
	var  _yapimci:FlxText;
	var _oyunAdi:FlxText;

	override public function create():Void
	{	
		super.create();

		_btnBasla= new FlxButton(0,0,"PLAY",oyunaBasla);
		_btnBasla.x = FlxG.width / 2 - _btnBasla.width - 35;
		_btnBasla.y = FlxG.height / 2 - _btnBasla.height / 2;
		add(_btnBasla);

		_btnCikis= new FlxButton(0,0,"EXIT",oyunCikis);
		_btnCikis.x = FlxG.width / 2 + _btnCikis.width / 2 - 10;
		_btnCikis.y = FlxG.height / 2 - _btnCikis.height / 2;
		add(_btnCikis);

		_yapimci=new FlxText(0, 440, 0, "AU-GAME", 14);
		_yapimci.alignment = FlxTextAlign.CENTER;
		_yapimci.screenCenter(FlxAxes.X);
		add(_yapimci);

		_oyunAdi = new FlxText(0, 40, 0, "PONG", 52);
		_oyunAdi.alignment = FlxTextAlign.CENTER;
		_oyunAdi.screenCenter(FlxAxes.X);
		add(_oyunAdi);

	}

	public  function oyunCikis():Void {
		System.exit(0);
	}
	public function oyunaBasla():Void{
		FlxG.switchState(new PlayState());
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
