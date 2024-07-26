package;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import sys.FileSystem;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.app.Application;
import flixel.util.FlxSave;
import lime.system.System;

#if desktop
import Discord.DiscordClient;
#end

//crash handler stuff
#if CRASH_HANDLER
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
#end

using StringTools;

class Main extends Sprite
{
	var game = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		initialState: Intro, // initial game state
		zoom: -1.0, // game state bounds
		framerate: 60, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};
	public static var fpsVar:FPS;

	// You can pretty much ignore everything from here on - your code should go in your states.
	
   static final losvideos:Array<String> = [
		"bothCreditsAndIntro",
		"explosion",
		"glasses",
		"guns",
		"HaxeFlixelIntro",
      "sonicexe-intro",
		"hitmarkers",
		"illuminati",
		"IlluminatiConfirmed",
		"introCREDITS",
		"mlg",
		"noscope",
		"sonic1",
		"sound-test-codes",
      "the-gaze-of-a-god_NoAudio",
      "soulless-intro",
		"tooslowcutscene1",
		"tooslowcutscene2",
		"weed",
		"youcantruncutscene2",
      "ycr-encore-intro",
      "ugly-intro",
      "tt-final",
      "sonic-exe-intro-fe",
      "i-am-god-NoAudio",
      "fof-intro",
      "critical-error-intro"
	]; //better way to do this?
	
	static final videosdead:Array<String> = [
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7"
	]; //someone kill me

   static final seriousdead:Array<String> = [
      "1",
      "2",
      "3",
      "4",
      "Secret"
   ];

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
           FlxG.save.bind("MyGameSave");
           if (FlxG.save.data.exeInfoShown == null) {
               FlxG.save.data.exeInfoShown = false;
               FlxG.save.flush();
	   } 
		
		super();

    SUtil.gameCrashCheck();
		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1.0)
		{
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}
	
		SUtil.doTheCheck();
	
		ClientPrefs.loadDefaultKeys();
		
		addChild(new FlxGame(game.width, game.height, game.initialState, game.zoom, game.framerate, game.framerate, game.skipSplash, game.startFullscreen));

		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.showFPS;
		}

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end
		
		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		#if desktop
		if (!DiscordClient.isInitialized) {
			DiscordClient.initialize();
			Application.current.window.onClose.add(function() {
				DiscordClient.shutdown();
			});
		}
		#end
	}

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	// very cool person for real they don't get enough credit for their work
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

                dateNow = dateNow.replace(" ", "_").replace(":", "'");
		
		path = "./crash/" + "Merphi_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error + "\nPlease report this error to the GitHub page: https://github.com/ShadowMario/FNF-PsychEngine\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
    #if desktop
		DiscordClient.shutdown();
	 #end
		Sys.exit(1);
	}
	#end

   public function getFPS():Float{
		return fpsVar.currentFPS;	
	}
}
