package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;


 class Cubuk extends FlxSprite
 {
 	var upKey:String;
 	var downKey:String;

     public function new(X,Y,_upKey:String,_downKey:String)
	     {
         super(X, Y);
         makeGraphic(10,100);

         upKey=_upKey;
         downKey=_downKey;
         
         immovable=true;
     }
     override public function update(elapsed:Float):Void
     {
     	super.update(elapsed);
     	if (FlxG.keys.anyPressed([upKey])) {
     	y-=2;
     	
     	}
     	else if (FlxG.keys.anyPressed([downKey])) {
     	y+=2;


     }

 }}