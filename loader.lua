-- why did i even need to include this 💀
if game.PlaceId ~= 6447798030 and game.PlaceId ~= 6996694685 then
	return error("No!")
end

-- Check which functions are missing in order to know what to expect from the client
local missing = {};

if not getgc then -- This one is required for the script to work, as it hooks into the Framework.
	return error("Your exploit is not supported by this script; Missing function getgc().")
end;

if not writefile or not readfile or not isfile then
	missing["file storage"] = true;
end;

if not setclipboard then
	missing["clipboard"] = true;
end;

-- Function to get the Framework
function getGameFramework()
	for _, v in next, getgc(true) do
		if type(v) == 'table' and rawget(v, 'GameUI') then
			return v
		end
	end
end

local ColorJSON = {
	Encode = function(Color)
		return string.format("%s,%s,%s", Color.r, Color.g, Color.b);
	end;
	Decode = function(Color)
		local RGB = string.split(Color, ",");
		return Color3.new(RGB[1], RGB[2], RGB[3]);
	end;
};

local Framework = getGameFramework();

local Version = "b0.10";

-- Create the KateEngine table
KateEngine = {
	-- Base Info
	Version = Version;
	Shared = {};
	InSolo = false;

	-- Game Modifications
	Health = {
		Current = 40;
		Max = 100;
	};

	-- UI Improvements
	Mania = {
		PreviousCombo = 0;
		CurrentCombo = 0;
		TotalNotes = 0;
		Combo = 0;
	};
	Topbar = {
		OriginTime = 0;
		SongDifficulty = 0;
	};

	ColorJSON = ColorJSON;

	-- UI Settings; They are built from the MenuBuild table, so for now it's empty. For documentation sake, Key is the name of the setting, and Value is the value of the setting.
	Settings = {};

	-- Menu Settings; These are the settings that are used to build the menu and are used to save the settings.
	MenuBuild = {
		["Main"] = {
			{
				Type = "Boolean";
				Default = false;
				Text = "3D Combo Display";
				Key = "WorldCombo";

				Stored = true;
			};
			{
				Type = "Boolean";
				Default = true;
				Text = "Enable Modcharts";
				Key = "Modcharts";

				Stored = true;
			};
			{
				Requirement = "clipboard";
				Type = "Button";
				Text = "Copy Song ID";
				Callback = function()
					setclipboard(Framework:GetKEValue("SongID"));
				end;
			};
		};

		["Display"] = {
			{
				Type = "Label";
				Text = "-- MANIA --";
			};
			{
				Type = "Label";
				Text = "This section contains settings for the Mania Combo Counter.";
			};
			{
				Type = "Boolean";
				Default = false;
				Text = "Enabled";
				Key = "ManiaCounter";

				Stored = true;
			};
			{
				Type = "Boolean";
				Default = true;
				Text = "FC Indicator";
				Key = "Mania_FCIndicator";

				Stored = true;
			};
			{
				Type = "Boolean";
				Default = false;
				Text = "Simple Ratings";
				Key = "Mania_SimpleRatings";

				Stored = true;
			};
			{
				Type = "Boolean";
				Default = true;
				Text = "Dynamic Font Increments";
				Key = "Mania_DynamicIncrements";

				Stored = true;
			};
			{
				Type = "Multichoice";
				Default = 50;
				Text = "Milestone";
				Key = "Mania_Milestone";
				Options = {10, 20, 25, 50, 100};

				Stored = true;
			};
			{
				Type = "Color3";
				Default = ColorJSON.Encode(Color3.new(1,1,1));
				Text = "0 Combo Color";
				Key = "Mania_0Combo";

				Stored = true;
			};
			{
				Type = "Color3";
				Default = ColorJSON.Encode(Color3.new(1,1,0.75));
				Text = "100 Combo Color";
				Key = "Mania_100Combo";

				Stored = true;
			};
			{
				Type = "Color3";
				Default = ColorJSON.Encode(Color3.new(1,1,0.5));
				Text = "200 Combo Color";
				Key = "Mania_200Combo";

				Stored = true;
			};
			{
				Type = "Color3";
				Default = ColorJSON.Encode(Color3.new(1,1,0.25));
				Text = "300 Combo Color";
				Key = "Mania_300Combo";

				Stored = true;
			};
			{
				Type = "Color3";
				Default = ColorJSON.Encode(Color3.new(1,1,0));
				Text = "400 Combo Color";
				Key = "Mania_400Combo";

				Stored = true;
			};
		};

		["Gameplay"] = {
			{
				Type = "Label";
				Text = "-- BOT OPPONENT --";
			};
			{
				Type = "Label";
				Text = "This section contains settings for the bot opponent. <font color='#ff7700'><b>Temporarily Disabled for Optimization.</b></font>";
			};
			{
				Type = "Multichoice";
				Default = "Insane";
				Text = "Bot Difficulty";
				Key = "BotDifficulty";
				Options = {"Average Blimey (Insane) Player", "Easy", "Normal", "Hard", "Insane", "PFC"};

				Stored = true;
			};
			{
				Type = "Label";
				Text = "-- HEALTHBAR --";
			};
			{
				Type = "Label";
				Text = "This section contains settings for the healthbar.";
			};
			{
				Type = "Boolean";
				Default = true;
				Text = "Enabled";
				Key = "Healthbar";
				Callback = function(Value)
					if Value then
						KateEngine.Assets.Healthbar.Visible = true;
					else
						KateEngine.Assets.Healthbar.Visible = false;
					end
				end;

				Stored = true;
			};
			{
				Type = "Boolean";
				Default = true;
				Text = "Death on 0 Health";
				Key = "Healthbar_DeathOnZero";

				Stored = true;
			};
			{
				Type = "Slider";
				Default = 5; -- Apparently it's 5 from the Framework source.
				Text = "Health Gain";
				Key = "Healthbar_HealthGain";
				Minimum = 1;
				Maximum = 50;

				Stored = true;
			};
			{
				Type = "Slider";
				Default = 15;
				Text = "Health Loss";
				Key = "Healthbar_HealthLoss";
				Minimum = 1;
				Maximum = 50;

				Stored = true;
			};
			{
				Type = "Color3";
				Default = ColorJSON.Encode(Color3.new(1,0,0));
				Text = "Missing Health Color";
				Key = "Healthbar_ColorBack";

				Callback = function(Value)
					KateEngine.Assets.Healthbar.BackgroundColor3 = Value;
				end;

				Stored = true;
			};
			{
				Type = "Color3";
				Default = ColorJSON.Encode(Color3.new(0,1,0));
				Text = "Remaining Health Color";
				Key = "Healthbar_ColorFront";

				Callback = function(Value)
					KateEngine.Assets.Healthbar.Front.BackgroundColor3 = Value;
				end;

				Stored = true;
			};
		};

		["Credits"] = {
			{
				Type = "Label";
				Text = "Kate Engine " .. Version;
			};
			{
				Type = "Label";
				Text = "Direct Contributors:";
			};
			{
				Type = "Label";
				Text = "<font color=\"#ff1a70\">Sezei</font> - Script";
			};
			{
				Type = "Label";
				Text = "<font color=\"#00ff00\">Wally</font> / <font color=\"#00ff00\">Bigtimbob</font> - Framework Detection";
			};
			{
				Type = "Label";
				Text = "Resources Used:";
			};
			{
				Type = "Label";
				Text = "<font color=\"#ff7700\">Kinlei</font>(?) - UI Library";
			};
			{
				Type = "Boolean";
				Default = false;
				Text = "Hide Watermark";
				Key = "HideWatermark";
				Callback = function(Value)
					if Value then
						KateEngine.Assets.Watermark.Visible = false;
					else
						KateEngine.Assets.Watermark.Visible = true;
					end
				end;

				Stored = false;
			}
		};
	};

	-- Store assets generated by the script
	Assets = {};
};

