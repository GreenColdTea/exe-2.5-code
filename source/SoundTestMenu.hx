package;

import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxCamera;
import openfl.filters.ShaderFilter;
import flixel.addons.display.FlxBackdrop;

#if desktop
import Discord.DiscordClient;
#end

#if (hxCodec >= "3.0.0")
import hxcodec.flixel.FlxVideo as MP4Handler;
#elseif (hxCodec == "2.6.1")
import hxcodec.VideoHandler as MP4Handler;
#elseif (hxCodec == "2.6.0")
import VideoHandler as MP4Handler;
#else
import vlc.MP4Handler;
#end

class SoundTestMenu extends MusicBeatState
{
	var woahmanstopspammin:Bool = true;

	var whiteshit:FlxSprite;

	var daValue:Int = 0;
	var pcmValue:Int = 0;
	var coldsteelCode:Int = 0;

	var soundCooldown:Bool = true;

	var funnymonke:Bool = true;
	
	var bg:FlxBackdrop;

	var incameo:Bool = false;

	var cameoBg:FlxSprite;
	var cameoImg:FlxSprite;
	var cameoThanks:FlxSprite;

	var pcmNO = new FlxText(FlxG.width / 6, FlxG.height / 2, 0, 'PCM  NO .', 23);
	var daNO = new FlxText(FlxG.width * .6, FlxG.height / 2, 0, 'DA  NO .', 23);

	var pcmNO_NUMBER = new FlxText(FlxG.width / 6, FlxG.height / 2, 0, '0', 23);
	var daNO_NUMBER = new FlxText(FlxG.width / 6, FlxG.height / 2, 0, '0', 23);

	var cam:FlxCamera;
	

    override function create()
    {
			cam = new FlxCamera();
			FlxG.cameras.reset(cam);
			cam.bgColor.alpha = 0;
			FlxCamera.defaultCameras = [cam];

      #if desktop
			DiscordClient.changePresence('In the Sound Test Menu', null);
      #end

			new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{
					FlxG.sound.playMusic(Paths.music('breakfast'));
				});
		
			whiteshit = new FlxSprite().makeGraphic(1280, 720, FlxColor.WHITE);
			whiteshit.alpha = 0;

			cameoBg = new FlxSprite();
			cameoImg = new FlxSprite();
			cameoThanks = new FlxSprite();

			FlxG.sound.music.stop();

			bg = new FlxBackdrop(Paths.image('backgroundST'), 0, 1, false, true);
			bg.x = -100;
			bg.scrollFactor.x = 0;
			bg.scrollFactor.y = 0;
			bg.setGraphicSize(Std.int(bg.width * 1));
			bg.updateHitbox();
			bg.screenCenter();
			bg.antialiasing = true;
			add(bg);

			var soundtesttext = new FlxText(0, 0, 0, 'SOUND TEST', 25);
			soundtesttext.screenCenter();
			soundtesttext.y -= 180;
			soundtesttext.x -= 33;
			soundtesttext.setFormat("Sonic CD Menu Font Regular", 25, FlxColor.fromRGB(0, 163, 255));
			soundtesttext.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
			add(soundtesttext);
			
