package;

import flixel.graphics.FlxGraphic;
import sys.FileSystem;
#if windows
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.util.FlxSave;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxSound;
import lime.app.Application;
import openfl.Assets;

using StringTools;

class EXEInfoState extends MusicBeatState
{
   var sonicWarn:FlxSprite;
   var discl:FlxSprite;
   private var Confirm:FlxSound;

   override function create()
   {
        discl = new FlxSprite().loadGraphic(Paths.image('warnings/disclaimer/main'));
	discl.screenCenter();
	discl.setGraphicSize(1280, 720);
        discl.alpha = 0;
	add(discl);
 
        Confirm = FlxG.sound.play(Paths.sound('confirmMenu'));

	sonicWarn = new FlxSprite(-100, -600);
	sonicWarn.frames = Paths.getSparrowAtlas('warnings/disclaimer/sonic');
	sonicWarn.animation.addByPrefix('idle', "idle", 22);
	sonicWarn.animation.play('idle');
	sonicWarn.alpha = 0;
	sonicWarn.scale.x = 2;
	sonicWarn.scale.y = 2;
	sonicWarn.antialiasing = true;
	sonicWarn.updateHitbox();
        add(sonicWarn);

        #if windows
	    DiscordClient.changePresence("In the Disclaimer Menu", null);
        #end

       FlxTween.tween(sonicWarn, {alpha: 1}, 2.25);
       FlxTween.tween(discl, {alpha: 1}, 2.25);

       #if android
          addVirtualPad(NONE, A);
       #end

		super.create();
	}

   private function timerComplete(timer:FlxTimer):Void {
       MusicBeatState.switchState(new MainMenuState());
   }
	
	override function update(elapsed:Float)
	{
	    super.update(elapsed);

            if(controls.ACCEPT)
                FlxTween.tween(sonicWarn, {alpha: 0}, 2.5);
                FlxTween.tween(discl, {alpha: 0}, 2.5);
                Confirm.play();
                new FlxTimer().start(2.5, timerComplete);
	}
}
