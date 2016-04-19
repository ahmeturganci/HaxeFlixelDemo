package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	var _btnBasla:FlxButton;
	
	override public function create():Void
	{	super.create();
		_btnBasla= new FlxButton(0,0,"PLAY",oyunaBasla);
		add(_btnBasla);
	
		_btnBasla.screenCenter();
		
	
	}
	public function oyunaBasla():Void{
		 FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