			pcmNO.setFormat("Sonic CD Menu Font Regular", 23, FlxColor.fromRGB(174, 179, 251));
			pcmNO.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);

			daNO.setFormat("Sonic CD Menu Font Regular", 23, FlxColor.fromRGB(174, 179, 251));
			daNO.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);

			pcmNO.y -= 70;
			pcmNO.x += 100;

			daNO.y -= 70;
			
			add(pcmNO);

			add(daNO);

			pcmNO_NUMBER.y -= 70;
			pcmNO_NUMBER.x += 270;
			pcmNO_NUMBER.setFormat("Sonic CD Menu Font Regular", 23, FlxColor.fromRGB(174, 179, 251));
			pcmNO_NUMBER.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);
			add(pcmNO_NUMBER);

			daNO_NUMBER.y -= 70;
			daNO_NUMBER.x += daNO.x - 70;
			daNO_NUMBER.setFormat("Sonic CD Menu Font Regular", 23, FlxColor.fromRGB(174, 179, 251));
			daNO_NUMBER.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);
			add(daNO_NUMBER);

			cameoBg.visible = false;
			add(cameoBg);

			cameoThanks.visible = false;
			add(cameoThanks);

			cameoImg.visible = false;
			add(cameoImg);

			add(whiteshit);

                #if mobile addVirtualPad(LEFT_FULL, A_B); #end
        }

	function changeNumber(selection:Int) 
	{
		if (funnymonke)
		{
			pcmValue += selection;
			if (pcmValue < 0) pcmValue = 99;
			if (pcmValue > 99) pcmValue = 0;
		}
		else
		{
			daValue += selection;
			if (daValue < 0) daValue = 99;
			if (daValue > 99) daValue = 0;
		}
	}

	function flashyWashy(a:Bool)
	{
		if (a == true)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
		}
		else
			FlxTween.color(whiteshit, 0.1, FlxColor.WHITE, FlxColor.BLUE);
			FlxTween.tween(whiteshit, {alpha: 0}, 0.2);

	}

	function doTheThing(first:Int, second:Int) 
	{
		if (first == 12 && second == 25)
		{
			woahmanstopspammin = false;
         PlayState.storyPlaylist = ['endless', 'endeavors'];
			PlayState.SONG = Song.loadFromJson('endless-hard', 'endless');
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = 2;
			PlayState.storyWeek = 1;
			           
			           
			flashyWashy(true);
         new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			if (!FlxG.save.data.songArray.contains('endless') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('endless');
		}
		else if (first == 16 && second == 10)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

            PlayState.storyPlaylist = ['relax', 'round-a-bout', 'spike-trap'];
				PlayState.SONG = Song.loadFromJson('relax-hard', 'relax');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('relax') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('relax');
			}
      else if (first == 7 && second == 7)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

            PlayState.storyPlaylist = ['execution', 'cycles', 'hellbent', 'fate-remix', 'judgement'];
				PlayState.SONG = Song.loadFromJson('execution-hard', 'execution');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
				if (!FlxG.save.data.songArray.contains('execution') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('execution');
			}
      else if (first == 3 && second == 11)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;
            PlayState.isFreeplay = false;

				PlayState.SONG = Song.loadFromJson('oxxynless', 'oxxynless');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
      else if (first == 3 && second == 0)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;
            PlayState.isFreeplay = false;

				PlayState.SONG = Song.loadFromJson('too-far-hard', 'too-far');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
      else if (first == 4 && second == 11)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;
            PlayState.isFreeplay = false;

				PlayState.SONG = Song.loadFromJson('life-and-death-hard', 'life-and-death');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
      else if (first == 6 && second == 4)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;
            PlayState.isFreeplay = false;

				PlayState.SONG = Song.loadFromJson('forestall-desire-hard', 'forestall-desire');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
       else if (first == 9 && second == 11)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;
            PlayState.isFreeplay = false;

				PlayState.SONG = Song.loadFromJson('fake-baby-hard', 'fake-baby');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
		else if (first == 66 && second == 6)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

            PlayState.storyPlaylist = ['sunshine', 'soulless'];
				PlayState.SONG = Song.loadFromJson('sunshine-hard', 'sunshine');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('sunshine') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('sunshine');
			}
      else if (first == 16 && second == 24)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('miasma-hard', 'miasma');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
				if (!FlxG.save.data.songArray.contains('miasma') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('miasma');
			}
       else if (first == 9 && second == 19)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('malediction-hard', 'malediction');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
				if (!FlxG.save.data.songArray.contains('miasma') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('miasma');
			}
      else if (first == 5 && second == 12)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

            PlayState.storyPlaylist = ['hollow', 'empty'];
				PlayState.SONG = Song.loadFromJson('hollow-hard', 'hollow');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
				if (!FlxG.save.data.songArray.contains('hollow') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('hollow');
			}
      else if (first == 18 && second == 38)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('forever-unnamed-hard', 'forever-unnamed');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
				if (!FlxG.save.data.songArray.contains('miasma') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('miasma');
			}
      else if (first == 18 && second == 21)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

            PlayState.storyPlaylist = ['melting', 'confronting'];
				PlayState.SONG = Song.loadFromJson('melting-hard', 'melting');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
				if (!FlxG.save.data.songArray.contains('melting') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('melting');
			}
      else if (first == 25 && second == 12)
         {
            woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

            PlayState.storyPlaylist = ['missiletoe', 'slaybells', 'jingle-hells'];
				PlayState.SONG = Song.loadFromJson('missiletoe-hard', 'missiletoe');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('missiletoe') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('missiletoe');
			}
      else if (first == 0 && second == 0)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;
				PlayState.isFreeplay = false;
				PlayState.SONG = Song.loadFromJson('too-fest-hard', 'too-fest');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('too-fest') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('too-fest');
			}
      else if (first == 20 && second == 5)
         {
            woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('b4cksl4sh-hard', 'b4cksl4sh');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('b4cksl4sh') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('b4cksl4sh');
			}
      else if (first == 99 && second == 99)
         {
            woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('genesis-hard', 'genesis');
            PlayState.storyPlaylist = ['genesis', 'corinthians'];
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('genesis') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('genesis');
			}
       else if (first == 42 && second == 75)
         {
            woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('insidious-hard', 'insidious');
            PlayState.storyPlaylist = ['insidious', 'haze'];
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('insidious') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('insidious');
			}
		else if (first == 8 && second == 21)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('chaos-hard', 'chaos');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('chaos') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('chaos');
			}
     else if (first == 90 && second == 19)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('universal-collapse-hard', 'universal-collapse');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
     else if (first == 19 && second == 1)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('found-you-hard', 'found-you');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
     else if (first == 66 && second == 99)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('perdition-hard', 'perdition');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
     else if (first == 50 && second == 50)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

            PlayState.storyPlaylist = ['hedge', 'manual-blast'];
				PlayState.SONG = Song.loadFromJson('hedge-hard', 'hedge');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('hedge') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('hedge');
			}
     else if (first == 39 && second == 19)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

        PlayState.storyPlaylist = ['call-of-justice', 'gotta-go'];
				PlayState.SONG = Song.loadFromJson('call-of-justice-hard', 'call-of-justice');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('call-of-justice') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('call-of-justice');
			}
     else if (first == 96 && second == 96)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('old-ycr-slaps-hard', 'old-ycr-slaps');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
			}
      else if (first == 69 && second == 69)
         {
            woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('milk-hard', 'milk');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
		   }
      else if (first == 0 && second == 50)
      {
            woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

            PlayState.storyPlaylist = ['fatality', 'critical-error'];
				PlayState.SONG = Song.loadFromJson('fatality-hard', 'fatality');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('fatality') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('fatality');
      }
      else if (first == 31 && second == 13)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;
				PlayState.isFreeplay = false;
				PlayState.storyPlaylist = ['faker', 'black-sun', 'godspeed'];
				PlayState.SONG = Song.loadFromJson('faker-hard', 'faker');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				flashyWashy(true);

            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('faker') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('faker');
         }
      else if (first == 5 && second == 23)
				{
					PlayStateChangeables.nocheese = false;
					PlayState.SONG = Song.loadFromJson('personel-hard', 'personel');
					PlayState.isStoryMode = false;
					PlayState.storyDifficulty = 2;
					PlayState.storyWeek = 1;
					
					
					flashyWashy(true);
					new FlxTimer().start(2, function(tmr:FlxTimer)
					{
						LoadingState.loadAndSwitchState(new PlayState());
					});
				}
      else if (first == 12 && second == 34) 
			{
				var video:MP4Handler = new MP4Handler();
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
                             	  video.playVideo(Paths.video('EXE Milk'));
				  incameo = true;
				});
			}
      else if (first == 19 && second == 83) 
			{
				var video:MP4Handler = new MP4Handler();
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
                	video.playVideo(Paths.video('SpiderSonic'));
					    incameo = true;
				});
			}
      else if (first == 30 && second == 17)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('burning-hard', 'burning');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
      else if (first == 88 && second == 19)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

            PlayState.storyPlaylist = ['shocker', 'extreme-zap'];
				PlayState.SONG = Song.loadFromJson('shocker-hard', 'shocker');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('shocker') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('shocker');
			}
      else if (first == 20 && second == 8)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('her-world-hard', 'her-world');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
      else if (first == 23 && second == 2)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

            PlayState.storyPlaylist = ['prey', 'fight-or-flight'];
				PlayState.SONG = Song.loadFromJson('prey-hard', 'prey');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
				if (!FlxG.save.data.songArray.contains('prey') && !FlxG.save.data.botplay) FlxG.save.data.songArray.push('prey');
			}
      else if (first == 80 && second == 80)
			{
				woahmanstopspammin = false;
				PlayStateChangeables.nocheese = false;

				PlayState.SONG = Song.loadFromJson('color-blind-hard', 'color-blind');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 2;
				PlayState.storyWeek = 1;
				           
				           
				flashyWashy(true);
            new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
      else if (first == 11 && second == 11) 
			{
				var video:MP4Handler = new MP4Handler();
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
                	video.playVideo(Paths.video('Yuppi CD'));
					    incameo = true;
				});
			}
      else if (first == 20 && second == 20) 
			{
				var video:MP4Handler = new MP4Handler();
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
                	video.playVideo(Paths.video('ArtFlex'));
					    incameo = true;
				});
			}
		else if (first == 41 && second == 1) 
		{
			woahmanstopspammin = false;
			flashyWashy(true);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				cameoImg.visible = true;
				cameoImg.loadGraphic(Paths.image('cameostuff/Razencro'));
				cameoImg.setSize(1280, 720);
				flashyWashy(false);
				FlxG.sound.music.stop();

			});
			new FlxTimer().start(2.1, function(tmr:FlxTimer)
			{
				FlxG.sound.playMusic(Paths.music('cameostuff/Razencro'));	
				incameo = true;
			});
		}
		else if (first == 1 && second == 13) // This for you div, R.I.P
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					cameoImg.visible = true;
					cameoImg.loadGraphic(Paths.image('cameostuff/divide'));
					cameoImg.setSize(1280, 720);
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					incameo = true;
				});
			}
		else if (first == 9 && second == 10) // This for you div, R.I.P
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					cameoImg.visible = true;
					cameoImg.loadGraphic(Paths.image('cameostuff/Sunkeh'));
					cameoImg.setSize(1280, 720);
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					incameo = true;
				});
			}
		else if (first == 6 && second == 6) // This for you div, R.I.P
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					cameoImg.visible = true;
					cameoImg.loadGraphic(Paths.image('cameostuff/GamerX'));
					cameoImg.setSize(1280, 720);
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					incameo = true;
				});
			}
		else if (first == 32 && second == 8) 
		{
			woahmanstopspammin = false;
			flashyWashy(true);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				cameoImg.visible = true;
				cameoImg.loadGraphic(Paths.image('cameostuff/Marstarbro'));
				cameoImg.setSize(1280, 720);
				flashyWashy(false);
				FlxG.sound.music.stop();

			});
			new FlxTimer().start(2.1, function(tmr:FlxTimer)
			{
				FlxG.sound.playMusic(Paths.music('cameostuff/Marstarbro'));	
				incameo = true;
			});
		}
		else if (first == 6 && second == 12) 
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					cameoImg.visible = true;
					cameoImg.loadGraphic(Paths.image('cameostuff/a small error'));
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					incameo = true;
				});
			}
		else
		{
			if (soundCooldown)
			{
				soundCooldown = false;
				FlxG.sound.play(Paths.sound('deniedMOMENT'));
				new FlxTimer().start(0.8, function(tmr:FlxTimer)
				{
					soundCooldown = true;
				});
			}
        }
	}
		
	override public function update(elapsed:Float)
		{
      bg.y += 1;
			if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A || FlxG.keys.justPressed.D) if (woahmanstopspammin) funnymonke = !funnymonke;

			if (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S)  changeNumber(1);

			if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W) changeNumber(-1);

			if (FlxG.keys.justPressed.ENTER && woahmanstopspammin) doTheThing(pcmValue, daValue);

			if (FlxG.keys.justPressed.ENTER && !woahmanstopspammin && incameo) LoadingState.loadAndSwitchState(new SoundTestMenu());

			if (FlxG.keys.justPressed.ESCAPE && woahmanstopspammin && !incameo) LoadingState.loadAndSwitchState(new MainMenuState());

			if (funnymonke)
			{
				pcmNO.setFormat("Sonic CD Menu Font Regular", 23, FlxColor.fromRGB(254, 174, 0));
				pcmNO.setBorderStyle(SHADOW, FlxColor.fromRGB(253, 36, 3), 4, 1);
		
				daNO.setFormat("Sonic CD Menu Font Regular", 23, FlxColor.fromRGB(174, 179, 251));
				daNO.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);
			}
			else
			{
				pcmNO.setFormat("Sonic CD Menu Font Regular", 23, FlxColor.fromRGB(174, 179, 251));
				pcmNO.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);
	
				daNO.setFormat("Sonic CD Menu Font Regular", 23, FlxColor.fromRGB(254, 174, 0));
				daNO.setBorderStyle(SHADOW, FlxColor.fromRGB(253, 36, 3), 4, 1);
			}
			
			if (pcmValue < 10)	pcmNO_NUMBER.text = '0' + Std.string(pcmValue);
			else pcmNO_NUMBER.text = Std.string(pcmValue);

			if (daValue < 10)	daNO_NUMBER.text = '0' + Std.string(daValue);
			else daNO_NUMBER.text = Std.string(daValue);

			if (FlxG.keys.justPressed.P)
				if (coldsteelCode == 0)
					coldsteelCode = 1;
				else
					coldsteelCode == 0;
			if (FlxG.keys.justPressed.E)
				if (coldsteelCode == 1)
					coldsteelCode = 2;
				else
					coldsteelCode == 0;
			if (FlxG.keys.justPressed.R)
				if (coldsteelCode == 2)
					coldsteelCode = 3;
				else
					coldsteelCode == 0;
			if (FlxG.keys.justPressed.S)
				if (coldsteelCode == 3)
					coldsteelCode = 4;
				else
					coldsteelCode == 0;
			if (FlxG.keys.justPressed.O)
				if (coldsteelCode == 4)
					coldsteelCode = 5;
				else
					coldsteelCode == 0;
			if (FlxG.keys.justPressed.N)
				if (coldsteelCode == 5)
					coldsteelCode = 6;
				else
					coldsteelCode == 0;
			if (FlxG.keys.justPressed.N)
				if (coldsteelCode == 6)
					coldsteelCode = 7;
				else
					coldsteelCode == 0;
			if (FlxG.keys.justPressed.E)
				if (coldsteelCode == 7)
					coldsteelCode = 8;
				else
					coldsteelCode == 0;
			if (FlxG.keys.justPressed.L)
				if (coldsteelCode == 8)
					coldsteelCode = 9;
				else
					coldsteelCode == 0;
				//lol i copied this from titlestate lmfao
	
			super.update(elapsed);
		}
}
	