Framework.KateEngine = KateEngine;

-- Pre-Rewrite Support
Framework.KEValues = {};

function Framework:SetKEValue(key, value)
	self.KEValues[key] = value;
end
function Framework:GetKEValue(key)
	return self.KEValues[key];
end

-- Services and Variables
local HttpService = game:GetService("HttpService");
local TweenService = game:GetService("TweenService");
local UIS = game:GetService("UserInputService");

-- Game Stuff
local GameUI = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GameUI");
local RemoteEvent = game.ReplicatedStorage.RE;

-- Material UI (Used for the menu)
local material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/main/UIFramework.lua",true))().Load({Style = 1;Title = "Kate Engine "..Version;Theme = "Dark";SizeX = 500;})
material.Self.Enabled = false;

-- Build the UI
-- Mania Combo Counter
local ManiaComboCounter = Instance.new("TextLabel");
ManiaComboCounter.AnchorPoint = Vector2.new(0.5, 0.5);
ManiaComboCounter.Position = UDim2.fromScale(0.5, 0.5);
ManiaComboCounter.Parent = GameUI;
ManiaComboCounter.BackgroundTransparency = 1;
ManiaComboCounter.TextColor3 = Color3.new(1, 1, 1);
ManiaComboCounter.TextStrokeColor3 = Color3.new(0, 0, 0);
ManiaComboCounter.TextStrokeTransparency = 0.5;
ManiaComboCounter.TextSize = 50;
ManiaComboCounter.Text = "0";
ManiaComboCounter.Font = Enum.Font.Arcade;
ManiaComboCounter.Visible = false;
ManiaComboCounter.Name = "KE_ManiaComboCounter";
KateEngine.Assets.ManiaComboCounter = ManiaComboCounter;

local ManiaComboCounterTween = ManiaComboCounter:Clone();
ManiaComboCounterTween.Visible = true;
ManiaComboCounterTween.Parent = ManiaComboCounter;
ManiaComboCounterTween.TextStrokeTransparency = 1;
ManiaComboCounterTween.TextTransparency = 1;
ManiaComboCounterTween.Name = "Tween";

local ManiaRating = ManiaComboCounter:Clone();
ManiaRating.Visible = true;
ManiaRating.Parent = ManiaComboCounter;
ManiaRating.Text = "";
ManiaRating.Position = UDim2.new(0.5,0,0,40);
ManiaRating.TextSize = 30;
ManiaRating.Name = "Rating";

