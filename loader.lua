--trolling--
--local engine, ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/main/loader.lua",true))();

-- why did i even need to include this 💀
if game.PlaceId ~= 6447798030 and game.PlaceId ~= 6996694685 then
	return error("No!")
end

-- function to deep-print a table key-value pairs
function printTable(t, indent)
    if indent == nil then indent = 0 end
    for k, v in pairs(t) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            printTable(v, indent+1)
        elseif type(v) == 'boolean' then
            print(formatting .. tostring(v))
        else
            print(formatting .. v)
        end
    end
end

-- Services and Variables
local httpservice = game:GetService("HttpService");
local tweenservice = game:GetService("TweenService");
local gameUi = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GameUI");
local UIS = game:GetService("UserInputService");
local origintime = 0;
local version = "b0.9";
local prevcombo = 0;
local counter = 0;
local songdifficulty = 0;
local event = game.ReplicatedStorage.RE;
local inSolo = false;
local inNoMiss = false;
local SicksOnly = false;
local autoplayActive = false;
local localhealth = 40;
local shared = {};
local material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/main/UIFramework.lua",true))().Load({Style = 1;Title = "Kate Engine "..version;Theme = "Dark";SizeX = 500;})
material.Self.Enabled = false;

local framework;

function getGameFramework()
	for _, v in next, getgc(true) do
		if type(v) == 'table' and rawget(v, 'GameUI') then
			return v
		end
	end
end

framework = getGameFramework();

framework.KEValues = {};

function framework:SetKEValue(key, value)
	self.KEValues[key] = value;
end
function framework:GetKEValue(key)
	return self.KEValues[key];
end

-- UI setup
local funny = Instance.new("TextLabel")
funny.AnchorPoint = Vector2.new(0.5, 0.5)
funny.Position = UDim2.fromScale(0.5, 0.5)
funny.Parent = gameUi
funny.BackgroundTransparency = 1
funny.TextColor3 = Color3.new(1, 1, 1)
funny.TextStrokeColor3 = Color3.new(0, 0, 0)
funny.TextStrokeTransparency = 0.5
funny.TextSize = 50
funny.Text = 0
funny.Font = Enum.Font.Arcade
funny.Visible = false
funny.Name = "KE_funny"
local tween = funny:Clone()
tween.Visible = true
tween.Parent = funny
tween.TextStrokeTransparency = 1
tween.TextTransparency = 1
tween.Name = "KE_tween"
local secondary = funny:Clone();
secondary.Visible = true
secondary.Parent = funny
secondary.Text = ""
secondary.Position = UDim2.new(0.5,0,0,40)
secondary.TextSize = 30
secondary.Name = "KE_secondary"
--[[
local watermark = Instance.new("TextLabel");
watermark.Parent = gameUi;
watermark.BackgroundTransparency = 1;
watermark.Font = Enum.Font.PermanentMarker;
watermark.Text = "Kate Engine | "..version.."\nCreated by Sezei\n\nOptions: [  ;  ]"
watermark.TextSize = 26
watermark.TextXAlignment = Enum.TextXAlignment.Left;
watermark.TextYAlignment = Enum.TextYAlignment.Top;
watermark.TextColor3 = Color3.new(1,1,1);
watermark.TextStrokeTransparency = 0.5;
watermark.Position = UDim2.new(0,10,0,0);
watermark.Name = "KE_watermark"
--]]
local watermark = Instance.new("ImageLabel")
watermark.Name = "KE_watermark"
watermark.Image = "rbxassetid://11306098055"
watermark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
watermark.BackgroundTransparency = 1
watermark.Size = UDim2.fromOffset(143, 94)

local wversion = Instance.new("TextLabel")
wversion.Name = "KE_version"
wversion.Font = Enum.Font.PermanentMarker
wversion.Text = version
wversion.TextColor3 = Color3.fromRGB(255, 255, 255)
wversion.TextSize = 28
wversion.TextXAlignment = Enum.TextXAlignment.Left
wversion.TextYAlignment = Enum.TextYAlignment.Bottom
wversion.AnchorPoint = Vector2.new(0.5, 1)
wversion.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
wversion.BackgroundTransparency = 1
wversion.Position = UDim2.new(0.5, 0, 1, 10)
wversion.Size = UDim2.new(0.95, 0, 0, 50)

local debugstuff = Instance.new("TextLabel")
debugstuff.Name = "KE_debuglabel"
debugstuff.Font = Enum.Font.PermanentMarker
debugstuff.Text = "DEBUG STUFF!"
debugstuff.TextColor3 = Color3.fromRGB(255, 255, 255)
debugstuff.TextSize = 18
debugstuff.TextXAlignment = Enum.TextXAlignment.Left
debugstuff.TextYAlignment = Enum.TextYAlignment.Top
debugstuff.AnchorPoint = Vector2.new(0.5, 1)
debugstuff.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
debugstuff.BackgroundTransparency = 1
debugstuff.Position = UDim2.new(0.5, 0, 1, 48)
debugstuff.Size = UDim2.new(0.95, 0, 0, 20)

local uIStroke = Instance.new("UIStroke")
uIStroke.Name = "UIStroke"
uIStroke.Thickness = 2
uIStroke.Parent = wversion

uIStroke:Clone().Parent = debugstuff

wversion.Parent = watermark
debugstuff.Parent = watermark

local woptions = Instance.new("TextLabel")
woptions.Name = "Options"
woptions.Font = Enum.Font.PermanentMarker
woptions.Text = "Options: ;"
woptions.TextColor3 = Color3.fromRGB(255, 255, 255)
woptions.TextSize = 20
woptions.TextXAlignment = Enum.TextXAlignment.Right
woptions.TextYAlignment = Enum.TextYAlignment.Bottom
woptions.AnchorPoint = Vector2.new(0.5, 1)
woptions.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
woptions.BackgroundTransparency = 1
woptions.Position = UDim2.new(0.5, 0, 1, 8)
woptions.Size = UDim2.new(0.95, 0, 0, 50)

local uIStroke1 = Instance.new("UIStroke")
uIStroke1.Name = "UIStroke"
uIStroke1.Thickness = 2
uIStroke1.Parent = woptions

