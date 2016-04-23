package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;


class Oyuncu extends FlxSprite
{
	var leftKey:String;
	var rightKey:String;

	public function new(X,Y,leftKey:String,rightKey:String)
	{
		super(X, Y);
		makeGraphic(10,100);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);



	}
}