-- Lyrics UI
local LyricsLabel = Instance.new("TextLabel");
LyricsLabel.AnchorPoint = Vector2.new(0.5, 0.75);
LyricsLabel.Position = UDim2.fromScale(0.5, 0.75);
LyricsLabel.Parent = GameUI;
LyricsLabel.BackgroundTransparency = 1;
LyricsLabel.TextColor3 = Color3.new(1, 1, 1);
LyricsLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
LyricsLabel.TextStrokeTransparency = 0.5;
LyricsLabel.TextSize = 45;
LyricsLabel.Text = "";
LyricsLabel.Font = Enum.Font.PermanentMarker;
LyricsLabel.Visible = false;
LyricsLabel.Name = "KE_lyrics";
LyricsLabel.RichText = true;
KateEngine.Assets.LyricsLabel = LyricsLabel;

-- Watermark stuff
local Watermark = Instance.new("ImageLabel");
Watermark.Name = "KE_Watermark";
Watermark.Image = "rbxassetid://12289530118";
Watermark.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
Watermark.BackgroundTransparency = 1;
Watermark.Size = UDim2.fromOffset(143, 94);
KateEngine.Assets.Watermark = Watermark;

local WatermarkVersion = Instance.new("TextLabel");
WatermarkVersion.Name = "Version";
WatermarkVersion.Font = Enum.Font.PermanentMarker;
WatermarkVersion.Text = KateEngine.Version;
WatermarkVersion.TextColor3 = Color3.fromRGB(255, 255, 255);
WatermarkVersion.TextSize = 28;
WatermarkVersion.TextXAlignment = Enum.TextXAlignment.Left;
WatermarkVersion.TextYAlignment = Enum.TextYAlignment.Bottom;
WatermarkVersion.AnchorPoint = Vector2.new(0.5, 1);
WatermarkVersion.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
WatermarkVersion.BackgroundTransparency = 1;
WatermarkVersion.Position = UDim2.new(0.5, 0, 1, 10);
WatermarkVersion.Size = UDim2.new(0.95, 0, 0, 50);

local BPMSheet = Instance.new("TextLabel");
BPMSheet.Name = "BPMSheet";
BPMSheet.Font = Enum.Font.PermanentMarker;
BPMSheet.Text = "DEBUG STUFF!";
BPMSheet.TextColor3 = Color3.fromRGB(255, 255, 255);
BPMSheet.TextSize = 18;
BPMSheet.TextXAlignment = Enum.TextXAlignment.Left;
BPMSheet.TextYAlignment = Enum.TextYAlignment.Top;
BPMSheet.AnchorPoint = Vector2.new(0.5, 1);
BPMSheet.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
BPMSheet.BackgroundTransparency = 1;
BPMSheet.Position = UDim2.new(0.5, 0, 1, 48);
BPMSheet.Size = UDim2.new(0.95, 0, 0, 20);

local UIStroke = Instance.new("UIStroke");
UIStroke.Thickness = 2;
UIStroke.Parent = WatermarkVersion;

UIStroke:Clone().Parent = BPMSheet;

WatermarkVersion.Parent = Watermark;
BPMSheet.Parent = Watermark;

Watermark.Parent = GameUI;

-- Topbar clone
local Topbar = GameUI.TopbarLabel:Clone();
Topbar.Parent = GameUI;
Topbar.Visible = true;
Topbar.Name = "KE_Topbar";
KateEngine.Assets.Topbar = Topbar;

local Healthbar = Instance.new("Frame");
Healthbar.Visible = true;
Healthbar.Parent = GameUI.Arrows;
Healthbar.AnchorPoint = Vector2.new(0.5,1);
Healthbar.Position = UDim2.new(0.5,0,1,-50);
Healthbar.Size = UDim2.new(0.4,0,0,16);
Healthbar.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
Healthbar.BorderSizePixel = 0;
Healthbar.Name = "KE_Healthbar";
KateEngine.Assets.Healthbar = Healthbar;

local UIStrokeHealthbar = Instance.new("UIStroke");
UIStrokeHealthbar.Thickness = 2;
UIStrokeHealthbar.Transparency = 0.25;
UIStrokeHealthbar.Parent = Healthbar;
UIStrokeHealthbar.Color = Color3.fromRGB(46, 46, 46);

local HBFront = Healthbar:Clone();
HBFront.Visible = true;
HBFront.Parent = Healthbar;
HBFront.AnchorPoint = Vector2.new(1,0.5);
HBFront.Size = UDim2.new(0.4,0,1,0);
HBFront.Position = UDim2.new(1,0,0.5,0);
HBFront.BackgroundColor3 = Color3.new(0,1,0);
HBFront.ZIndex = 2;
HBFront.Name = "Front";

material.Banner({Text = "Rewrote Kate Engine to be more readable. All of the mods are now disabled by default. You can enable them in the settings menu.\n\n- Removed Gamemodes."});

if not missing["file storage"] then
	if isfile("KateEngine.mp5") then -- Load the settings if they exist
		local data = game:GetService("HttpService"):JSONDecode(readfile("KateEngine.mp5"));
		KateEngine.Settings = data;
	end
end

