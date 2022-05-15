# Funky Friday | Kate Engine
Funky Friday's modding framework; which by itself is a mod lol; Absolutely nothing that gives you advantages over your opponents, all absolutely client-sided.
decided on the name 'kate engine' both because of Kade and because my name's katherine (or kate for short lol)

i mean, it technically does mod ff to add new features just like kade did for fnf so dont point fingers at me

# Requirements
- A script executor
- Make sure the script executor can use loadstring otherwise its a bad executor lmfao

# Features (so far)
The 'mods' so far are the following;
- Solo Gamemodes - Challange yourself with either No-Miss or Sicks Only modes!

![image](https://user-images.githubusercontent.com/49373598/168472431-169c610e-dc78-4da9-8b87-2a508ac64156.png)
- Mania-styled Combo Counter (Works best w/Middle Scroll)

![image](https://user-images.githubusercontent.com/49373598/168380945-e086d9be-7d29-45dd-84f8-66db7b254d29.png)
- (cheaply made) Song Progress Bar

![image](https://user-images.githubusercontent.com/49373598/168381001-f61f281e-ca80-4aa8-9c62-0ff8b456bce8.png)
- Multi-Stage toggle now visible only if you're up against someone

# How to load (correctly)
Simply put the following into the script executor. It will do the rest ***and*** will auto-update whenever an update comes.
```lua
local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/main/loader.lua",true))()
```
