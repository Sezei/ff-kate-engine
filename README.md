# Warning: Do not post anything regarding Kate Engine in the FF community server!
```diff
! WARNING: If you indeed use this, MAKE SURE YOU DON'T POST SCREENSHOTS OF IT IN THE COMMUNITY SERVER ! 
! It WILL get you banned, and the appeal will be declined. (or stuck on pending) !
```

# Funky Friday | Kate Engine
Funky Friday's modding framework; which by itself is a mod lol; Absolutely nothing that gives you advantages over your opponents, all absolutely client-sided.
decided on the name 'kate engine' both because of Kade and because my name's katherine (or kate for short lol)

i mean, it technically does mod ff to add new features just like kade did for fnf so dont point fingers at me

# Requirements
- Synapse X lol

# Features (so far)
The 'mods' so far are the following;
- Solo Gamemodes - Challange yourself with either No-Miss or Sicks Only modes!

![image](https://user-images.githubusercontent.com/49373598/168472431-169c610e-dc78-4da9-8b87-2a508ac64156.png)
- Mania-styled Combo Counter (Works best w/Middle Scroll)

![image](https://user-images.githubusercontent.com/49373598/168380945-e086d9be-7d29-45dd-84f8-66db7b254d29.png)
- (cheaply made) Song Progress Bar

![image](https://user-images.githubusercontent.com/49373598/168381001-f61f281e-ca80-4aa8-9c62-0ff8b456bce8.png)
- Solo Healthbar

![image](https://user-images.githubusercontent.com/49373598/169907335-2f8e8313-231c-4419-8a52-ad20eceb9e5b.png)

- Count total notes.

- See how many ghost notes you missed.

- Dynamic bot difficulty (yes this means you can make the bot suck worse than you already are lmao)

- Multi-Stage toggle now visible only if you're up against someone

# How to load (correctly)
Simply put the following into the script executor. It will do the rest ***and*** will auto-update whenever an update comes.
```lua
local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/main/loader.lua",true))()
```

# Reporting bugs
If you encounter a bug, please either report it in Issues (https://github.com/Sezei/ff-kate-engine/issues) or if you feel courageous enough to fix it yourself, you can open a pull request by forking the script and sending it in the appropriate place. (https://github.com/Sezei/ff-kate-engine/pulls)

While there isn't a specific template you should follow, it's required that you add the following details, otherwise I won't be able to help;
- The exploit you're using
- What the error is (Screenshot the F9 menu, as well as the Internal Console if exists)
- What config are you using (the settings); You can send the .mp5 file that is generated when you save the config.
