### Use Kate Engine at your own risk!
```diff
! Due to the nature of how to use Kate Engine, it is recommended to take safety precautions to avoid a permanent account deletion of your Roblox account.
! Myself, Lyte Interactive's Affliates, and whoever redirected you here have no control over what happens next if you get caught.

! Please be safe and don't cheat.
```

----

<p align="center">
  <img src="https://github.com/Sezei/ff-kate-engine/blob/main/kateengine_2.png?raw=true" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/latest%20version-0.9-7300a8?style=for-the-badge" />
</p>

<p align="center">
Funky Friday's modding framework; which by itself is a mod lol; Absolutely nothing that gives you advantages over your opponents, all absolutely client-sided.
</p>

# Features (so far)
The 'mods' so far are the following;
- Solo Gamemodes - Challange yourself with either No-Miss or Sicks Only modes!

![image](https://user-images.githubusercontent.com/49373598/168472431-169c610e-dc78-4da9-8b87-2a508ac64156.png)
- Mania-styled Combo Counter (Works best w/Middle Scroll)

![image](https://user-images.githubusercontent.com/49373598/168380945-e086d9be-7d29-45dd-84f8-66db7b254d29.png)
- (cheaply made) Song Progress Bar

![image](https://user-images.githubusercontent.com/49373598/196227193-0fb07b42-8d33-470b-85d3-871a2dccedc8.png)
- Solo Healthbar

![image](https://user-images.githubusercontent.com/49373598/169907335-2f8e8313-231c-4419-8a52-ad20eceb9e5b.png)

- Count total notes.

- See how many notes you didn't hold long enough. (Marked as ghost notes)

- Dynamic bot difficulty (yes this means you can make the bot suck worse than you lmao)

- Automatic Difficulty Rating Calculation (Shown as [⭐DIFFICULTY] in KE's topbar)

![image](https://user-images.githubusercontent.com/49373598/196227335-4e63f505-3174-42de-951c-36eddbf3ee44.png)

- Better miss-sound handling than the original.. somehow lol

- M o d c h a r t s, such as [Hyperlink](https://www.youtube.com/watch?v=1AxvBATQDAQ), [Means of Destruction](https://www.youtube.com/watch?v=CSoFgLZSp_8) or even [Mother](https://www.youtube.com/watch?v=mGKn6BV_Zkc)

# How to load (correctly)
I will not elaborate how to get the script into the game and stuff, but it's here;
```lua
local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/main/loader.lua",true))()
```

or for the beta users;
```lua
local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/beta/loader.lua",true))()
```

# Reporting bugs
If you encounter a bug, please either report it in Issues (https://github.com/Sezei/ff-kate-engine/issues) or if you feel courageous enough to fix it yourself, you can open a pull request by forking the script and sending it in the appropriate place. (https://github.com/Sezei/ff-kate-engine/pulls)

While there isn't a specific template you should follow, it's required that you add the following details, otherwise I won't be able to help;
- What the error is (Screenshot the F9 menu, as well as the Internal Console if one exists)
- What config are you using (the settings); You can send the .mp5 file that is generated when you save the config.
- The way you executed the script. (You know what I mean.)

Soon you will be able to share your own modcharts with pull requests in https://github.com/Sezei/ffke-modcharts/pulls
In order to get the asset, you can use the following;
```lua
setclipboard(engine:GetKEValue("SongID"));
```