-- Create the UI
for category, v in pairs(KateEngine.MenuBuild) do
	local tab = material.New({Title = category});
	for _, data in ipairs(v) do

		if data.Requirement and missing[data.Requirement] then -- Skip if the requirement is missing
			continue;
		end

		-- Check which type of UI element to create
		local datatype = data.Type;

		if datatype == "Label" then
			tab.Label({
				Text = data.Text;
			});
		elseif datatype == "Button" then
			tab.Button({
				Text = data.Text;
				Callback = function()
					if data.Callback then
						data.Callback();
					end
				end;
			});
		elseif datatype == "Boolean" then
			KateEngine.Settings[data.Key] = KateEngine.Settings[data.Key] or data.Default;
			tab.Toggle({
				Text = data.Text;
				Callback = function(bool)
					if data.Callback then
						data.Callback(bool);
					end
					KateEngine.Settings[data.Key] = bool;
					writefile("KateEngine.mp5", game:GetService("HttpService"):JSONEncode(KateEngine.Settings));
				end;
				Enabled = KateEngine.Settings[data.Key] or data.Default;
			});
		elseif datatype == "Slider" then
			KateEngine.Settings[data.Key] = KateEngine.Settings[data.Key] or data.Default;
			tab.Slider({
				Text = data.Text;
				Callback = function(value)
					if data.Callback then
						data.Callback(value);
					end
					KateEngine.Settings[data.Key] = value;
					writefile("KateEngine.mp5", game:GetService("HttpService"):JSONEncode(KateEngine.Settings));
				end;
				Min = data.Minimum;
				Max = data.Maximum;
				Def = KateEngine.Settings[data.Key] or data.Default;
			});
		elseif datatype == "Multichoice" then
			KateEngine.Settings[data.Key] = KateEngine.Settings[data.Key] or data.Default;
			local dropdown = tab.Dropdown({
				Text = data.Text;
				Callback = function(value)
					if data.Callback then
						data.Callback(value);
					end
					KateEngine.Settings[data.Key] = value;
					writefile("KateEngine.mp5", game:GetService("HttpService"):JSONEncode(KateEngine.Settings));
				end;
				Options = data.Options;
				Default = KateEngine.Settings[data.Key] or data.Default;
			});
		elseif datatype == "Color3" then
			KateEngine.Settings[data.Key] = KateEngine.Settings[data.Key] or data.Default;
			tab.ColorPicker({
				Text = data.Text;
				Callback = function(value)
					if data.Callback then
						data.Callback(value);
					end
					KateEngine.Settings[data.Key] = KateEngine.ColorJSON.Encode(value);
					writefile("KateEngine.mp5", game:GetService("HttpService"):JSONEncode(KateEngine.Settings));
				end;
				Default = KateEngine.ColorJSON.Decode(KateEngine.Settings[data.Key] or data.Default);
			});
		end
	end
end

UIS.InputBegan:Connect(function(info)
	if UIS:GetFocusedTextBox() then return end -- Ignore if textbox is focused
	if info.UserInputType == Enum.UserInputType.Keyboard then
		if info.KeyCode == Enum.KeyCode.Home then
			material.Self.Enabled = not material.Self.Enabled
		end
	end
end)

