Rewrite's out, so the mod's dead. Sorry.
I ain't risking my PC nor my accounts to get a funny exploit script more hate than a mayonaise and peas pizza.

Archiving just in-case.

----

<p align="center">
  <img src="https://github.com/Sezei/ff-kate-engine/blob/rewrite/funkify_1_xl.png?raw=true" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/latest%20version-0.13-7300a8?style=for-the-badge" />
</p>

<p align="center">
Funky Friday's modding framework; which by itself is a mod lol; Absolutely nothing that gives you advantages over your opponents, all absolutely client-sided.
</p>

# Features (so far)
The 'mods' so far are the following;
- Mania-styled Combo Counter (Works best w/Middle Scroll)

![image](https://user-images.githubusercontent.com/49373598/168380945-e086d9be-7d29-45dd-84f8-66db7b254d29.png)
- ~~(cheaply made)~~ Song Progress Bar (Screenshot from Pre-0.12A)

![image](https://user-images.githubusercontent.com/49373598/196227193-0fb07b42-8d33-470b-85d3-871a2dccedc8.png)
- Solo Healthbar (Screenshot from Pre-0.12)

![image](https://user-images.githubusercontent.com/49373598/169907335-2f8e8313-231c-4419-8a52-ad20eceb9e5b.png)
- Count total notes.

- Fixed BPMs for certain songs, now with BPM changes mid-song! (Select songs only)

- Perfect Rating (gl getting 'em :trollface:)

- See how many notes you didn't hold long enough. (Marked as that (+n) in the bads counter)

- Dynamic bot difficulty (yes this means you can make the bot suck worse than you lmao)

- Better miss-sound handling than the original.. somehow lol

- Full modcharting support, allowing for stuff such as [Hyperlink](https://www.youtube.com/watch?v=1AxvBATQDAQ), [Means of Destruction](https://www.youtube.com/watch?v=CSoFgLZSp_8) or even [Mother (lol)](https://www.youtube.com/watch?v=mGKn6BV_Zkc) ((Footage from beta 0.9)); All the way to even [In My Way](https://youtube.com/watch?v=OLHNoE3abtI&si=EnSIkaIECMiOmarE&t=68) ((Footage from beta 0.11; Select songs only))

# How to load (correctly)
I will not elaborate how to get the script into the game and stuff, but it's here;
```lua
_G.Framework = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/rewrite/loader.lua",true))()
```

or for the beta users; (Unmaintained temporarily)
```lua
_G.Framework = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/unstable/loader.lua",true))()
```

# Reporting bugs
If you encounter a bug, please either report it in Issues (https://github.com/Sezei/ff-kate-engine/issues) or if you feel courageous enough to fix it yourself, you can open a pull request by forking the script and sending it in the appropriate place. (https://github.com/Sezei/ff-kate-engine/pulls)

While there isn't a specific template you should follow, it's required that you add the following details, otherwise I won't be able to help;
- What the error is (Screenshot the F9 menu, as well as the Internal Console if one exists)
- What config are you using (the settings); You can send the .mp5 file that is generated when you save the config.
- The way you executed the script. (You know what I mean.)

You are able to create your own modcharts by adding them onto the modcharts.lua file.
In order to get the SongID, you can open the menu by pressing <kbd>Home</kbd> and click on the "Copy Song ID" button.
If you do not have such a button, it means your executor does not support it!

In that case, you'll need to use the following method;
```lua
local SongID = _G.Framework:GetKEValue("SongID")
```
