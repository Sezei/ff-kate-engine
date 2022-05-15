--local engine, ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/main/loader.lua",true))();

-- Services and Variables
local httpservice = game:GetService("HttpService")
local tweenservice = game:GetService("TweenService")
local gameUi = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GameUI")
local origintime = 0;
local version = "v0.3"
local prevcombo = 0
local event = game.ReplicatedStorage.RE;
local inNoMiss = false;
local SicksOnly = false;
local material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/ui-menu-test/UIFramework.lua",true))().Load({Style = 1;Title = "Kate Engine "..version;Theme = "Dark";})
material.Self.Enabled = false;
-- UI time
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
local watermark = Instance.new("TextLabel");
watermark.Parent = gameUi;
watermark.BackgroundTransparency = 1;
watermark.Font = Enum.Font.PermanentMarker;
watermark.Text = "Kate Engine | "..version.."\nCreated by Sezei\n\nSemicolon to Open\nthe Mod Menu"
watermark.TextSize = 26
watermark.TextXAlignment = Enum.TextXAlignment.Left;
watermark.TextYAlignment = Enum.TextYAlignment.Top;
watermark.TextColor3 = Color3.new(1,1,1);
watermark.TextStrokeTransparency = 0.5;
watermark.Position = UDim2.new(0,10,0,0);
watermark.Name = "KE_watermark"
local topb = gameUi.TopbarLabel:Clone();
topb.Parent = gameUi;
topb.Visible = true;
topb.Name = "KE_topbar"

material.Banner({Text = "Kate Engine v0.3 - At last, added the mod menu. You can now create your own mods and add them to the menu by adding a 'ui' variable to the loadstring, so it'll look like this:\n\nlocal engine, ui = ..."});

local uidata = { -- Saving Purposes. Also easier to access ig.
	DataVersion = version;
	ManiaCounter = true;
	SongProgress = true;
	SoloGamemodes = true;
	Mania_FCIndicator = true;
	Mania_SimpleRatings = false;
	Mania_0Combo = Color3.new(1,1,1);
	Mania_100Combo = Color3.new(1,1,0.75);
	Mania_200Combo = Color3.new(1,1,0.5);
	Mania_300Combo = Color3.new(1,1,0.25);
	Mania_400Combo = Color3.new(1,1,0);
	Modes_NoMiss = true;
	Modes_SicksOnly = true;
}

local maintab = material.New({Title = "Main"}) do
	if type(readfile) == 'function' and type(writefile) == 'function' and type(isfile) == 'function' then
		maintab.Label({
			Text = "-- SAVE & LOAD --";
		})
		ConfigLoad = maintab.Button({
			Text = "Load KE Settings"; 
			Callback = function()
				if not isfile('KE_Config.json') then
					material.Banner({Text = "Attempt to load UI config has failed: Unable to read the file.\n\nInfo:\nFile 'KE_Config.json' does not exist!"});
					return
				end
				local success, data = pcall(function()
					return readfile('KE_Config.json')
				end)
				if not success then
					material.Banner({Text = "Attempt to load UI config has failed: Unable to read the file.\n\nInfo:\n"..data});
					return
				end
				local success, decoded = pcall(httpservice.JSONDecode, httpservice, readfile('KE_Config.json'))
				if not success then
					material.Banner({Text = "Attempt to load UI config has failed: Unable to decode UI data.\n\nInfo:\n"..decoded});
					return
				end
				if decoded.DataVersion ~= version then
					material.Banner({Text = "UI config has loaded correctly, but is outdated - Watch out for any corrupted data."});
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
					end
				end
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
					writefile('KE_Config.json', encoded)
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
end;

local maniatab = material.New({Title = "Mania"}) do
	maniatab.Label({
		Text = "-- RATINGS --";
	});
	Mania_FCIndicator = maniatab.Toggle({
		Text = "FC Indicator";
		Callback = function(bool)
			uidata.Mania_FCIndicator = bool
		end;
		Enabled = true;
	});
	Mania_SimpleRatings = maniatab.Toggle({
		Text = "Simple Ratings";
		Callback = function(bool)
			uidata.Mania_SimpleRatings = bool
		end;
		Enabled = false;
	});
	maniatab.Label({
		Text = "-- COLORS --";
	});
	Mania_0Combo = maniatab.ColorPicker({
		Text = "Mania 0 Combo";
		Callback = function(color)
			uidata.Mania_0Combo = color
		end;
		Default = Color3.new(1,1,1);
	});
	Mania_100Combo = maniatab.ColorPicker({
		Text = "Mania 100 Combo";
		Callback = function(color)
			uidata.Mania_100Combo = color
		end;
		Default = Color3.new(1,1,0.75);
	});
	Mania_200Combo = maniatab.ColorPicker({
		Text = "Mania 200 Combo";
		Callback = function(color)
			uidata.Mania_200Combo = color
		end;
		Default = Color3.new(1,1,0.5);
	});
	Mania_300Combo = maniatab.ColorPicker({
		Text = "Mania 300 Combo";
		Callback = function(color)
			uidata.Mania_300Combo = color
		end;
		Default = Color3.new(1,1,0.25);
	});
	Mania_400Combo = maniatab.ColorPicker({
		Text = "Mania 400 Combo";
		Callback = function(color)
			uidata.Mania_400Combo = color
		end;
		Default = Color3.new(1,1,0);
	});
end;

local modestab = material.New({Title = "Game Modes"}) do
	modestab.Label({
		Text = "-- ENABLED MODES --";
	});
	Modes_NoMiss = modestab.Toggle({
		Text = "No-Miss Mode Button";
		Callback = function(bool)
			print("Modes_NoMiss: "..tostring(bool))
		end;
		Enabled = true;
	});
	Modes_SicksOnly = modestab.Toggle({
		Text = "Sicks-Only Mode Button";
		Callback = function(bool)
			print("Modes_SicksOnly: "..tostring(bool))
		end;
		Enabled = true;
	});
end;

local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(info)
	if info.UserInputType == Enum.UserInputType.Keyboard then
		if info.KeyCode == Enum.KeyCode.Semicolon then
			material.Self.Enabled = not material.Self.Enabled
		end
	end
end)

local function CalcRating(one,two)
	if not uidata.Mania_SimpleRatings then
		if one == 100 then
			return "P"
		elseif one == 99 then
			if two >= 95 then
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

local function updateCombo(combo,acc,miss)
	if not miss then miss = 0 end -- bandaid for some reason

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
	funny.TextSize = (combo >= 200 and 75 or combo >= 100 and 65 or 55)
	tweenservice:Create(
		funny,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{
			TextSize = 50
		}
	):Play()

	if combo % 50 == 0 then
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
	if var == "nomiss" then
		inNoMiss = true;
	elseif var == "sicksonly" then
		SicksOnly = true;
	end
	event:FireServer({"Server","StageManager","PlaySolo"},{});
end

gameUi.Arrows.InfoBar:GetPropertyChangedSignal("Text"):Connect(function()
	local t = gameUi.Arrows.InfoBar.Text
	local tt = string.split(t, " ")
	local num;
	local prevcombo = prevcombo -- :)

	if tt[10] then
		num = string.gsub(tt[10], "%D", "")
		updateCombo(tonumber(num),tt[2],tonumber(tt[5]))
	elseif tt[8] then
		num = string.gsub(tt[8], "%D", "")
		updateCombo(tonumber(num),tt[2],tonumber(tt[5]))
	end

	if inNoMiss then
		if tonumber(tt[5]) and tonumber(tt[5]) >= 1 then
			game.Players.LocalPlayer.Character.Humanoid.Health = -100;
			inNoMiss = false;
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
		if tt[2] ~= "ONLY" and tt[2] ~= "100.00%" then
			game.Players.LocalPlayer.Character.Humanoid.Health = -100;
			SicksOnly = false;
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
end)