woptions.Parent = watermark
watermark.Parent = gameUi;
--
local topb = gameUi.TopbarLabel:Clone();
topb.Parent = gameUi;
topb.Visible = true;
topb.Name = "KE_topbar"
local hpback = Instance.new("Frame");
hpback.Visible = true;
hpback.Parent = gameUi.Arrows;
hpback.AnchorPoint = Vector2.new(0.5,1);
hpback.Position = UDim2.new(0.5,0,1,-50);
hpback.Size = UDim2.new(0.4,0,0,20);
hpback.BackgroundColor3 = Color3.fromRGB(27,27,27);
hpback.BorderSizePixel = 0;
hpback.Name = "KE_Healthbar";
local hplower = hpback:Clone();
hplower.Visible = true;
hplower.Parent = hpback;
hplower.AnchorPoint = Vector2.new(0.5,0.5);
hplower.Size = UDim2.new(0.99,0,0,16);
hplower.Position = UDim2.new(0.5,0,0.5,0);
hplower.BackgroundColor3 = Color3.new(1,0,0);
hplower.Name = "Back";
local hpupper = hplower:Clone();
hpupper.Visible = true;
hpupper.Parent = hplower;
hpupper.AnchorPoint = Vector2.new(1,0.5);
hpupper.Size = UDim2.new(0.4,0,1,0);
hpupper.Position = UDim2.new(1,0,0.5,0);
hpupper.BackgroundColor3 = Color3.new(0,1,0);
hpupper.Name = "Front";

material.Banner({Text = "+ Added better miss sound handling\n\n> Dynamic Font Increments is no longer an experimental\n\n> A rewrite may be coming soon!"});

local globaldata = { -- Data that will be used across the entire script.
	totalnotes = 0;
	combo = 0;
};

local uidata = { -- Saving Purposes. Also easier to access ig.
	DataVersion = version;
	ManiaCounter = true;
	WorldCombo = true;
	SongProgress = true;
	SoloGamemodes = true;
	Health = true;
	CameraBump = true;
	Mania_FCIndicator = true;
	Mania_SimpleRatings = false;
	Mania_DynamicIncrements = true;
	Mania_Milestone = 50;
	Mania_0Combo = Color3.new(1,1,1);
	Mania_100Combo = Color3.new(1,1,0.75);
	Mania_200Combo = Color3.new(1,1,0.5);
	Mania_300Combo = Color3.new(1,1,0.25);
	Mania_400Combo = Color3.new(1,1,0);
    Bot_AILevel = "Insane";
	Modes_NoMiss = true;
	Modes_SicksOnly = true;
	Health_MissingColor = Color3.new(1,0,0);
	Health_RemainingColor = Color3.new(0,1,0);
	Health_HitGain = 3;
	Health_MissLoss = 15;
    BetterMiss_Enabled = true;
    BetterMiss_Volume = 0.5;
	BPMFix_Enabled = true;
}

local maintab = material.New({Title = "Main"}) do
	if type(readfile) == 'function' and type(writefile) == 'function' and type(isfile) == 'function' then
		maintab.Label({
			Text = "-- SAVE & LOAD --";
		})
		ConfigLoad = maintab.Button({
			Text = "Load KE Settings"; 
			Callback = function()
				if not isfile('KE_Config.mp5') then
					material.Banner({Text = "Attempt to load UI config has failed: Unable to read the file.\n\nInfo:\nFile 'KE_Config.mp5' does not exist!"});
					return
				end
				local success, data = pcall(function()
					return readfile('KE_Config.mp5')
				end)
				if not success then
					material.Banner({Text = "Attempt to load UI config has failed: Unable to read the file.\n\nInfo:\n"..data});
					return
				end
				local success, decoded = pcall(httpservice.JSONDecode, httpservice, readfile('KE_Config.mp5'))
				if not success then
					material.Banner({Text = "Attempt to load UI config has failed: Unable to decode UI data.\n\nInfo:\n"..decoded});
					return
				end
				if decoded.DataVersion ~= version then
					material.Banner({Text = "UI config has loaded correctly, but is outdated - Watch out for any corrupted data!"});
				end
				for k,v in pairs(decoded) do
					if k ~= "DataVersion" then
						uidata[k] = v;
					end;
					local env = getfenv()
					if type(v) == "boolean" then
						env[k]:SetState(v);
					elseif type(v) == "userdata" then
						env[k]:SetColor(v);
						-- Number doesn't even have a SetState?
					end
				end
				return material.Banner({Text = "UI config has loaded from file successfully!"});
			end
		});
		ConfigSave = maintab.Button({
			Text = "Save KE Settings"; 
			Callback = function() 
				local success, encoded = pcall(httpservice.JSONEncode, httpservice, uidata)
				if not success then
					material.Banner({Text = "Attempt to save UI config has failed: Unable to encode UI data.\n\nInfo:\n"..encoded});
					return
				end
				local success, f = pcall(function()
					writefile('KE_Config.mp5', encoded)
				end)
				if not success then
					material.Banner({Text = "Attempt to save UI config has failed: Unable to write to file.\n\nInfo:\n"..encoded});
					return
				end
			end;
		});
	end
	maintab.Label({
		Text = "-- MOD TOGGLES --";
	})
	ManiaCounter = maintab.Toggle({
		Text = "Mania Combo Counter";
		Callback = function(bool)
			uidata.ManiaCounter = bool
		end;
		Enabled = true;
	});
	WorldCombo = maintab.Toggle({
		Text = "3D Combo Counter";
		Callback = function(bool)
			uidata.WorldCombo = bool
		end;
		Enabled = true;
	});
	SongProgress = maintab.Toggle({
		Text = "Song Progress Bar";
		Callback = function(bool)
			uidata.SongProgress = bool
		end;
		Enabled = true;
	});
	SoloGamemodes = maintab.Toggle({
		Text = "Solo Gamemodes";
		Callback = function(bool)
			uidata.SoloGamemodes = bool
		end;
		Enabled = true;
	});
	Health = maintab.Toggle({
		Text = "Solo Healthbar";
		Callback = function(bool)
			uidata.Health = bool;
			if inSolo then
				hpback.Visible = bool;
			else
				hpback.Visible = false;
			end
			localhealth = 40; -- reset
		end;
		Enabled = true;
	});
end;

