package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import Cubuk;

class PlayState extends FlxState
{ 
	var top:Top;
	var cubuklar:FlxGroup = new FlxGroup();
	var sagPuan=0;
	var solPuan = 0;
	var puan:FlxText;
	var arkaPlan:FlxSprite;
	var kazanan:FlxText;
	var maksimumPuan=3;

	override public function create():Void
	{
		super.create();

		arkaPlan=new FlxSprite();
		arkaPlan.makeGraphic(FlxG.width,FlxG.height,FlxColor.WHITE);
		arkaPlan.color=FlxColor.BLACK;
		add(arkaPlan);
		
		puan=new FlxText(0,0,FlxG.width,"0|0");
		puan.setFormat(null,23,FlxColor.BLUE,"center");
		add(puan);
			
		kazanan=new FlxText(0,FlxG.height/2,FlxG.width,"KAZANDIN");
		kazanan.setFormat(null,23,FlxColor.YELLOW,"center");
		kazanan.visible=false;
		add(kazanan);


		cubuklar.add(new Cubuk(30,200,"W","S"));
		cubuklar.add(new Cubuk(FlxG.width - 30,200,"UP","DOWN"));
		add(cubuklar);
		add(top=new Top(FlxG.width/2,FlxG.height/2));
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(top,cubuklar,function(top:FlxSprite,cubuklar:FlxSprite){
			top.velocity.y=(top.getGraphicMidpoint().y - cubuklar.getGraphicMidpoint().y)*2;
			FlxG.camera.shake(0.01,0.1);			
			FlxG.sound.play("assets/sounds/pop.wav");
		});

		
		if (top.x<0) {
			sagPuan++;
			top.sifirlaTop();
			puan.text=solPuan+"|"+sagPuan;
			
			if (sagPuan==maksimumPuan) {
				puan.visible=false;
				kazanan.visible=true;
				kazanan.text="SAĞ TARAF KAZANDI";
				new FlxTimer().start(5,myCallback);
			}
		}

		if (top.x+top.width>FlxG.width){
			solPuan++;
			top.sifirlaTop();
			puan.text=solPuan+"|"+sagPuan;
			if (solPuan==maksimumPuan) {
				puan.visible=false;
				kazanan.visible=true;
				kazanan.text="SOL TARAF KAZANDI";				
				new FlxTimer().start(5, myCallback);
			}
		}
		if (top.y<0) {
			top.y=0;
			geriKuvvet();
		}
		


	}
	private function myCallback(Timer:FlxTimer):Void
	{
		FlxG.resetGame();
	}
	private function geriKuvvet():Void{
		top.velocity.y=150;
	}
}