local function CalcDifficultyRating(lenght)
    local diff = 0;
    repeat task.wait() until (Framework.SongPlayer.CurrentSongData and #Framework.SongPlayer.CurrentSongData > 0);
    local notes = #Framework.SongPlayer.CurrentSongData;
    local avgnps = notes / lenght; -- Average notes per second

    diff += lenght/60;
    diff += notes/300;
    diff += avgnps*5;

    -- Make the difficulty a float number with 2 decimals
    diff = math.floor(diff * 100) / 100;

    return diff;
end

local Ratings = {
	Simple = {
		[100] = "P";
		[99] = "S";
		[95] = "A";
		[90] = "B";
		[80] = "C";
		[50] = "D";
	};
	Regular = {
		[100] = "P";
		[99.98] = "S++";
		[99.95] = "S+";
		[99.9] = "S";
		[99.8] = "AAA";
		[99.7] = "AA+";
		[99.6] = "AA:";
		[99.5] = "AA.";
		[99.4] = "AA";
		[99.3] = "A+";
		[99.2] = "A:";
		[99.1] = "A.";
		[99] = "A";
		[97] = "A-";
		[95] = "B+";
		[80] = "B";
		[70] = "C";
		[60] = "D";
		[50] = "F+";
	};
}

local function UpdateHealth() -- To be fired every time health is added/reduced
	-- If healthbar is disabled, set health to 40 (starting value) and return.
	if not KateEngine.InSolo then KateEngine.Health.Current = 40; return end;
	if not KateEngine.Settings.Healthbar then KateEngine.Health.Current = 40; return end;

	-- Otherwise, clamp the health between 0 and 100 and update the healthbar.
	KateEngine.Health.Current = math.clamp(KateEngine.Health.Current,0,100);
	HBFront.Size = UDim2.new(KateEngine.Health.Current/100,0,1,0);
	if KateEngine.Health.Current == 0 and KateEngine.Settings.Healthbar_DeathOnZero then
		game.Players.LocalPlayer.Character.Humanoid.Health = -100;
	end
end

local function CalcRating(one,two)
	local combinedrating = one + (two/100); -- Combine the two ratings
	local highestrank = {0,"F"};
	if not KateEngine.Settings.Mania_SimpleRatings then
		for i,v in pairs(Ratings.Regular) do
			if combinedrating >= i and i > highestrank[1] then
				highestrank = {i,v};
			end
		end
	else
		for i,v in pairs(Ratings.Simple) do
			if combinedrating >= i and i > highestrank[1] then
				highestrank = {i,v};
			end
		end
	end
	return highestrank[2];
end;

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

	KateEngine.Mania.Combo = combo;
	KateEngine.Mania.TotalNotes += 1;

	local result1 = string.split(game.Players.LocalPlayer.PlayerGui.GameUI.Arrows.Stats.Text,"\n")
	local res = {};
	for k,f in pairs(result1) do
		res[k] = tonumber(string.split(f," ")[2]);
	end

	if KateEngine.Settings.Mania_FCIndicator then
		local totalnonmiss = res[2] + res[3] + res[4];
		if res[2] == 0 and res[3] == 0 and res[4] == 0 and miss== 0 then
			ManiaRating.Text = "PFC"
		elseif res[2] == 1 and res[3] == 0 and res[4] == 0 and miss== 0 then -- good
			ManiaRating.Text = "G-FLAG"
		elseif res[2] == 0 and res[3] == 1 and res[4] == 0 and miss == 0 then -- OK
			ManiaRating.Text = "O-FLAG"
		elseif res[2] == 0 and res[3] == 0 and res[4] == 1 and miss == 0 then -- bad
			ManiaRating.Text = "B-FLAG"
		elseif res[2] == 0 and res[3] == 0 and res[4] == 0 and miss == 1 then -- one miss but no goods, bads nor oks
			ManiaRating.Text = "M-FLAG"
		elseif res[3] == 0 and res[4] == 0 and miss == 0 then
			ManiaRating.Text = "GFC"
		elseif totalnonmiss < 10 and miss == 0 then
			ManiaRating.Text = "SUB ("..totalnonmiss..")"
		elseif res[2] < 10 and miss == 0 then
			ManiaRating.Text = "SDG ("..res[2]..")"
		elseif miss == 0 then
			ManiaRating.Text = "FC"
		elseif miss == 1 and totalnonmiss < 10 then
			ManiaRating.Text = "SUB-1 ("..totalnonmiss..")"
		elseif miss == 1 then
			ManiaRating.Text = "MIN1"
		elseif miss <= 9 then
			ManiaRating.Text = "SDCB (-"..miss..")"
		else
			ManiaRating.Text = "Clear (-"..miss..")"
		end

		if combo < 20 then
			ManiaRating.Text = ""
		end
	else
		ManiaRating.Text = ""
	end

	local accur = string.split(acc,".")
	local num = string.gsub(accur[2], "%D", "")

	if ManiaRating.Text == "" or not KateEngine.Settings.Mania_FCIndicator then
		ManiaRating.Text = CalcRating(tonumber(accur[1]),tonumber(num))
	else
		ManiaRating.Text..= " | "..CalcRating(tonumber(accur[1]),tonumber(num))
	end

	if KateEngine.Settings.Healthbar then
		if KateEngine.InSolo then
			Healthbar.Visible = KateEngine.Settings.Healthbar;

			if miss > prevmiss then
				KateEngine.Health.Current -= KateEngine.Settings.Healthbar_HealthLoss;
			else
				KateEngine.Health.Current += KateEngine.Settings.Healthbar_HealthGain;
			end
			
			UpdateHealth();
		else
			Healthbar.Visible = false;
			KateEngine.Health.Current = 40;
		end
	end

	prevmiss = miss;

	if KateEngine.Mania.PreviousCombo >= 20 and combo < 20 then
		-- Combo Break
		TweenService:Create(
			ManiaComboCounter,
			TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{
				TextColor3 = Color3.new(1, 0, 0)
			}
		):Play()
		task.spawn(
			function()
				task.wait(0.3)
				TweenService:Create(
					ManiaComboCounter,
					TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{
						TextTransparency = 1
					}
				):Play()
				task.wait(0.3)
				ManiaComboCounter.Visible = false
				ManiaComboCounter.TextTransparency = 0
			end
		)
	end
	task.spawn(function()
		if combo == 0 then
			task.wait(0.2)
		end
		KateEngine.Mania.PreviousCombo = combo
	end)

	if not KateEngine.Settings.ManiaCounter then ManiaComboCounter.Visible = false return end;

	if combo < 20 then
		return
	else
		ManiaComboCounter.Visible = true
	end

	if combo >= 400 then
		ManiaComboCounter.TextColor3 = KateEngine.ColorJSON.Decode(KateEngine.Settings.Mania_400Combo)
	elseif combo >= 300 then
		ManiaComboCounter.TextColor3 = KateEngine.ColorJSON.Decode(KateEngine.Settings.Mania_300Combo)
	elseif combo >= 200 then
		ManiaComboCounter.TextColor3 = KateEngine.ColorJSON.Decode(KateEngine.Settings.Mania_200Combo)
	elseif combo >= 100 then
		ManiaComboCounter.TextColor3 = KateEngine.ColorJSON.Decode(KateEngine.Settings.Mania_100Combo)
	else
		ManiaComboCounter.TextColor3 = KateEngine.ColorJSON.Decode(KateEngine.Settings.Mania_0Combo)
	end
	ManiaComboCounter.Text = combo
	if KateEngine.Settings.Mania_DynamicIncrements then
		ManiaComboCounter.TextSize = DynamicFont();
	else
		ManiaComboCounter.TextSize = (combo >= 200 and 75 or combo >= 100 and 65 or 55);
	end
	TweenService:Create(
		ManiaComboCounter,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{
			TextSize = 50
		}
	):Play()

	if combo % tonumber(KateEngine.Settings.Mania_Milestone) == 0 then
		ManiaComboCounterTween.TextTransparency = 0
		ManiaComboCounterTween.TextSize = 70
		ManiaComboCounterTween.Text = combo
		TweenService:Create(
			ManiaComboCounterTween,
			TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{
				TextSize = 100,
				TextTransparency = 1
			}
		):Play()
	end
end

local function SendPlay()
	KateEngine.InSolo = true;
end

local lastmiss = 0;

GameUI.Arrows.InfoBar:GetPropertyChangedSignal("Text"):Connect(function()
	local t = GameUI.Arrows.InfoBar.Text
	local tt = string.split(t, " ")
	local num;
	local isReset = false;

	if tt[2] == "0.00%" and tt[5] == "0" then
		isReset = true;
	end

    if not isReset then
        if tonumber(tt[5]) > lastmiss then
            -- Play the miss sound if the miss count is higher than the last miss count
            local sound = Instance.new("Sound")
            sound.SoundId = Framework.Assets.Sounds:FindFirstChild("MissedNotes"):GetChildren()[math.random(#Framework.Assets.Sounds:FindFirstChild("MissedNotes"):GetChildren())].SoundId
            sound.Volume = 0.35
            sound.Parent = GameUI
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
		if KateEngine.Settings.WorldCombo then
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
			TweenService:Create(
				billboard,
				TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{
					StudsOffset = Vector3.new(0, 5, 0),
				}
			):Play()

			TweenService:Create(
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

	isReset = false;
end)

GameUI.Arrows:GetPropertyChangedSignal("Visible"):Connect(function()
	if GameUI.Arrows.Visible == false then
		ManiaComboCounter.Visible = false
		KateEngine.Topbar.OriginTime = 0;
		KateEngine.Topbar.SongDifficulty = 0;
		KateEngine.Health.Current = 40;
		KateEngine.InSolo = false;
		KateEngine.Mania.Comboombo = 0;
		KateEngine.Mania.TotalNotes = 0;
	else
		if KateEngine.InSolo then
			KateEngine.Health.Current = 40;
			Healthbar.Visible = KateEngine.Settings.Healthbar;
			UpdateHealth();
		else
			Healthbar.Visible = false;
		end
	end
end)


GameUI.TopbarLabel:GetPropertyChangedSignal("Text"):Connect(function()
	local newtxt = GameUI.TopbarLabel.Text;
	Topbar.Text = newtxt
	local txttable = string.split(newtxt,"\n")
	if txttable[3] then
		local tim = string.split(txttable[3],":");
		local seconds = tonumber(tim[1])*60 + tonumber(tim[2])
		if KateEngine.Topbar.OriginTime == 0 then
			KateEngine.Topbar.OriginTime = seconds
            KateEngine.Topbar.SongDifficulty = CalcDifficultyRating(seconds);
		end

        newtxt = newtxt.." | [⭐ "..KateEngine.Topbar.SongDifficulty.."]"

		local function handler()
			local m = math.floor((seconds/KateEngine.Topbar.OriginTime)*75)
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

		Topbar.Text = newtxt.."\n["..handler().."]"
	end
end)

Framework.Settings.MissedSound.Value = false;

GameUI.TopbarLabel:GetPropertyChangedSignal("TextColor3"):Connect(function()
    Topbar.TextColor3 = GameUI.TopbarLabel.TextColor3
end)

GameUI.TopbarLabel:GetPropertyChangedSignal("Visible"):Connect(function()
	GameUI.TopbarLabel.Visible = false;  
end)

local newloc = GameUI.SongSelector.Frame.Start
newloc.Toggle.Visible = false;
newloc = newloc.Start
local buttontemplate = newloc.StartButton;

buttontemplate.MouseButton1Click:Connect(function()
	SendPlay("normal");
end)

-- Stats UI clone
local statgui = GameUI.Arrows.Stats:Clone()
statgui.RichText = true; -- Force rich text on the stats
statgui.Parent = GameUI.Arrows

GameUI.Arrows.Stats:GetPropertyChangedSignal("Visible"):Connect(function()
	if GameUI.Arrows.Stats.Visible then
		GameUI.Arrows.Stats.Visible = false;
	end
end)

GameUI.Arrows.Stats:GetPropertyChangedSignal("Text"):Connect(function() -- This function should show any 'shadow' stats
	GameUI.Arrows.Stats.Visible = false;
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

	statgui.Text = "Sick: "..stats.sick.."\nGood: "..stats.good.."\nOk: "..stats.ok.."\nBad: "..stats.bad.."\nMissed: "..stats.missed

	if res ~= KateEngine.Mania.TotalNotes then
		statgui.Text = "Sick: "..stats.sick.."\nGood: "..stats.good.."\nOk: "..stats.ok.."\nBad: "..stats.bad .. " <font color='#AAAAAA'>(+"..KateEngine.Mania.TotalNotes - res..")</font>".."\nMissed: "..stats.missed
		showtotalnotes = true;
	end
	if showtotalnotes then
		statgui.Text = statgui.Text.."\n<font color='#FFFF77'>Total Notes: "..KateEngine.Mania.TotalNotes.."</font>"
	end
end)

local Camera = workspace.Camera;
local FOV = Camera.FieldOfView;

local id = 0;
local connectedevent = nil;
local CurrentStep = 0;
local CurrentBeat = 0;
local CurrentSection = 0;

local debugtext = "";

local SceneLoaded = Framework:GetEvent("SceneLoaded"); -- This is the event that gets fired when a scene is loaded; @param {string? = scenename, folder? = sceneinstance | nil = scene unloading}
local SoundEvent = Framework:GetEvent("SoundEvent"); -- This is the event that gets fired when a song starts or ends; @param {boolean = songstarted/songended}
local NoteMiss = Framework:GetEvent("NoteMissed"); -- This is the event that gets fired when a note is missed, used for modcharts; 
local NoteHit = Framework:GetEvent("NoteHitBegan"); -- NoteHitEnded is also available, but we need the NoteHit part because it contains the ms; @param: {table {HitAccuracy:number<0-100>, MS:float?, Note:table {NoteData}, HitTime:float<tick()>}, table {?}}

ModchartSystem = {
	-- Camera zooming thing
	CameraZoom = function()
		-- Tween the camera
		local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		Camera.FieldOfView = FOV;
		local camtween = TweenService:Create(Camera, tweenInfo, {FieldOfView = FOV+1});
		ManiaRating.TextSize = 35;
		local txttween = TweenService:Create(ManiaRating, tweenInfo, {TextSize = 30});
		LyricsLabel.TextSize = 45;
		local txttween2 = TweenService:Create(LyricsLabel, tweenInfo, {TextSize = 35});
		camtween:Play();
		txttween:Play();
		task.spawn(function()
			camtween.Completed:Wait();
			camtween:Destroy();
			txttween:Destroy();
			txttween2:Destroy();
		end);
	end;

	SetArrowStyle = function(Key, Style)
		Framework.ArrowData["4Key"].Arrows[Key].Style = Style;
		Framework:GetEvent("ArrowDataChanged"):Fire();
	end;

	SetAllArrows = function(Style)
		for _,v in pairs(Framework.ArrowData["4Key"].Arrows) do
			v.Style = Style;
		end;
		Framework:GetEvent("ArrowDataChanged"):Fire();
	end;

	SaveArrowsStyle = function()
		local Arrows = {};
		for i,v in pairs(Framework.ArrowData["4Key"].Arrows) do
			Arrows[i] = v.Style;
		end
		Framework:SetKEValue("SavedArrowsStyle", Arrows);
	end;

	LoadArrowsStyle = function()
		local Arrows = Framework:GetKEValue("SavedArrowsStyle");
		for i,v in pairs(Arrows) do
			Framework.ArrowData["4Key"].Arrows[i].Style = v;
		end
		Framework:GetEvent("ArrowDataChanged"):Fire();
	end;

	SetLyrics = function(Text)
		if Text == "" then
			LyricsLabel.Text = "";
			LyricsLabel.Visible = false;
			return;
		end
		LyricsLabel.Text = Text;
		LyricsLabel.Visible = true;
	end;

	Sprite = function(SpriteID, Position, Size, ZIndex, AnchorPoint)
		local Sprite = Instance.new("ImageLabel");
		Sprite.Image = SpriteID;
		Sprite.BackgroundTransparency = 1;
		Sprite.Size = Size or UDim2.new(0, 100, 0, 100);
		Sprite.Position = Position or UDim2.new(0.5, 0, 0.5, 0);
		Sprite.ZIndex = ZIndex or 1;
		Sprite.Parent = GameUI;
		Sprite.AnchorPoint = AnchorPoint or Vector2.new(0.5, 0.5);
		table.insert(KateEngine.Assets, Sprite);
		return Sprite;
	end;

	Sound = function(SoundID, Volume, Pitch)
		if not SoundID then return end
		local Sound = Instance.new("Sound");
		Sound.SoundId = SoundID;
		Sound.Volume = Volume or 1;
		Sound.Pitch = Pitch or 1;
		Sound.Parent = GameUI;
		table.insert(KateEngine.Assets, Sound);
		Sound:Play();
		task.spawn(function()
			Sound.Ended:Wait();
			Sound:Destroy();
		end);
		return Sound;
	end;

	IncrementHealth = function(Amount)
		KateEngine.Health.Current += Amount;
		UpdateHealth();
	end;

	DecrementHealth = function(Amount)
		KateEngine.Health.Current -= Amount;
		UpdateHealth();
	end;

	SetHealth = function(Amount)
		KateEngine.Health.Current = Amount;
		UpdateHealth();
	end;
};

KateEngine.Modcharter = ModchartSystem;
Modcharts = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/beta/modcharts.lua",true))()

SceneLoaded:Connect(function(SceneID, Scene)
	--@param {string? = scenename, folder? = sceneinstance | nil = scene unloading}
	if not SceneID then
		-- Scene is unloading
		-- Do stuff here
		-- Like disconnecting events
		Framework:SetKEValue("SceneID", nil);
		Framework:SetKEValue("SceneInstance", nil);
		return;
	end

	-- Scene is loaded; Set KE values
	Framework:SetKEValue("SceneID", SceneID);
	Framework:SetKEValue("SceneInstance", Scene);

	-- Can't do anything with modcharts due to the fact that the song hasn't started yet, hence no songID can be grabbed!
	-- If the modcharters want to do something with the scene, they could theoretically use the SongStart event and use the KE values above to do the stuff they want to do.
end);

NoteHit:Connect(function(NoteHitData, Note)
	-- @param: {table {HitAccuracy:number<0-100>, MS:float?, Note:NoteData, HitTime:float<tick()>}, table {?}}
	-- NoteHitData.HitAccuracy is the accuracy of the note hit
	-- NoteHitData.MS is the ms of the note hit
	-- NoteHitData.HitTime is the tick() of the note hit

	local Modchart = Framework:GetKEValue("CurrentModchart")
	
	if Modchart and Modchart.NoteHit then
		Modchart.NoteHit(NoteHitData); -- Send the raw data to the modchart so the modcharter has full control over the note hit
	end;

	-- Example of how to use the data
	if Note and Note.NoteDataConfigs and Note.NoteDataConfigs.Type == "Poison" then
		-- This only affects the player if they are in solo anyways.
		ModchartSystem.DecrementHealth(20);
	end;
end);

NoteMiss:Connect(function(v1, v2)
	-- @param: {Unknown; Returns 2 tables?}

	local Modchart = Framework:GetKEValue("CurrentModchart")
	
	if Modchart and Modchart.NoteMiss then
		Modchart.NoteMiss(v1, v2);
	end
end);

SoundEvent:Connect(function(Active)
	if Active == false then
		if connectedevent then -- Avoid an error (💀)
			connectedevent:Disconnect();
			connectedevent = nil;
		end;
		ModchartSystem.SetLyrics(""); -- Clear out the lyrics (how did i miss that)
		Framework:SetKEValue("CurrentModchart", nil);
		ModchartSystem.LoadArrowsStyle(); -- Return the arrows to their original style
	end
	id = id + 1;
	local assigned = id;
	local songstart = os.clock();
	if Active == true then
		ModchartSystem.SaveArrowsStyle();
		local defaultbumping = true;
		local songmodchart = nil;
		local songid = Framework.SongPlayer.CurrentlyPlaying and Framework.SongPlayer.CurrentlyPlaying.SoundId:gsub("rbxassetid://","");
		-- Should come out as just the ID number of the song
		-- Like this; rbxassetid://12345 => 12345

		Framework:SetKEValue("SongID", songid);
		print("SongID: "..songid)

		-- Check if the song has a modchart
		if Modcharts and Modcharts[songid] then
			if Modcharts[songid].DisableDefault then
				defaultbumping = false;
			end

			if Modcharts[songid].Variables then
				for i,v in pairs(Modcharts[songid].Variables) do
					Framework:SetKEValue(i, v);
				end
			end

			if Modcharts[songid].SongStart then
				Modcharts[songid].SongStart(Framework);
			end

			Framework:SetKEValue("CurrentModchart", Modcharts[songid]);
			songmodchart = Modcharts[songid];
		end;

		local Zone = Framework.StageZone and Framework.StageZone.CurrentZone;
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
					if id ~= assigned or not KateEngine.Settings.Modcharts then
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
							songmodchart.OnStep(Framework, CurrentStep-1);
						end

						if songmodchart and songmodchart.Lyrics and songmodchart.Lyrics[CurrentStep-1] then
							ModchartSystem.SetLyrics(songmodchart.Lyrics[CurrentStep-1]);
						end
					else
						debugtext = "BPM: "..BPM.."\nStep: "..(CurrentStep-1).."\nBeat: "..(CurrentBeat-1).."\nSection: "..CurrentSection.."\nSongID: "..songid;
						BPMSheet.Text = debugtext;
						return;
					end;

					if CurrentStep % 4 == 2 then -- Every 4 steps is a beat
						CurrentBeat = CurrentBeat + 1;
						if songmodchart and songmodchart.OnBeat then
							songmodchart.OnBeat(Framework, CurrentBeat);
						end
					else
						debugtext = "BPM: "..BPM.."\nStep: "..(CurrentStep-1).."\nBeat: "..(CurrentBeat-1).."\nSection: "..CurrentSection.."\nSongID: "..songid;
						BPMSheet.Text = debugtext;
						return;
					end;

					-- Every 4 beats is a section
					if CurrentBeat % 4 == 2 then
						CurrentSection = CurrentSection + 1;
						if defaultbumping then
							ModchartSystem.CameraZoom();
						end
						if songmodchart and songmodchart.OnSection then
							songmodchart.OnSection(Framework, CurrentSection);
						end;
					end;

					debugtext = "BPM: "..BPM.."\nStep: "..(CurrentStep-1).."\nBeat: "..(CurrentBeat-1).."\nSection: "..CurrentSection.."\nSongID: "..songid;
					BPMSheet.Text = debugtext;
				end);
			else
				-- There was no BPM set for the stage?
				task.spawn(function()
					ModchartSystem.SetLyrics("<font color='#ff3333'>No BPM was set for this song!</font>");
					task.wait(3);
					ModchartSystem.SetLyrics("");
				end);
			end;
		end;
	end;
end);

return Framework;
