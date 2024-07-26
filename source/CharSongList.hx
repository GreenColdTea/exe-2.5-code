package;

class CharSongList
{
    public static var data:Map<String,Array<String>> = [
      "majin" => ["endless", "endless-og", "endless-us", "endless-jp", "endeavors"],
      "lord x" => ["execution","cycles", "hellbent", "fate", "judgement", "gatekeepers"],
      "tails doll" => ["sunshine", "soulless"],
      "fleetway" => ["chaos"],
      "fatal error" => ["fatality", "critical-error"],
      "chaotix" => ["my-horizon", "our-horizon"],
      "curse" => ["malediction", "extricate-hex", "unblessful-hedgehog"],
      "starved" => ["prey", "fight-or-flight"],
      "xterion" => ["digitalized", "substantial"],
      "needlemouse" => ["relax", "round-a-bout", "spike-trap"],
      "luther" => ["her-world"],
      "hog" => ["hedge", "manual-blast"],
      "sunky" => ["milk"],
      "sanic" => ["too-fest"],
      "coldsteel" => ["personel"],
      "apollyon" => ["genesis", "corinthians"],
      "xmas" => ["missiletoe", "slaybells", "jingle-hells"],
      "melthog" => ["melting", "confronting"],
      "skinwalker" => ["envy"],
      "lumpy sonic" => ["frenzy"],
      "griatos and demogri" => ["insidious", "haze"],
      "devoid" => ["hollow", "empty"],
      "education" => ["expulsion"],
      "faker" => ["faker", "black-sun", "godspeed"],
      "dsk" => ["miasma"],
      "sl4sh" => ["b4cksl4sh"],
      "futagami" => ["animosity", "reunion"],
      "batman" => ["call-of-justice", "gotta-go"],
      "bratwurst" => ["life-and-death", "gods-will"],
      "no name" => ["forever-unnamed"],
      "nmi" => ["fake-baby"],
      "normal cd" => ["found-you"],
      "omw" => ["universal-collapse", "planestrider"],
      "satanos" => ["perdition", "underworld"],
      "requital" => ["forestall-desire"],
      "sh tails" => ["mania"],
      "shp and genesys" => ["burning"],
      "sonichu" => ["shocker", "extreme-zap"],
      "sonic.lmn" => ["soured"],
      "ugly sonic" => ["ugly"],
      "G8M3 0V3R" => ["too-far", "too-far-alt"]
    ];

    public static var characters:Array<String> = [ // just for ordering
      "majin",
      "lord x",
      "tails doll",
      "fleetway",
      "fatal error",
      "chaotix",
      "curse",
      "starved",
      "xterion",
      "needlemouse",
      "hog",
      "sunky",
      "sanic",
      "coldsteel",
      "apollyon",
      "xmas",
      "melthog",
      "skinwalker",
      "lumpy sonic",
      "griatos and demogri",
      "devoid",
      "education",
      "faker",
      "dsk",
      "sl4sh",
      "futagami",
      "batman",
      "bratwurst",
      "no name",
      "nmi",
      "normal cd",
      "omw",
      "satanos",
      "requital",
      "sh tails",
      "shp and genesys",
      "sonichu",
      "sonic.lmn",
      "ugly sonic",
      "G8M3 0V3R"
    ];

    // TODO: maybe a character display names map? for the top left in FreeplayState

    public static var songToChar:Map<String,String>=[];

    public static function init(){ // can PROBABLY use a macro for this? but i have no clue how they work so lmao
      // trust me I tried
      // if shubs or smth wants to give it a shot then go ahead
      // - neb
      songToChar.clear();
      for(character in data.keys()){
        var songs = data.get(character);
        for(song in songs)songToChar.set(song,character);
      }
    }

    public static function getSongsByChar(char:String)
    {
      if(data.exists(char))return data.get(char);
      return [];
    }

    public static function isLastSong(song:String)
    {
        /*for (i in songs)
        {
            if (i[i.length - 1] == song) return true;
        }
        return false;*/
      if(!songToChar.exists(song))return true;
      var songList = getSongsByChar(songToChar.get(song));
      return songList[songList.length-1]==song;
    }
}