gameUi.Arrows:GetPropertyChangedSignal("Visible"):Connect(function()
	if gameUi.Arrows.Visible == false then
		funny.Visible = false
		inNoMiss = false;
		SicksOnly = false;
		origintime = 0;
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
		end

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

gameUi.TopbarLabel:GetPropertyChangedSignal("Visible"):Connect(function()
	gameUi.TopbarLabel.Visible = false;  
end)

gameUi.SongSelector.Frame.Body.Settings.MultiStage.Visible = false;
gameUi.SongSelector.Frame.Body.Settings.Solo.SoloInfoLabel.Visible = false;
gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.Size = UDim2.new(1,0,1,0)
gameUi.SongSelector.Frame.Body.Settings.Solo.Size = UDim2.new(0,220,1,0)

local ULL = Instance.new("UIListLayout");
ULL.Padding = UDim.new(0,10);
ULL.FillDirection = Enum.FillDirection.Horizontal;
ULL.Parent = gameUi.SongSelector.Frame.Body.Settings;

local NoMiss = gameUi.SongSelector.Frame.Body.Settings.Solo:Clone(); -- NoMiss
NoMiss.Parent = gameUi.SongSelector.Frame.Body.Settings
NoMiss.Name = "KE_NoMiss"
NoMiss.SoloPlay.Text = "No Misses";
NoMiss.SoloPlay.BackgroundColor3 = Color3.new(0.4,1,0.4);
NoMiss.SoloPlay.MouseButton1Click:Connect(function()
	if NoMiss.Visible and gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.R >= gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.G then
		SendPlay("nomiss")
	end
end)

local SicksOnlyB = gameUi.SongSelector.Frame.Body.Settings.Solo:Clone(); -- SicksOnly
SicksOnlyB.Parent = gameUi.SongSelector.Frame.Body.Settings
SicksOnlyB.Name = "KE_SicksOnly"
SicksOnlyB.SoloPlay.Text = "Sicks Only";
SicksOnlyB.SoloPlay.BackgroundColor3 = Color3.new(0.4,0.4,1);
SicksOnlyB.SoloPlay.MouseButton1Click:Connect(function()
	if SicksOnlyB.Visible and gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.R >= gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.G then
		SendPlay("sicksonly")
	end
end)

gameUi.SongSelector.Frame.Body.Settings.Solo:GetPropertyChangedSignal("Visible"):Connect(function() -- Don't let the people press the no-miss if it's not solo
	NoMiss.Visible = uidata.SoloGamemodes and uidata.Modes_NoMiss and gameUi.SongSelector.Frame.Body.Settings.Solo.Visible;
	SicksOnlyB.Visible = uidata.SoloGamemodes and uidata.Modes_SicksOnly and gameUi.SongSelector.Frame.Body.Settings.Solo.Visible;
	gameUi.SongSelector.Frame.Body.Settings.MultiStage.Visible = not gameUi.SongSelector.Frame.Body.Settings.Solo.Visible;
end)
gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() -- Oopsie!
	NoMiss.Visible = uidata.SoloGamemodes and uidata.Modes_NoMiss and (gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.R > gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.G);
	SicksOnlyB.Visible = uidata.SoloGamemodes and uidata.Modes_SicksOnly and (gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.R > gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.G);
	gameUi.SongSelector.Frame.Body.Settings.MultiStage.Visible = gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.R == gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.G;
end)

return gameUi, material
