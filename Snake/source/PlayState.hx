package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxSpriteGroup;
class PlayState extends FlxState

{
	private static 	 var MIN_INTERVAL:Float = 2;
	private static inline var BLOCK_SIZE:Int = 20;
	
	private var puanMetin:FlxText;
	private var yem:FlxSprite;
	private var yilanBas:FlxSprite;
	private var yilanGovde:FlxSpriteGroup;
	
	private var basKonum:Array<FlxPoint>;
	private var hareketA:Float = 8;
	private var puan:Int = 0;
	
	private var gecerliYon = FlxObject.LEFT;
	private var yeniYon:Int = FlxObject.LEFT;
	
	override public function create():Void  
	{
		FlxG.mouse.visible = false;//mouse imlecini gizledik
		
		
		var screenMiddleX:Int = Math.floor(FlxG.width / 2);
		var screenMiddleY:Int = Math.floor(FlxG.height / 2);
		
		//Yılanın baş kısımını
		yilanBas = new FlxSprite(screenMiddleX - BLOCK_SIZE * 2, screenMiddleY);
		yilanBas.makeGraphic(BLOCK_SIZE - 2, BLOCK_SIZE - 2, FlxColor.LIME);
		offestSprite(yilanBas);
		
		//Yılanın baş kordinatları 
		basKonum = [FlxPoint.get(yilanBas.x, yilanBas.y)];
		
		//Gövde
		yilanGovde = new FlxSpriteGroup();
		add(yilanGovde);
		
		// başlangıçtaki gövde 
		for (i in 0...3)
		{
			addSegment();
			//Yılan hareketi
			moveSnake();
		}
		
		// yılanın gövdesi  ve başı eklendi
		add(yilanBas);
		
		// yemler 
		yem = new FlxSprite();
		yem.makeGraphic(BLOCK_SIZE - 2, BLOCK_SIZE - 2, FlxColor.RED);
		randomizeFruitPosition();
		offestSprite(yem);
		add(yem);
		
		// Puan metini
		puanMetin = new FlxText(0, 0, 200, "Score: " + puan);
		puanMetin.setFormat(null,23,FlxColor.RED,"center");
		add(puanMetin);
		
		// zamanı sınırladık
		resetTimer();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		

		
		if (FlxG.keys.anyJustReleased([SPACE, R]))
		{
			FlxG.resetState();
		}


		FlxG.overlap(yilanBas, yem, collectFruit);
		
		
		FlxG.overlap(yilanBas, yilanGovde, gameOver);
		
		// yılan kontrolleri
		if (FlxG.keys.anyPressed([UP, W]) && gecerliYon != FlxObject.DOWN)
		{
			yeniYon = FlxObject.UP;
		}
		else if (FlxG.keys.anyPressed([DOWN, S]) && gecerliYon != FlxObject.UP)
		{
			yeniYon = FlxObject.DOWN;
		}
		else if (FlxG.keys.anyPressed([LEFT, A]) && gecerliYon != FlxObject.RIGHT)
		{
			yeniYon = FlxObject.LEFT;
		}
		else if (FlxG.keys.anyPressed([RIGHT, D]) && gecerliYon != FlxObject.LEFT)
		{
			yeniYon = FlxObject.RIGHT;
		}
	}
	
	
	private function offestSprite(Sprite:FlxSprite):Void
	{
		Sprite.offset.set(1, 1);
		Sprite.centerOffsets();
	}
	
	private function updateText(NewText:String):Void
	{
		puanMetin.text = NewText;
		
	}
	
	private function collectFruit(Object1:FlxObject, Object2:FlxObject):Void
	{
		// Puan güncelleme
		puan += 10;
		updateText("Score: " + puan);
		
		randomizeFruitPosition();
		
		// yemleri gövdeye ekleme
		addSegment();
		FlxG.sound.load(FlxAssets.getSound("flixel/sounds/beep")).play();
		
		
		if (hareketA >= MIN_INTERVAL)
		{
			hareketA -= 0.25;
		}
	}
	
	private function randomizeFruitPosition(?Object1:FlxObject, ?Object2:FlxObject):Void
	{
		// rasgele yemler
		yem.x = FlxG.random.int(0, Math.floor(FlxG.width / 8) - 1) * 8;
		yem.y = FlxG.random.int(0, Math.floor(FlxG.height / 8) - 1) * 8;
		FlxG.overlap(yem, yilanGovde, randomizeFruitPosition);
	}
	
	private function gameOver(Object1:FlxObject, Object2:FlxObject):Void
	{
		yilanBas.alive = false;
		updateText("Game Over - Space to restart!");
		FlxG.sound.play("assets/flixel.wav");
	}
	
	private function addSegment():Void
	{
		
		var segment:FlxSprite = new FlxSprite(-20, -20);
		segment.makeGraphic(BLOCK_SIZE - 2, BLOCK_SIZE - 2, FlxColor.BLUE); 
		yilanGovde.add(segment);
	}
	
	private function resetTimer(?Timer:FlxTimer):Void
	{
		
		if (!yilanBas.alive && Timer != null)
		{
			Timer.destroy();
			return;
		}
		
		new FlxTimer().start(hareketA / FlxG.updateFramerate, resetTimer);
		moveSnake();
	}
	
	private function moveSnake():Void
	{	
		basKonum.unshift(FlxPoint.get(yilanBas.x, yilanBas.y));
		
		if (basKonum.length > yilanGovde.members.length)
		{
			basKonum.pop();
		}
		
		
		switch (yeniYon)
		{
			case FlxObject.LEFT:
			yilanBas.x -= BLOCK_SIZE;
			case FlxObject.RIGHT:
			yilanBas.x += BLOCK_SIZE;
			case FlxObject.UP:
			yilanBas.y -= BLOCK_SIZE;
			case FlxObject.DOWN:
			yilanBas.y += BLOCK_SIZE;
		}
		gecerliYon = yeniYon;
		
		FlxSpriteUtil.screenWrap(yilanBas);
		
		for (i in 0...basKonum.length)
		{
			yilanGovde.members[i].setPosition(basKonum[i].x, basKonum[i].y);
		}
	}
}