local displaymodstab = material.New({Title = "Display Mods"}) do
	displaymodstab.Label({
		Text = "-- MANIA --";
	});
	displaymodstab.Label({
		Text = "Mania is a combo counter that displays the current combo in a mania-like fashion.";
	});
	Mania_FCIndicator = displaymodstab.Toggle({
		Text = "FC Indicator";
		Callback = function(bool)
			uidata.Mania_FCIndicator = bool
		end;
		Enabled = true;
	});
	Mania_SimpleRatings = displaymodstab.Toggle({
		Text = "Simple Ratings";
		Callback = function(bool)
			uidata.Mania_SimpleRatings = bool
		end;
		Enabled = false;
	});
	Mania_DynamicIncrements = displaymodstab.Toggle({
		Text = "Dynamic Font Increments";
		Callback = function(bool)
			uidata.Mania_DynamicIncrements = bool
		end;
		Enabled = true;
	});
	Mania_Milestone = displaymodstab.Dropdown({
		Text = "Combo Milestones";
		Callback = function(option)
			uidata.Mania_Milestone = tonumber(option)
		end;
		Options = {"20","25","50","100"};
	});
	Mania_0Combo = displaymodstab.ColorPicker({
		Text = "Mania 0 Combo";
		Callback = function(color)
			uidata.Mania_0Combo = color
		end;
		Default = Color3.new(1,1,1);
	});
	Mania_100Combo = displaymodstab.ColorPicker({
		Text = "Mania 100 Combo";
		Callback = function(color)
			uidata.Mania_100Combo = color
		end;
		Default = Color3.new(1,1,0.75);
	});
	Mania_200Combo = displaymodstab.ColorPicker({
		Text = "Mania 200 Combo";
		Callback = function(color)
			uidata.Mania_200Combo = color
		end;
		Default = Color3.new(1,1,0.5);
	});
	Mania_300Combo = displaymodstab.ColorPicker({
		Text = "Mania 300 Combo";
		Callback = function(color)
			uidata.Mania_300Combo = color
		end;
		Default = Color3.new(1,1,0.25);
	});
	Mania_400Combo = displaymodstab.ColorPicker({
		Text = "Mania 400 Combo";
		Callback = function(color)
			uidata.Mania_400Combo = color
		end;
		Default = Color3.new(1,1,0);
	});
	
end;

local modstab = material.New({Title = "Gameplay Mods"}) do
	modstab.Label({
		Text = "<b>Everything in this tab is affecting <i>solo-play</i> rounds only!</b>";
	});
	modstab.Label({
		Text = "-- GAMEMODES --";
	});
	modstab.Label({
		Text = "These are the gamemodes that can be toggled on and off.";
	});
	Modes_NoMiss = modstab.Toggle({
		Text = "No-Miss Mode Button";
		Callback = function(bool)
			uidata.Modes_NoMiss = bool
		end;
		Enabled = true;
	});
	Modes_SicksOnly = modstab.Toggle({
		Text = "Sicks-Only Mode Button";
		Callback = function(bool)
			uidata.Modes_SicksOnly = bool
		end;
		Enabled = true;
	});
	modstab.Label({
		Text = "-- HEALTHBAR --";
	});
	modstab.Label({
		Text = "The healthbar indicates how much health you have. Hit notes to gain health, miss notes to lose health.";
	});
	Health_MissingColor = modstab.ColorPicker({
		Text = "Missing Health Color";
		Callback = function(color)
			uidata.Health_MissingColor = color
			hplower.BackgroundColor3 = color
		end;
		Default = Color3.new(1,0,0);
	});
	Health_RemainingColor = modstab.ColorPicker({
		Text = "Remaining Health Color";
		Callback = function(color)
			uidata.Health_RemainingColor = color
			hpupper.BackgroundColor3 = color
		end;
		Default = Color3.new(0,1,0);
	});
	Health_HitGain = modstab.Slider({
		Text = "Note Hit Gain";
		Callback = function(num)
			uidata.Health_HitGain = num
		end;
		Min = 1;
		Max = 50;
		Def = 3;
	});
	Health_MissLoss = modstab.Slider({
		Text = "Note Miss Loss";
		Callback = function(color)
			uidata.Health_MissLoss = color
		end;
		Min = 1;
		Max = 50;
		Def = 15;
	});
	modstab.Label({
		Text = "-- BOT OPPONENT --";
	});
	modstab.Label({
		Text = "This setting affect how the bot opponent plays. (Difficulty)";
	});
	modstab.Dropdown({
        Text = "Bot Opponent";
        Callback = function(option)
            uidata.Bot_AILevel = option
        end;
        Options = {"Noob_At_3AM","Easy","Normal","Hard","Insane","Impossible"};
    });
end;

--[[
local healthtab = material.New({Title = "Health"}) do
	healthtab.Label({
		Text = "-- HEALTHBAR SETTINGS --";
	});
	Health_MissingColor = healthtab.ColorPicker({
		Text = "Missing Health Color";
		Callback = function(color)
			uidata.Health_MissingColor = color
			hplower.BackgroundColor3 = color
		end;
		Default = Color3.new(1,0,0);
	});
	Health_RemainingColor = healthtab.ColorPicker({
		Text = "Remaining Health Color";
		Callback = function(color)
			uidata.Health_RemainingColor = color
			hpupper.BackgroundColor3 = color
		end;
		Default = Color3.new(0,1,0);
	});
	Health_HitGain = healthtab.Slider({
		Text = "Note Hit Gain";
		Callback = function(num)
			uidata.Health_HitGain = num
		end;
		Min = 1;
		Max = 50;
		Def = 3;
	});
	Health_MissLoss = healthtab.Slider({
		Text = "Note Miss Loss";
		Callback = function(color)
			uidata.Health_MissLoss = color
		end;
		Min = 1;
		Max = 50;
		Def = 15;
	});
end;

local botplaytab = material.New({Title = "Bot"}) do
    botplaytab.Label({
        Text = "-- BOT OPPONENT SETTINGS --";
    });
    botplaytab.Dropdown({
        Text = "Bot Opponent";
        Callback = function(option)
            uidata.Bot_AILevel = option
        end;
        Options = {"Noob_At_3AM","Easy","Normal","Hard","Insane","Impossible"};
    });
end
]]

