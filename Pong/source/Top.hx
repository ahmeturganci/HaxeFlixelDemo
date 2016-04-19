package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

class Top extends FlxSprite{
public var timer:FlxTimer;
	public function  new (X,Y)
	{
		super(X,Y);
		 
		velocity.x=150;
		elasticity=1;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (y<0) {
			velocity.y*=-1;
		}
			if (y+height<FlxG.height) {
			velocity.y*=-1;

		}
	}
	public  function sifirlaTop() {
		x=FlxG.width/2;
		y=FlxG.height/2;
		velocity.set();
			new FlxTimer().start(1, myCallback);
		
	}
	private function myCallback(Timer:FlxTimer):Void
{
	velocity.x=160;
}
}