local gamefixestab = material.New({Title = "Gameplay Fixes"}) do
    gamefixestab.Label({
        Text = "-- BETTER MISS SETTINGS --";
    });
    gamefixestab.Label({
        Text = "This will make the sounds only play when you actually miss a note.";
    });
    gamefixestab.Toggle({
        Text = "Enabled";
        Callback = function(bool)
            uidata.BetterMiss_Enabled = bool
            if framework then
                framework.Settings.MissedSound.Value = not bool;
            end
        end;
        Enabled = true;
    });
    gamefixestab.Slider({
        Text = "Volume";
        Callback = function(num)
            uidata.BetterMiss_Volume = num/100
        end;
        Min = 0;
        Max = 100;
        Def = 50;
    });
	gamefixestab.Label({
		Text = "-- BPM FIX --";
	});
	gamefixestab.Label({
		Text = "This will fix the BPM of the song to match the camera. (Scrapped code?)";
	});
	gamefixestab.Toggle({
		Text = "Enabled";
		Callback = function(bool)
			uidata.BPMFix_Enabled = bool
		end;
		Enabled = true;
	});
end

local crtab = material.New({Title = "Credits"}) do
	crtab.Label({
		Text = "-- CREDITS --";
	});
	crtab.Label({
		Text = "<font color=\"#ff00a6\">Sezei</font> - Script";
	});
	crtab.Label({
		Text = "<font color=\"#00ff00\">Wally</font> - Framework Detection";
	});
	crtab.Label({
		Text = "Kinlei(?) - UI Library";
	});
	crtab.Toggle({
		Text = "Disable Watermark";
		Callback = function(bool)
			watermark.Visible = not bool; -- we doin' some trolling :troll:
		end;
		Enabled = false;
	});
end;

local keyCodeMap = {}
for _, enum in next, Enum.KeyCode:GetEnumItems() do
	keyCodeMap[enum.Value] = enum
end

local heldkeys = {};

shared.threads = {}
shared.callbacks = {}

shared._id = httpservice:GenerateGUID(false)

local chances = {
    Noob_At_3AM = {Sick = 0.1, Good = 0.2, Ok = 0.3, Bad = 0.4},
    Easy = {Sick = 0.6, Good = 0.3, Ok = 0.09, Bad = 0.01},
    Normal = {Sick = 0.8, Good = 0.15, Ok = 0.05, Bad = 0},
    Hard = {Sick = 0.9, Good = 0.1, Ok = 0, Bad = 0},
    Insane = {Sick = 0.97, Good = 0.03, Ok = 0, Bad = 0},
    Impossible = {Sick = 1, Good = 0, Ok = 0, Bad = 0}
}
local accuracystuff = {
    Sick = 100,
    Good = 93,
    Ok = 87,
    Bad = 77,
}

game:GetService("RunService"):BindToRenderStep(shared._id, 1, function()
    task.wait(uidata.Bot_Delay)
    local chances = chances[uidata.Bot_AILevel];
        
    -- Make a random number that will be used to compare with the chances
    local arandom = math.random(1, 100) / 100;

    -- Store the current checked value
    local checked = 0;
    local hit = "Bad";

    -- If the number is less than the chance, then it's a hit
    if arandom <= chances.Sick then
        hit = "Sick";
    else
        checked += chances.Sick;
    end

    if arandom <= chances.Good + checked then
        hit = "Good";
    else
        checked += chances.Good;
    end

    if arandom <= chances.Ok + checked then
        hit = "Ok";
    end

    if hit == "Bad" then
        hit = "Bad";
    end

    -- Get the accuracy
    local newaccuracy = accuracystuff[hit];

    -- Send the event to change the accuracy
    framework.Settings.BotPlayAccuracy.Value = newaccuracy;
end)

UIS.InputBegan:Connect(function(info)
	if UIS:GetFocusedTextBox() then return end -- Ignore if textbox is focused
	if info.UserInputType == Enum.UserInputType.Keyboard then
		if info.KeyCode == Enum.KeyCode.Semicolon then
			material.Self.Enabled = not material.Self.Enabled
		end
	end
end)

local function CalcDifficultyRating(lenght)
    local diff = 0;
    repeat task.wait() until (framework.SongPlayer.CurrentSongData and #framework.SongPlayer.CurrentSongData > 0);
    local notes = #framework.SongPlayer.CurrentSongData;
    local avgnps = notes / lenght; -- Average notes per second

    diff += lenght/60;
    diff += notes/300;
    diff += avgnps*5;

    -- Make the difficulty a float number with 2 decimals
    diff = math.floor(diff * 100) / 100;

    return diff;
end

local function CalcRating(one,two)
	if not uidata.Mania_SimpleRatings then
		if one == 100 then
			return "P"
		elseif one == 99 then
			if two >= 98 then
				return "S++"
			elseif two >= 95 then
				return "S+"
			elseif two >= 90 then
				return "S"
			elseif two >= 85 then
				return "AAA"
			elseif two >= 70 then
				return "AA+"
			elseif two >= 60 then
				return "AA:"
			elseif two >= 50 then
				return "AA."
			elseif two >= 40 then
				return "AA"
			elseif two >= 30 then
				return "A+"
			elseif two >= 20 then
				return "A:"
			elseif two >= 10 then
				return "A."
			end
			return "A"
		elseif one >= 97 then
			return "A-"
		elseif one >= 95 then
			return "B+"
		elseif one >= 90 then
			return "B"
		elseif one >= 85 then
			return "C+"
		elseif one >= 80 then
			return "C"
		elseif one >= 75 then
			return "D+"
		elseif one >= 70 then
			return "D"
		else
			return "F"
		end
	else
		if one == 100 then
			return "P";
		elseif one >= 99 then
			return "S";
		elseif one >= 95 then
			return "A";
		elseif one >= 90 then
			return "B";
		elseif one >= 80 then
			return "C";
		elseif one >= 60 then
			return "D";
		else
			return "F";
		end
	end
end

local dynFont = 50;
local function DynamicFont()
	dynFont+= 5;
	return dynFont;
end
task.spawn(function()
	while task.wait(0.065) do
		dynFont = math.clamp(dynFont/1.03,50,80);
	end
end)

local prevmiss = 0;
local function updateCombo(combo,acc,miss)
	if not miss then miss = 0 end -- bandaid for some reason

	globaldata.combo = combo;
	globaldata.totalnotes = globaldata.totalnotes + 1;

	local result1 = string.split(game.Players.LocalPlayer.PlayerGui.GameUI.Arrows.Stats.Text,"\n")
	local res = {};
	for k,f in pairs(result1) do
		res[k] = tonumber(string.split(f," ")[2]);
	end

	if uidata.Mania_FCIndicator then
		if res[2] == 0 and res[3] == 0 and res[4] == 0 and miss== 0 then
			secondary.Text = (SicksOnly and "PERFECT" or "PFC")
		elseif res[2] == 1 and res[3] == 0 and res[4] == 0 and miss== 0 then -- good
			secondary.Text = "G-FLAG"
		elseif res[2] == 0 and res[3] == 1 and res[4] == 0 and miss == 0 then -- OK
			secondary.Text = "O-FLAG"
		elseif res[2] == 0 and res[3] == 0 and res[4] == 1 and miss == 0 then -- bad
			secondary.Text = "B-FLAG"
		elseif res[2] == 0 and res[3] == 0 and res[4] == 0 and miss == 1 then -- one miss but no goods, bads nor oks
			secondary.Text = "M-FLAG"
		elseif res[3] == 0 and res[4] == 0 and miss == 0 then
			secondary.Text = "GFC"
		elseif res[2] < 10 and miss == 0 then
			secondary.Text = "SDG ("..res[2]..")"
		elseif inNoMiss and miss == 0 then
			secondary.Text = "NO-MISS"
		elseif miss == 0 then
			secondary.Text = "FC"
		elseif combo > 19 then
			if miss == 1 then
				secondary.Text = "MIN1"
			elseif miss <= 9 then
				secondary.Text = "SDCB (-"..miss..")"
			else
				secondary.Text = "(-"..miss..")"
			end
		else
			secondary.Text = ""
		end
	else
		secondary.Text = ""
	end

	local accur = string.split(acc,".")
	local num = string.gsub(accur[2], "%D", "")

	if secondary.Text == "" or not uidata.Mania_FCIndicator then
		secondary.Text = CalcRating(tonumber(accur[1]),tonumber(num))
	else
		secondary.Text..= " | "..CalcRating(tonumber(accur[1]),tonumber(num))
	end

	if autoplayActive then
		secondary.Text = "AUTOPLAY"
	end

	if uidata.Health then
		if inSolo then
			hpback.Visible = uidata.Health;

			if miss > prevmiss then
				localhealth -= uidata.Health_MissLoss;
			else
				localhealth += uidata.Health_HitGain;
			end
			localhealth = math.clamp(localhealth,0,100);
			hpupper.Size = UDim2.new(localhealth/100,0,1,0);

			if localhealth == 0 then
				game.Players.LocalPlayer.Character.Humanoid.Health = -100;
			end
		else
			hpback.Visible = false;
			localhealth = 40;
		end
	end

	prevmiss = miss;

	if prevcombo >= 20 and combo < 20 then
		-- Combo Break
		tweenservice:Create(
			funny,
			TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{
				TextColor3 = Color3.new(1, 0, 0)
			}
		):Play()
		task.spawn(
			function()
				task.wait(0.3)
				tweenservice:Create(
					funny,
					TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{
						TextTransparency = 1
					}
				):Play()
				task.wait(0.3)
				funny.Visible = false
				funny.TextTransparency = 0
			end
		)
	end
	task.spawn(function()
		if combo == 0 then
			task.wait(0.2)
		end
		prevcombo = combo
	end)

	if not uidata.ManiaCounter then funny.Visible = false return end;

	if combo < 20 then
		return
	else
		funny.Visible = true
	end

	if combo >= 400 then
		funny.TextColor3 = uidata.Mania_400Combo
	elseif combo >= 300 then
		funny.TextColor3 = uidata.Mania_300Combo
	elseif combo >= 200 then
		funny.TextColor3 = uidata.Mania_200Combo
	elseif combo >= 100 then
		funny.TextColor3 = uidata.Mania_100Combo
	else
		funny.TextColor3 = uidata.Mania_0Combo
	end
	funny.Text = combo
	if uidata.Mania_DynamicIncrements then
		funny.TextSize = DynamicFont();
	else
		funny.TextSize = (combo >= 200 and 75 or combo >= 100 and 65 or 55);
	end
	tweenservice:Create(
		funny,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{
			TextSize = 50
		}
	):Play()

	if combo % tonumber(uidata.Mania_Milestone) == 0 then
		tween.TextTransparency = 0
		tween.TextSize = 70
		tween.Text = combo
		tweenservice:Create(
			tween,
			TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{
				TextSize = 100,
				TextTransparency = 1
			}
		):Play()
	end
end

local function SendPlay(var)
	inSolo = true;
	if var == "nomiss" then
		inNoMiss = true;
	elseif var == "sicksonly" then
		SicksOnly = true;
	elseif var == "autoplay" then
		--autoplayActive = true;
	end

	if var ~= "normal" then
		event:FireServer({"Server","StageManager","PlaySolo"},{});
	end
end

local lastmiss = 0;

gameUi.Arrows.InfoBar:GetPropertyChangedSignal("Text"):Connect(function()
	local t = gameUi.Arrows.InfoBar.Text
	local tt = string.split(t, " ")
	local num;
	local prevcombo = prevcombo -- i dont even remember why it's here...
	local isReset = false;

	if tt[2] == "0.00%" and tt[5] == "0" then
		isReset = true;
	end

    if uidata.BetterMiss_Enabled and not isReset then
        if tonumber(tt[5]) > lastmiss then
            -- Play the miss sound if the miss count is higher than the last miss count
            local sound = Instance.new("Sound")
            sound.SoundId = framework.Assets.Sounds:FindFirstChild("MissedNotes"):GetChildren()[math.random(#framework.Assets.Sounds:FindFirstChild("MissedNotes"):GetChildren())].SoundId
            sound.Volume = uidata.BetterMiss_Volume
            sound.Parent = gameUi
            sound:Play();
            task.spawn(function()
                task.wait(2);
                sound:Destroy();
            end) 
        end
        lastmiss = tonumber(tt[5]);
    end

	if tt[10] then
		num = string.gsub(tt[10], "%D", "")
		updateCombo(tonumber(num),tt[2],tonumber(tt[5]))
	elseif tt[8] then
		num = string.gsub(tt[8], "%D", "")
		updateCombo(tonumber(num),tt[2],tonumber(tt[5]))
	end

	if tonumber(num) >= 10 then -- if the combo is 10 or higher
		-- check if worldcombo is enabled
		if uidata.WorldCombo then
			-- check the direction of the player's head; Add +5 studs to the direction of the player's head
			local head = game.Players.LocalPlayer.Character.Head
			local direction = head.CFrame.lookVector
			local position = head.Position + (direction * 5)

			-- create a billboard gui at the position of the player's head and attach it to an invisible part
			local part = Instance.new("Part")
			part.Anchored = true
			part.CanCollide = false
			part.Size = Vector3.new(1, 1, 1)
			part.Transparency = 1
			part.CFrame = CFrame.new(position)
			part.Parent = workspace

			local billboard = Instance.new("BillboardGui")
			billboard.Adornee = part
			billboard.AlwaysOnTop = true
			billboard.Size = UDim2.new(0, 100, 0, 100)
			billboard.StudsOffset = Vector3.new(0, 0, 0)
			billboard.Parent = part
			billboard.LightInfluence = 0;

			-- create a text label and set it's text to the combo
			local label = Instance.new("TextLabel")
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(2, 0, 2, 0)
			label.Text = num
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.TextScaled = true
			label.TextStrokeTransparency = 0.25
			label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
			label.Rotation = math.random(-10, 10)
			-- Use the arcade font
			label.FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json")
			label.Parent = billboard

			-- tween the billboard gui up and fade it out
			tweenservice:Create(
				billboard,
				TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{
					StudsOffset = Vector3.new(0, 5, 0),
				}
			):Play()

			tweenservice:Create(
				label,
				TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{
					TextTransparency = 1,
					TextStrokeTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0)
				}
			):Play()

			task.wait(1)

			-- destroy the billboard gui
			billboard:Destroy()
			part:Destroy()
		end
	end

	if inNoMiss then
		if tonumber(tt[5]) and tonumber(tt[5]) >= 1 then
			game.Players.LocalPlayer.Character.Humanoid.Health = -100;
			inNoMiss = false;
			inSolo = false;
			task.wait(0.1)
			topb.Text = '<font color="#ff5555">No-Miss failed at a combo of '..tostring(prevcombo)..'!</font>'
			task.wait(5)
			if topb.Text == '<font color="#ff5555">No-Miss failed at a combo of '..tostring(prevcombo)..'!</font>' then -- in case a different message appeared
				topb.Text = ''
			end
		end
		if tt[10] then
			gameUi.Arrows.InfoBar.Text = tt[1].." "..tt[2].." | NO-MISS MODE "..(tt[10])
		end
	elseif SicksOnly then
		if tt[2] ~= "ONLY" and tt[2] ~= "100.00%" and tt[2] ~= "0.00%" and tonumber(tt[5]) >= 1 then
			game.Players.LocalPlayer.Character.Humanoid.Health = -100;
			SicksOnly = false;
			inSolo = false;
			task.wait(0.1)
			topb.Text = '<font color="#ff5555">Sicks-Only failed at a combo of '..tostring(prevcombo)..'!</font>'
			task.wait(5)
			if topb.Text == '<font color="#ff5555">Sicks-Only failed at a combo of '..tostring(prevcombo)..'!</font>' then -- in case a different message appeared
				topb.Text = ''
			end
		else
			gameUi.Arrows.InfoBar.Text = "SICKS ONLY MODE "..(tt[10])
		end
	end

	isReset = false;
end)

gameUi.Arrows:GetPropertyChangedSignal("Visible"):Connect(function()
	if gameUi.Arrows.Visible == false then
		funny.Visible = false
		inNoMiss = false;
		SicksOnly = false;
		autoplayActive = false;
		origintime = 0;
		localhealth = 40;
        songdifficulty = 0;
		inSolo = false;
		globaldata.combo = 0;
		globaldata.totalnotes = 0;
	else
		if inSolo then
			localhealth = 40;
			hpupper.Size = UDim2.new(0.4,0,1,0);
			hpupper.Visible = uidata.Health;
		else
			hpupper.Visible = false;
		end
	end
end)


gameUi.TopbarLabel:GetPropertyChangedSignal("Text"):Connect(function()
	local newtxt = gameUi.TopbarLabel.Text;
	topb.Text = newtxt
	local txttable = string.split(newtxt,"\n")
	if txttable[3] then
		local tim = string.split(txttable[3],":");
		local seconds = tonumber(tim[1])*60 + tonumber(tim[2])
		if origintime == 0 then
			origintime = seconds
            songdifficulty = CalcDifficultyRating(seconds);
		end

        newtxt = newtxt.." | [⭐ "..songdifficulty.."]"

		if uidata.SongProgress then
			local function handler()
				local m = math.floor((seconds/origintime)*75)
				local s = string.split(txttable[1],">")[1]..'>'
				for i=1,math.abs(m-75) do 
					s ..= '|'
				end
				s ..= '</font>'
				for i=1,m do 
					s = s..'|'
				end
				return s
			end

			topb.Text = newtxt.."\n["..handler().."]"
		end
	end
end)

framework.Settings.MissedSound.Value = false;

gameUi.TopbarLabel:GetPropertyChangedSignal("TextColor3"):Connect(function()
    topb.TextColor3 = gameUi.TopbarLabel.TextColor3
end)

gameUi.TopbarLabel:GetPropertyChangedSignal("Visible"):Connect(function()
	gameUi.TopbarLabel.Visible = false;  
end)

-- Old location; kept for compatibility just in-case
--gameUi.SongSelector.Frame.Body.Settings.MultiStage.Visible = false;
--gameUi.SongSelector.Frame.Body.Settings.Solo.SoloInfoLabel.Visible = false;
--gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.Size = UDim2.new(1,0,1,0)
--gameUi.SongSelector.Frame.Body.Settings.Solo.Size = UDim2.new(0,220,1,0)
local newloc = gameUi.SongSelector.Frame.Start
newloc.Toggle.Visible = false;
newloc = newloc.Start
local buttontemplate = newloc.StartButton;

--local ULL = Instance.new("UIListLayout");
--ULL.Padding = UDim.new(0,10);
--ULL.FillDirection = Enum.FillDirection.Horizontal;
--ULL.Parent = gameUi.SongSelector.Frame.Body.Settings;

buttontemplate.MouseButton1Click:Connect(function()
	SendPlay("normal");
end)

local NoMiss = buttontemplate:Clone(); -- NoMiss
NoMiss.Parent = newloc
NoMiss.Name = "StartNoMiss"
NoMiss.Label.Text = "No Misses";
NoMiss.Label.BackgroundColor3 = Color3.new(0.4,1,0.4);
NoMiss.MouseButton1Click:Connect(function()
	if NoMiss.Visible and buttontemplate.BackgroundColor3.R >= buttontemplate.BackgroundColor3.G then
		SendPlay("nomiss")
	end
end)

local SicksOnlyB = buttontemplate:Clone(); -- SicksOnly
SicksOnlyB.Parent = newloc
SicksOnlyB.Name = "StartSicksOnly"
SicksOnlyB.Label.Text = "Sicks Only";
SicksOnlyB.Label.BackgroundColor3 = Color3.new(0.4,0.4,1);
SicksOnlyB.MouseButton1Click:Connect(function()
	if SicksOnlyB.Visible and buttontemplate.BackgroundColor3.R >= buttontemplate.BackgroundColor3.G then
		SendPlay("sicksonly")
	end
end)

buttontemplate:GetPropertyChangedSignal("Visible"):Connect(function() -- Don't let the people press the no-miss if it's not solo
	NoMiss.Visible = uidata.SoloGamemodes and uidata.Modes_NoMiss and buttontemplate.Visible;
	SicksOnlyB.Visible = uidata.SoloGamemodes and uidata.Modes_SicksOnly and buttontemplate.Visible;
end)
buttontemplate:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() -- Oopsie!
	NoMiss.Visible = uidata.SoloGamemodes and uidata.Modes_NoMiss and (buttontemplate.BackgroundColor3.R > buttontemplate.BackgroundColor3.G);
	SicksOnlyB.Visible = uidata.SoloGamemodes and uidata.Modes_SicksOnly and (buttontemplate.BackgroundColor3.R > buttontemplate.BackgroundColor3.G);
end)

-- Stats UI clone
local statgui = gameUi.Arrows.Stats:Clone()
statgui.RichText = true; -- Force rich text on the stats
statgui.Parent = gameUi.Arrows

gameUi.Arrows.Stats:GetPropertyChangedSignal("Visible"):Connect(function()
	if gameUi.Arrows.Stats.Visible then
		gameUi.Arrows.Stats.Visible = false;
	end
end)

gameUi.Arrows.Stats:GetPropertyChangedSignal("Text"):Connect(function() -- This function should show any 'shadow' stats
	gameUi.Arrows.Stats.Visible = false;
	local result1 = string.split(game.Players.LocalPlayer.PlayerGui.GameUI.Arrows.Stats.Text,"\n")
	local res = 0;
	local stats = {};

	for i,v in ipairs(result1) do
		local result2 = string.split(v,":")
		if result2[2] then
			local stat = string.gsub(result2[1]," ","")
			local value = string.gsub(result2[2]," ","")
			res = res + value; -- Add up the total notes hit so it won't count them as shadow notes
			stats[string.lower(stat)] = value
		end
	end

	local showtotalnotes = true;

	if inNoMiss then
		statgui.Text = "Sick: "..stats.sick.."\nGood: "..stats.good.."\nOk: "..stats.ok.."\nBad: "..stats.bad
	elseif SicksOnly then
		statgui.Text = "Hits: "..stats.sick
		showtotalnotes = false;
	else
		statgui.Text = "Sick: "..stats.sick.."\nGood: "..stats.good.."\nOk: "..stats.ok.."\nBad: "..stats.bad.."\nMissed: "..stats.missed
	end

	if res ~= globaldata.totalnotes then
		statgui.Text = "Sick: "..stats.sick.."\nGood: "..stats.good.."\nOk: "..stats.ok.."\nBad: "..stats.bad .. " <font color='#AAAAAA'>(+"..globaldata.totalnotes - res..")</font>".."\nMissed: "..stats.missed
		showtotalnotes = true;
	end
	if showtotalnotes then
		statgui.Text = statgui.Text.."\n<font color='#FFFF77'>Total Notes: "..globaldata.totalnotes.."</font>"
	end

	if SicksOnly then
		if stats.sick ~= globaldata.totalnotes then
			game.Players.LocalPlayer.Character.Humanoid.Health = -100;
		end
	end
end)

local Camera = workspace.Camera;
local FOV = Camera.FieldOfView;

local id = 0;
local connectedevent = nil;
local CurrentStep = 0;
local CurrentBeat = 0;

local debugtext = "";

local SoundEvent = framework:GetEvent("SoundEvent");

ModchartSystem = {
	-- Camera zooming thing
	CameraZoom = function()
		-- Tween the camera
		local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		Camera.FieldOfView = FOV;
		local camtween = tweenservice:Create(Camera, tweenInfo, {FieldOfView = FOV+1});
		secondary.TextSize = 35;
		local txttween = tweenservice:Create(secondary, tweenInfo, {TextSize = 30});
		camtween:Play();
		txttween:Play();
		task.spawn(function()
			camtween.Completed:Wait();
			camtween:Destroy();
			txttween:Destroy();
		end);
	end;

	SetArrowStyle = function(Key, Style)
		framework.ArrowData["4Key"].Arrows[Key].Style = Style;
		framework:GetEvent("ArrowDataChanged"):Fire();
	end;

	SetAllArrows = function(Style)
		for _,v in pairs(framework.ArrowData["4Key"].Arrows) do
			v.Style = Style;
		end;
		framework:GetEvent("ArrowDataChanged"):Fire();
	end;

	SaveArrowsStyle = function()
		local Arrows = {};
		for i,v in pairs(framework.ArrowData["4Key"].Arrows) do
			Arrows[i] = v.Style;
		end
		framework:SetKEValue("SavedArrowsStyle", Arrows);
	end;

	LoadArrowsStyle = function()
		local Arrows = framework:GetKEValue("SavedArrowsStyle");
		for i,v in pairs(Arrows) do
			framework.ArrowData["4Key"].Arrows[i].Style = v;
		end
		framework:GetEvent("ArrowDataChanged"):Fire();
	end;
};

framework.KEMS = ModchartSystem;

Modcharts = {
	-- Modcharts go by [SongId] = {OnBeat, OnSection, ...}

	["9134422683"] = { -- FNF - Mother
		DisableDefault = true; -- Disable the default "modchart" - This disables the default camera zooming (one-per-section).
		SongStart = function(Framework)
			-- This function is called when the song starts.
			print("Started Mother")
		end;
		OnBeat = function(Framework, Beat)
			print("Beat: "..Beat)
			if Beat >= 169 and Beat <= 200 then
				Framework.KEMS.CameraZoom();
			end
		end;
		OnSection = function(Framework, Section)
			print("Section: "..Section)
			Framework.KEMS.CameraZoom();
		end;
		Variables = {
			["HelloWorld"] = 0; -- Framework:GetKEValue("HelloWorld") => 0
		}; -- Sets KE variables here; Accessible by doing Framework:GetKEValue("VariableName");
	};

	["10729979967"] = { -- Vs. LSE - Means of Destruction
		OnBeat = function(Framework, Beat)
			if Beat == 138 then
				Framework.KEMS.SetAllArrows("CircularWide");
				Framework:GetEvent("ArrowDataChanged"):Fire();
			elseif Beat == 300 then
				Framework.KEMS.LoadArrowsStyle();
				Framework:GetEvent("ArrowDataChanged"):Fire();
			end
		end;
	};

	["10729982629"] = { -- Vs. LSE - DAW Wars
		OnBeat = function(Framework, Beat)
			if Beat == 308 then
				Framework.KEMS.SetAllArrows("CircularWide");
				Framework:GetEvent("ArrowDataChanged"):Fire();
			elseif Beat == 436 then
				Framework.KEMS.LoadArrowsStyle();
				Framework:GetEvent("ArrowDataChanged"):Fire();
			end
		end;
	};
}

SoundEvent:Connect(function(Active)
	if Active == false then
		connectedevent:Disconnect();
		connectedevent = nil;
		ModchartSystem.LoadArrowsStyle(); -- Return the arrows to their original style
	end
	id = id + 1;
	local assigned = id;
	local songstart = os.clock();
	if Active == true then
		ModchartSystem.SaveArrowsStyle();
		local defaultbumping = true;
		local songmodchart = nil;
		local songid = framework.SongPlayer.CurrentlyPlaying and framework.SongPlayer.CurrentlyPlaying.SoundId:gsub("rbxassetid://","");
		-- Should come out as just the ID number of the song
		-- Like this; rbxassetid://12345 => 12345

		framework:SetKEValue("SongID", songid);
		print("SongID: "..songid)

		-- Check if the song has a modchart
		if Modcharts and Modcharts[songid] then
			if Modcharts[songid].DisableDefault then
				defaultbumping = false;
			end

			if Modcharts[songid].Variables then
				for i,v in pairs(Modcharts[songid].Variables) do
					framework:SetKEValue(i, v);
				end
			end

			if Modcharts[songid].SongStart then
				Modcharts[songid].SongStart(framework);
			end

			songmodchart = Modcharts[songid];
		end;

		local Zone = framework.StageZone and framework.StageZone.CurrentZone;
		local Stage = Zone and (Zone.Parent.Name:match("Stage") and Zone.Parent);
		if Stage then
			local BPM = Stage:GetAttribute("BPM");
			local OFFSET = Stage:GetAttribute("Offset");
			if BPM then
				local BPS = BPM / 60; -- BPS (Beats per second)
				local SPB = 1 / BPS; -- SPB (Seconds per beat)
				local SPS = SPB / 4; -- SPS (Steps per second)
				if OFFSET then
					task.wait(OFFSET % SPB);
				end;
				CurrentStep = 0;
				CurrentBeat = 0;
				CurrentSection = 0;
				local laststepcheck = 0;
				connectedevent = game:GetService("RunService").RenderStepped:Connect(function() -- Use this to more accurately time the steps
					if id ~= assigned or not uidata.BPMFix_Enabled then
						return;
					end;

					if CurrentStep == 0 then
						CurrentStep = 1;
						CurrentBeat = 1;
						CurrentSection = 1;
					end;

					laststepcheck = os.clock();

					if (laststepcheck + SPS) > (songstart + (SPS * CurrentStep)) then
						CurrentStep = CurrentStep + 1;
						if songmodchart and songmodchart.OnStep then
							songmodchart.OnStep(framework, CurrentStep-1);
						end
					else
						debugtext = "BPM: "..BPM.."\nStep: "..(CurrentStep-1).."\nBeat: "..(CurrentBeat-1).."\nSection: "..CurrentSection.."\nSongID: "..songid;
						debugstuff.Text = debugtext;
						return;
					end;

					if CurrentStep % 4 == 2 then -- Every 4 steps is a beat
						CurrentBeat = CurrentBeat + 1;
						if songmodchart and songmodchart.OnBeat then
							songmodchart.OnBeat(framework, CurrentBeat);
						end
					else
						debugtext = "BPM: "..BPM.."\nStep: "..(CurrentStep-1).."\nBeat: "..(CurrentBeat-1).."\nSection: "..CurrentSection.."\nSongID: "..songid;
						debugstuff.Text = debugtext;
						return;
					end;

					-- Every 4 beats is a section
					if CurrentBeat % 4 == 2 then
						CurrentSection = CurrentSection + 1;
						if defaultbumping then
							ModchartSystem.CameraZoom();
						end
						if songmodchart and songmodchart.OnSection then
							songmodchart.OnSection(framework, CurrentSection);
						end;
					end;

					debugtext = "BPM: "..BPM.."\nStep: "..(CurrentStep-1).."\nBeat: "..(CurrentBeat-1).."\nSection: "..CurrentSection.."\nSongID: "..songid;
					debugstuff.Text = debugtext;
				end);
			end;
		end;
	end;
end);

return framework;
