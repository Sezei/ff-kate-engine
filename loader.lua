--sadly despite the rewrite and the rebranding we still have to keep KE as everything for backwards compatibility
--womp womp

--bloxstrap support
Bloxstrap = {
	SendMessage = function(command, data)
		local json = game:GetService('HttpService'):JSONEncode({
			command = command, 
			data = data
		});
		
		print("[BloxstrapRPC] " .. json)
	end;

	SetRichPresence = function(data)
		if data.timeStart ~= nil then
			data.timeStart = math.round(data.timeStart)
		end
		
		if data.timeEnd ~= nil then
			data.timeEnd = math.round(data.timeEnd)
		end
		
		Bloxstrap.SendMessage("SetRichPresence", data)
	end;
};

-- why did i even need to include this 💀
if game.PlaceId ~= 6447798030 and game.PlaceId ~= 6996694685 then
	return error("No!")
end

-- Check which functions are missing in order to know what to expect from the client
local missing = {};

if not getgc then -- This one is required for the script to work, as it hooks into the Framework.
	return error("Your exploit is not supported by this script; Missing function getgc().")
end;

if not writefile or not readfile or not isfile or not isfolder or not makefolder then
	return error("Your exploit is not supported by this script; Missing fs functions which are required by v0.11b+.")
end;

if not setclipboard then
	missing["clipboard"] = true;
end;

if not (type(syn) == 'table' and syn.set_thread_identity) or setidentity or setthreadcontext then
	missing["setidentity"] = true;
end;

-- 💀
if not isfolder("KateEngine") then
	makefolder("KateEngine");
end;

-- Check if this is the first time the script is being executed; Doable by checking if a file exists.
if not isfile("KateEngine/Accepted.txt") then
	-- Create a GUI to accept the terms of use.
	local screenGui = Instance.new("ScreenGui")

	local canvasGroup = Instance.new("CanvasGroup")
	canvasGroup.AnchorPoint = Vector2.new(0.5, 1.5)
	canvasGroup.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
	canvasGroup.Position = UDim2.fromScale(0.5, 0.5)
	canvasGroup.Size = UDim2.fromScale(0.25, 0.325)

	local frame = Instance.new("Frame")
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	frame.BorderSizePixel = 0
	frame.Position = UDim2.fromScale(0.5, 0)
	frame.Size = UDim2.new(1, 0, 0, 30)

	local textLabel = Instance.new("TextLabel")
	textLabel.FontFace = Font.new("rbxasset://fonts/families/PermanentMarker.json")
	textLabel.Text = "Kate Engine - Warning"
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextSize = 22
	textLabel.AnchorPoint = Vector2.new(0.5, 0)
	textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.BackgroundTransparency = 1
	textLabel.Position = UDim2.fromScale(0.5, 0)
	textLabel.Size = UDim2.new(0, 200, 1, 0)

	local uIStroke = Instance.new("UIStroke")
	uIStroke.Thickness = 1.5
	uIStroke.Parent = textLabel

	textLabel.Parent = frame

	frame.Parent = canvasGroup

	local uICorner = Instance.new("UICorner")
	uICorner.Parent = canvasGroup

	local textLabel1 = Instance.new("TextLabel")
	textLabel1.FontFace = Font.new("rbxasset://fonts/families/PermanentMarker.json")
	textLabel1.Text = "By using Funkify, you agree that any actions you do with it are your own, meaning it is your own responsibility. All FF(ify) contributors are not responsible to whatever happens when you use this.\n\n(also pls no use for cheats ty)"
	textLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel1.TextSize = 22
	textLabel1.TextStrokeTransparency = 0
	textLabel1.TextWrapped = true
	textLabel1.AnchorPoint = Vector2.new(0.5, 0)
	textLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel1.BackgroundTransparency = 1
	textLabel1.Position = UDim2.new(0.5, 0, 0, 40)
	textLabel1.Size = UDim2.new(0.9, 0, 1, -70)
	textLabel1.Parent = canvasGroup

	local agree = Instance.new("TextButton")
	agree.FontFace = Font.new("rbxasset://fonts/families/PermanentMarker.json")
	agree.Text = "Agree"
	agree.TextColor3 = Color3.fromRGB(255, 255, 255)
	agree.TextSize = 18
	agree.TextStrokeTransparency = 0
	agree.AnchorPoint = Vector2.new(0, 1)
	agree.BackgroundColor3 = Color3.fromRGB(144, 144, 144)
	agree.BorderSizePixel = 0
	agree.Position = UDim2.fromScale(0, 1)
	agree.Size = UDim2.new(0.6, 0, 0, 30)
	agree.Parent = canvasGroup

	local decline = Instance.new("TextButton")
	decline.FontFace = Font.new("rbxasset://fonts/families/PermanentMarker.json")
	decline.Text = "Disagree and Unload"
	decline.TextColor3 = Color3.fromRGB(255, 255, 255)
	decline.TextSize = 18
	decline.TextStrokeTransparency = 0
	decline.AnchorPoint = Vector2.new(1, 1)
	decline.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
	decline.BorderSizePixel = 0
	decline.Position = UDim2.fromScale(1, 1)
	decline.Size = UDim2.new(0.4, 0, 0, 30)
	decline.Parent = canvasGroup

	canvasGroup.Parent = screenGui

	screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui");

	game:GetService("TweenService"):Create(canvasGroup, TweenInfo.new(0.5), {Position = UDim2.fromScale(0.5, 0.5)}):Play()

	local choice = nil

	agree.MouseButton1Click:Connect(function()
		choice = true
	end)

	decline.MouseButton1Click:Connect(function()
		choice = false
	end)

	-- Wait until the user makes a choice.
	repeat
		task.wait();
	until type(choice) == "boolean";

	game:GetService("TweenService"):Create(canvasGroup, TweenInfo.new(0.5), {Position = UDim2.fromScale(0.5, 1.5)}):Play()

	-- If the user chose to decline, unload the script.
	if not choice then
		task.wait(0.5);
		screenGui:Destroy()
		return -- Unloads the script
	end

	-- If the user chose to agree, continue.
	screenGui:Destroy()

	-- Add the file so the UI won't show up again.
	writefile("KateEngine/Accepted.txt", "true");
end;

local Version = "v0.13a";

-- Function to get the Framework
function getGameFramework()
	for _, v in next, getgc(true) do
		if type(v) == 'table' and rawget(v, 'GameUI') then
			return v
		end
	end
end

function getNetworking()
	for _, v in next, getgc(true) do
		if type(v) == 'table' and (type(rawget(v, 'Client')) == 'table' or type(rawget(v, 'Server')) == 'table') and rawget(v, "Broadcast") then
			return v
		end
	end
end;

local ColorJSON = {
	Encode = function(Color)
		if typeof(Color) == "Color3" then
			return string.format("%s,%s,%s", Color.r, Color.g, Color.b);
		end;
	end;
	Decode = function(Color)
		if typeof(Color) == "Color3" then
			-- It's already a color, so just return it.
			return Color;
		elseif typeof(Color) == "string" then
			local RGB = string.split(Color, ",");
			return Color3.new(RGB[1], RGB[2], RGB[3]);
		end;
	end;
};

local funkything = Instance.new("ScreenGui");
funkything.Name = "loadinggui";
funkything.Parent = game.CoreGui;

local load = Instance.new("Frame");
load.Name = "loading";
load.Parent = funkything;
load.BackgroundColor3 = Color3.fromRGB(0,0,0);
load.BackgroundTransparency = 0.5;
load.BorderSizePixel = 0;
load.Position = UDim2.new(0.5, 0, 1, -50);
load.Size = UDim2.new(0.2, 0, 0, 30);
load.AnchorPoint = Vector2.new(0.5, 1);

local stroke = Instance.new("UIStroke");
stroke.Name = "stroke";
stroke.Parent = load;
stroke.Color = Color3.fromRGB(0,0,0);
stroke.Thickness = 2;
stroke.Transparency = 0.5;

local loadtext = Instance.new("TextLabel");
loadtext.Name = "loadingtext";
loadtext.Parent = load;
loadtext.BackgroundColor3 = Color3.fromRGB(0,0,0);
loadtext.BackgroundTransparency = 1;
loadtext.BorderSizePixel = 0;
loadtext.Position = UDim2.fromScale(0.5, 0.5);
loadtext.Size = UDim2.fromScale(1, 1);
loadtext.AnchorPoint = Vector2.new(0.5, 0.5);
loadtext.Text = "-";
loadtext.TextColor3 = Color3.fromRGB(170,170,170);
loadtext.TextSize = 24;
loadtext.TextStrokeTransparency = 0.5;
loadtext.Font = Enum.Font.PermanentMarker;
loadtext.ZIndex = 2; -- Above the loading bar

local loadbar = Instance.new("Frame");
loadbar.Name = "loadingbar";
loadbar.Parent = load;
loadbar.BackgroundColor3 = Color3.fromRGB(255,255,255);
loadbar.BackgroundTransparency = 0;
loadbar.BorderSizePixel = 0;
loadbar.Position = UDim2.fromScale(0, 0);
loadbar.Size = UDim2.fromScale(0, 1);
loadbar.AnchorPoint = Vector2.new(0, 0);

local LocalPlayer = game:GetService("Players").LocalPlayer;
local LoadAsset = getsynasset or getcustomasset;
local FetchAsset = function(Asset)
	if isfolder('KateEngine/Assets') and isfile('KateEngine/Assets/'..Asset) then
		return LoadAsset('KateEngine/Assets/'..Asset);
	else
		if not isfolder('KateEngine/Assets') then
			makefolder('KateEngine/Assets');
		end
		writefile('KateEngine/Assets/'..Asset,game:HttpGet("https://github.com/Sezei/ff-kate-engine/blob/main/modchart_material/"..Asset.."?raw=true"));
		return LoadAsset('KateEngine/Assets/'..Asset);
	end
end;

local PreRequisites = {
	"KF_warning.png";
	"lse_maniaDW.png";
	"lse_maniaGS.png";
	"mania_defaultgray.png";
	"mania_defaultalt.png";
	"metalpipe.mp3";
	"pop_up.mp3";
	"Meow.mp3";
	"woeM.mp3";
	"popup1.png";
	"popup2.png";
	"popup3.png";
	"popup4.png";
	"popup5.png";
	"popup6.png";
	"popup7.png";
	"popup8.png";
	"popup9.png";
	"popup10.png";
	"popup11.png";
	"fkc_eye1.png";
	"fkc_eye2.png";
	"fkc_eye3.png";
	"fkc_eye4.png";
	"fkc_eyeidle1.png";
	"fkc_eyeidle2.png";
	"fkc_eyeidle3.png";
	"fkc_eyeidle4.png";
	"funkify_1.png";
};

for k,v in pairs(PreRequisites) do
	loadtext.Text = "Loading Asset: "..v.." ("..k.."/"..#PreRequisites..")";
	loadbar.Size = UDim2.fromScale(k/#PreRequisites, 1);
	FetchAsset(v);
end;

loadtext.Text = "Taking your sweet time...";

local Framework = getGameFramework();

-- Create the KateEngine table
KateEngine = {
	-- Base Info
	Version = Version;
	Cache = {};
	InSolo = false;
	Network = getNetworking();

	DefaultStrings = {
		ScoreL = "Score: <Score>";
		ScoreR = "Score: <Score>";
		Accuracy = "Accuracy: <Accuracy>";
		Misses = "Misses: <Misses>";
		Combo = "Combo: <Combo>";
		FullCombo = "Full Combo (<Combo>)";
	};

	Strings = {
		ScoreL = "Score: <Score>";
		ScoreR = "Score: <Score>";
		Accuracy = "Accuracy: <Accuracy>";
		Misses = "Misses: <Misses>";
		Combo = "Combo: <Combo>";
		FullCombo = "Full Combo (<Combo>)";
	};

	Song = {
		Id = 0;
		BPM = 0;
		Clock = 0;
		Step = 0;
		Beat = 0;
		Section = 0;
		Instance = nil; -- The audio instance the song uses.
	};

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
		Perfects = 0;
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
				Text = "Debug Visible";
				Key = "DebugVisible";

				Callback = function(Value)
					Framework.KateEngine.Assets.Watermark.BPMSheet.Visible = Value;
				end;

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
			{
				Requirement = "clipboard";
				Type = "Button";
				Text = "Copy Discord Invite";
				Callback = function()
					setclipboard("https://discord.gg/S5azXERwF7");
				end;
			};
			{
				Type = "Button";
				Text = "Export Chart";
				Callback = function()
					-- Get the chart
					local Chart = Framework.KateEngine.Cache["CurrentChart"];

					-- Attempt to turn the chart into JSON
					local Success, JSON = pcall(game:GetService("HttpService").JSONEncode, game:GetService("HttpService"), Chart);

					if Success then
						if not isfolder("KateEngine/Exported_Charts") then
							makefolder("KateEngine/Exported_Charts");
						end;

						writefile("KateEngine/Exported_Charts/" .. Framework:GetKEValue("SongID") .. ".json", JSON);
					end
				end;
			};
			{
				Type = "Button";
				Text = "Force Save Settings";
				Callback = function()
					writefile("KateEngine/config.png", game:GetService("HttpService"):JSONEncode(KateEngine.Settings));
				end;
			};
			{
				Requirement = "custom modchart";
				Type = "Button";
				Text = "Reload Modcharts";
				Callback = function()
					KateEngine.ReloadModcharts();
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
				Text = "This section contains settings for the Mania Improvements and the Combo Counter.";
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
			{
				Type = "Label";
				Text = "-- JUDGEMENT OVERLAY --";
			};
			{
				Type = "Label";
				Text = "Judgement overlays are displaying an overlay when you hit a note, depending on the rating.";
			};
			{
				Type = "Boolean";
				Default = false;
				Text = "Show Judgement Overlays [EXPERIMENTAL]";
				Key = "Mania_JudgementOverlays";

				Stored = true;
			};
			{
				Type = "Boolean";
				Default = true; -- Less annoyance for the players (deserved tbh)
				Text = "Non-Sick Overlays Only";
				Key = "Mania_NonPerfectOverlays";

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
				Text = "This section contains settings for the bot opponent.";
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
			{
				Type = "Label";
				Text = "Player Icon";
			};
			{
				Type = "TextField";
				Default = "rbxassetid://6605178204";
				Text = "Player Icon";
				Key = "Healthbar_IconPlayer";

				Callback = function(Value)
					KateEngine.Assets.Healthbar.Front.IconP2.Image = Value;
				end;

				Stored = true;
			};
			{
				Type = "TextField";
				Default = "";
				Text = "Losing Icon";
				Key = "Healthbar_IconPlayerLosing";

				Stored = true;
			};
			{
				Type = "TextField";
				Default = "";
				Text = "Winning Icon";
				Key = "Healthbar_IconPlayerWinning";

				Stored = true;
			};
			{
				Type = "Label";
				Text = "Opponent Icon";
			};
			{
				Type = "TextField";
				Default = "rbxassetid://8846704715";
				Text = "Opponent Icon";
				Key = "Healthbar_IconOpponent";

				Callback = function(Value)
					KateEngine.Assets.Healthbar.Front.IconP1.Image = Value;
				end;

				Stored = true;
			};
			{
				Type = "TextField";
				Default = "";
				Text = "Losing Icon";
				Key = "Healthbar_IconOpponentLosing";

				Stored = true;
			};
			{
				Type = "TextField";
				Default = "";
				Text = "Winning Icon";
				Key = "Healthbar_IconOpponentWinning";

				Stored = true;
			};
			{
				Type = "Label";
				Text = "-- CAMERA --"
			};
			{
				Type = "Label";
				Text = "This section contains settings that can be used to manipulate the camera."
			};
			{
				Type = "Boolean";
				Default = true;
				Text = "Camera Manipulation";
				Key = "CamManipulation";

				Stored = true;
			};
			{
				Type = "Slider";
				Default = 5;
				Text = "Camera Displacement";
				Key = "CamDisplace";
				Minimum = 1;
				Maximum = 30;

				Stored = true;
			};
		};

		["Cosmetic"] = {
			{
				Type = "Label";
				Text = "-- PERFECT RATING --";
			};
			{
				Type = "Label";
				Text = "This section contains settings for the custom perfect rating.";
			};
			{
				Type = "Boolean";
				Default = true;
				Text = "Enabled";
				Key = "PerfectRating";

				Stored = true;
			};
			{
				Type = "Slider";
				Default = 1;
				Text = "Perfect Timeframe (ms)";
				Key = "PerfectTimeframe";
				Minimum = 1;
				Maximum = 20;

				Stored = true;
			};
			{
				Type = "Label";
				Text = "-- MISCELLANEOUS --";
			};
			{
				Type = "Label";
				Text = "Other settings that do not affect gameplay";
			};
			{
				Type = "Multichoice";
				Default = "None";
				Text = "Death Effect";
				Key = "DeathEffect";
				Options = {
					"None";
					"Explosion";
					"Burn";
					"Pipe";
				};

				Stored = true;
			};
            {
                Type = "Boolean";
                Default = true;
                Text = "Miss Highlight";
                Key = "MissHighlight";

                Stored = true;
            };
		};

		["Modcharting"] = {
			{
				Type = "Label";
				Text = "-- MODCHARTING --";
			};
			{
				Type = "Label";
				Text = "This section contains settings for modcharting.";
			};
			{
				Type = "Boolean";
				Default = true;
				Text = "Modcharting Enabled";
				Key = "Modcharts";

				Stored = true;
			};
			{
				Type = "Boolean";
				Default = true;
				Text = "Allow Shitpost Charts";
				Key = "Modcharts_AllowShitposts";

				Stored = true;
			};
			{
				Type = "Slider";
				Default = 5;
				Text = "Default Camera Zoom Strength (x0.2)";
				Key = "Modcharts_CameraStrength";
				Minimum = 0;
				Maximum = 10;

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
				Text = "Contributors:";
			};
			{
				Type = "Label";
				Text = "<font color=\"#ff1a70\">Sezei</font>";
			};
			{
				Type = "Label";
				Text = "<font color=\"#11a7b8\">Aaron</font>";
			};
			{
				Type = "Label";
				Text = "Resources Used:";
			};
			{
				Type = "Label";
				Text = "<font color=\"#00ff00\">Wally</font> / <font color=\"#00ff00\">Bigtimbob</font> - Framework Detection";
			};
			{
				Type = "Label";
				Text = "<font color=\"#ff7700\">Kinlei</font>(?) - UI Library (MaterialUI)";
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
	Assets = {
		-- UIKey = Instance (Element)
	};

	CameraBinds = {
		--UIKey = {
		--	Strength = Number; -> How 'strongly' is it binded to the camera movement: How much the element will move against the camera movement to 'stay in place';
		--  Self = Instance; -> The element itself;
		--}
	};
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

function Format(Original,ReplacementData)
	local s:string = tostring(Original);

	for old,new in pairs(ReplacementData) do
		s = s:gsub("<"..old..">",tostring(new));
	end

	return s;
end

-- Services and Variables
local LoadStartTime = tick();
local HttpService = game:GetService("HttpService");
local TweenService = game:GetService("TweenService");
local UIS = game:GetService("UserInputService");

-- Game Stuff
local GameUI = LocalPlayer.PlayerGui:FindFirstChild("GameUI");
local IngameUI = GameUI:FindFirstChild("Screen");
local PromptUI = GameUI:FindFirstChild("Windows");
local RemoteEvent = game.ReplicatedStorage.RE;

-- Material UI (Used for the menu)
local material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/unstable/UIFramework.lua",true))().Load({Style = 1;Title = "Kate Engine "..Version;Theme = "Dark";SizeX = 550;})
material.Self.Enabled = false;

-- Build the UI
-- Mania Combo Counter
local ManiaComboCounter = Instance.new("TextLabel");
ManiaComboCounter.AnchorPoint = Vector2.new(0.5, 0.5);
ManiaComboCounter.Position = UDim2.fromScale(0.5, 0.5);
ManiaComboCounter.Parent = IngameUI;
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

-- Mania-Like Judgement Overlay (For some reason modern rhythm games use this, so I added it as well ig lol)
local ManiaJudgementOverlay = Instance.new("ImageLabel");
ManiaJudgementOverlay.Position = UDim2.new(0, 0, 0, -40);
ManiaJudgementOverlay.Size = UDim2.new(1, 0, 1, 40);
ManiaJudgementOverlay.Parent = IngameUI;
ManiaJudgementOverlay.BackgroundTransparency = 1;
ManiaJudgementOverlay.Image = "rbxassetid://12395330181";
ManiaJudgementOverlay.Visible = false;
ManiaJudgementOverlay.Name = "KE_ManiaJudgementOverlay";
ManiaJudgementOverlay.ImageColor3 = Color3.fromRGB(255, 255, 255);
ManiaJudgementOverlay.ImageTransparency = 1;
ManiaJudgementOverlay.ScaleType = Enum.ScaleType.Slice;
ManiaJudgementOverlay.SliceCenter = Rect.new(4, 4, 96, 96);
ManiaJudgementOverlay.SliceScale = 1.5;
KateEngine.Assets.ManiaJudgementOverlay = ManiaJudgementOverlay;

-- Lyrics UI
local LyricsLabel = Instance.new("TextLabel");
LyricsLabel.AnchorPoint = Vector2.new(0.5, 0.75);
LyricsLabel.Position = UDim2.fromScale(0.5, 0.75);
LyricsLabel.Parent = IngameUI.Arrows;
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
local Watermark = Instance.new("ImageButton");
Watermark.Name = "KE_Watermark";
Watermark.Image = FetchAsset("funkify_1.png"); --todo: update with Funkify's new watermark
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
--[[
local Topbar = GameUI.TopbarLabel:Clone();
Topbar.Parent = IngameUI.Arrows;
Topbar.Visible = true;
Topbar.Name = "KE_Topbar";
]]

local Topbar = Instance.new("Frame");
Topbar.BackgroundColor3 = Color3.fromRGB(27,27,27);
Topbar.BorderSizePixel = 0;
Topbar.Size = UDim2.new(0.3,0,0,25);
Topbar.Position = UDim2.new(0.5,0,0,-10);
Topbar.AnchorPoint = Vector2.new(0.5,0);
Topbar.Name = "KE_Topbar";
Topbar.Parent = IngameUI.Arrows;

local TopbarPadding = Instance.new("UIPadding");
TopbarPadding.PaddingLeft = UDim.new(0,5);
TopbarPadding.PaddingRight = UDim.new(0,5);
TopbarPadding.PaddingTop = UDim.new(0,5);
TopbarPadding.PaddingBottom = UDim.new(0,5);
TopbarPadding.Parent = Topbar;

local TopbarProgress = Instance.new("Frame");
TopbarProgress.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
TopbarProgress.BorderSizePixel = 0;
TopbarProgress.Size = UDim2.new(0,0,1,0);
TopbarProgress.Name = "Progress";
TopbarProgress.Parent = Topbar;

local TopbarLabel = Instance.new("TextLabel");
TopbarLabel.BackgroundTransparency = 1;
TopbarLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
TopbarLabel.Size = UDim2.new(1,0,1,0);
TopbarLabel.TextSize = 16;
TopbarLabel.Text = "-";
TopbarLabel.RichText = true;
TopbarLabel.Font = Enum.Font.PermanentMarker;
TopbarLabel.Name = "Label";
TopbarLabel.TextStrokeTransparency = 0;
TopbarLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0);
TopbarLabel.Parent = Topbar;

KateEngine.Assets.Topbar = Topbar;

local Healthbar = Instance.new("Frame");
Healthbar.Visible = true;
Healthbar.Parent = IngameUI.Arrows;
Healthbar.AnchorPoint = Vector2.new(0.5,1);
Healthbar.Position = UDim2.new(0.5,0,1,-75);
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
HBFront.Size = UDim2.fromScale(0.4,1);
HBFront.Position = UDim2.fromScale(1,0.5);
HBFront.BackgroundColor3 = Color3.new(0,1,0);
HBFront.ZIndex = 2;
HBFront.Name = "Front";

-- Create 2 icons attached to the healthbar; Player1 is attached to the left, Player2 is attached to the right;
-- The icons will be attached to the missing health, meaning if a player gains health, the icon will move to the right along with the healthbar
-- The offset is 15 pixels away from the healthbar
local IconP1 = Instance.new("ImageLabel");
IconP1.Name = "IconP1";
IconP1.Image = "rbxassetid://6605178204"; -- Todo: Create icons for the healthbars
IconP1.BackgroundTransparency = 1;
IconP1.Size = UDim2.fromOffset(100,100);
IconP1.Parent = HBFront;
-- Attach the icon to the left side of the front healthbar
IconP1.AnchorPoint = Vector2.new(0.75,0.5);
IconP1.Position = UDim2.new(0, -25, 0.5, 0);

local IconP2 = IconP1:Clone();
IconP2.Name = "IconP2";
IconP2.Parent = HBFront;
IconP2.Image = "rbxassetid://8846704715";
-- Attach the icon to the right side of the front healthbar
IconP2.AnchorPoint = Vector2.new(0.25,0.5);
IconP2.Position = UDim2.new(0, 25, 0.5, 0);
IconP2.ImageRectOffset = Vector2.new(1024,0);
IconP2.ImageRectSize = Vector2.new(-1024,1024);

local function IconCheck(side)
	-- Check which side the player is on
	if side == "Left" then -- Player is on side 1
		IconP1.AnchorPoint = Vector2.new(0.25,0.5);
		IconP1.Position = UDim2.new(1, 25, 0.5, 0);
		IconP1.ImageRectOffset = Vector2.new(1024,0);
		IconP1.ImageRectSize = Vector2.new(-1024,1024);

		IconP2.AnchorPoint = Vector2.new(0.75,0.5);
		IconP2.Position = UDim2.new(1, -25, 0.5, 0);
		IconP2.ImageRectOffset = Vector2.new(0,0);
		IconP2.ImageRectSize = Vector2.new(0,0);
	elseif side == "Right" then -- Player is on side 2
		IconP1.AnchorPoint = Vector2.new(0.75,0.5);
		IconP1.Position = UDim2.new(0, -25, 0.5, 0);
		IconP1.ImageRectOffset = Vector2.new(0,0);
		IconP1.ImageRectSize = Vector2.new(0,0);

		IconP2.AnchorPoint = Vector2.new(0.25,0.5);
		IconP2.Position = UDim2.new(0, 25, 0.5, 0);
		IconP2.ImageRectOffset = Vector2.new(1024,0);
		IconP2.ImageRectSize = Vector2.new(-1024,1024);
	end;
end;

local function UpdateIcons(health)
	-- Update the icons according to the health left
	-- Player Icon check
	if KateEngine.Settings.Healthbar_IconPlayer ~= "" then
		IconP2.Image = KateEngine.Settings.Healthbar_IconPlayer;
		if KateEngine.Settings.Healthbar_IconPlayerWinning ~= "" then
			if health >= 80 then
				IconP2.Image = KateEngine.Settings.Healthbar_IconPlayerWinning;
			end;
		end;
		if KateEngine.Settings.Healthbar_IconPlayerLosing ~= "" then
			if health <= 20 then
				IconP2.Image = KateEngine.Settings.Healthbar_IconPlayerLosing;
			end;
		end;
	end
	
	-- Opponent Icon check
	if KateEngine.Settings.Healthbar_IconOpponent ~= "" then
		IconP1.Image = KateEngine.Settings.Healthbar_IconOpponent;
		if KateEngine.Settings.Healthbar_IconOpponentWinning ~= "" then
			if health <= 20 then
				IconP1.Image = KateEngine.Settings.Healthbar_IconOpponentWinning;
			end;
		end;
		if KateEngine.Settings.Healthbar_IconOpponentLosing ~= "" then
			if health >= 80 then
				IconP1.Image = KateEngine.Settings.Healthbar_IconOpponentLosing;
			end;
		end;
	end
end;

local function BopIcons(_, delta)
	-- Calculate the time for beat; Seconds per beat = 60 / BPM (KateEngine.Song.BPM)
	local time = delta / 1.15;

	IconP1.Size = UDim2.fromOffset(120,120);
	IconP2.Size = UDim2.fromOffset(120,120);
	TweenService:Create(IconP1, TweenInfo.new(time), {Size = UDim2.fromOffset(100,100)}):Play();
	TweenService:Create(IconP2, TweenInfo.new(time), {Size = UDim2.fromOffset(100,100)}):Play();
end;

---TODO---
--[[ Create a Funky Chart category in the song selector
local Category = GameUI.SongSelector.Categories:FindFirstChild("Favourites"):Clone();
Category.Parent = GameUI.SongSelector.Categories;
Category.Name = "Funky Chart";
Category.TopLabel.Text = "<font color='#FF2080'>(Kate Engine)</font>";
Category.Title.Text = "Funky Chart";
Category.Icon.Image = ""; -- Unload the image

Category.MouseButton1Click:Connect(function()
	
end);
--]]
---TODO---

-- Prepare the default GameUI stuff for the hud zoom
IngameUI.Arrows.AnchorPoint = Vector2.new(0.5, 0.5);
IngameUI.Arrows.Position = UDim2.new(0.5, 0, 0.5, 0);
IngameUI.Arrows.Size = UDim2.fromScale(1, 1);

-- Clone the Score labels
local ScoreLabelLeft = IngameUI.Score:FindFirstChild("Left"):Clone();
ScoreLabelLeft.Parent = IngameUI.Arrows;
ScoreLabelLeft.Visible = true;
ScoreLabelLeft.Name = "KE_ScoreLabelLeft";
IngameUI.Score.Left.Visible = false;
KateEngine.Assets.ScoreLabelLeft = ScoreLabelLeft;
IngameUI.Score:FindFirstChild("Left"):GetPropertyChangedSignal("Text"):Connect(function()
	local ScoreSplit = IngameUI.Score:FindFirstChild("Left").Text:split(" ");
	ScoreLabelLeft.Text = Format(KateEngine.Strings.ScoreL, {["Score"] = ScoreSplit[2]});
end);
IngameUI.Score:FindFirstChild("Left"):GetPropertyChangedSignal("Visible"):Connect(function()
	ScoreLabelLeft.Visible = true;
	IngameUI.Score:FindFirstChild("Left").Visible = false;
end);
IngameUI.Score:FindFirstChild("Left"):GetPropertyChangedSignal("Position"):Connect(function()
	ScoreLabelLeft.Position = IngameUI.Score:FindFirstChild("Left").Position;
end);

local ScoreLabelRight = IngameUI.Score:FindFirstChild("Right"):Clone();
ScoreLabelRight.Parent = IngameUI.Arrows;
ScoreLabelRight.Visible = true;
ScoreLabelRight.Name = "KE_ScoreLabelRight";
IngameUI.Score.Right.Visible = false;
KateEngine.Assets.ScoreLabelRight = ScoreLabelRight;
IngameUI.Score:FindFirstChild("Right"):GetPropertyChangedSignal("Text"):Connect(function()
	local ScoreSplit = IngameUI.Score:FindFirstChild("Right").Text:split(" ");
	ScoreLabelRight.Text = Format(KateEngine.Strings.ScoreR, {["Score"] = ScoreSplit[2]});
end);
IngameUI.Score:FindFirstChild("Right"):GetPropertyChangedSignal("Visible"):Connect(function()
	ScoreLabelRight.Visible = true;
	IngameUI.Score:FindFirstChild("Right").Visible = false;
end);
IngameUI.Score:FindFirstChild("Right"):GetPropertyChangedSignal("Position"):Connect(function()
	ScoreLabelRight.Position = IngameUI.Score:FindFirstChild("Right").Position;
end);

if isfile("KateEngine/config.png") then -- Load the settings if they exist
	local data = game:GetService("HttpService"):JSONDecode(readfile("KateEngine/config.png"));
	KateEngine.Settings = data;
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
					writefile("KateEngine/config.png", game:GetService("HttpService"):JSONEncode(KateEngine.Settings));
				end;
				Enabled = KateEngine.Settings[data.Key] or data.Default;
			});

			if data.Callback then
				data.Callback(KateEngine.Settings[data.Key] or data.Default);
			end
		elseif datatype == "Slider" then
			KateEngine.Settings[data.Key] = KateEngine.Settings[data.Key] or data.Default;
			tab.Slider({
				Text = data.Text;
				Callback = function(value)
					if data.Callback then
						data.Callback(value);
					end
					KateEngine.Settings[data.Key] = value;
					writefile("KateEngine/config.png", game:GetService("HttpService"):JSONEncode(KateEngine.Settings));
				end;
				Min = data.Minimum;
				Max = data.Maximum;
				Def = KateEngine.Settings[data.Key] or data.Default;
			});

			if data.Callback then
				data.Callback(KateEngine.Settings[data.Key] or data.Default);
			end
		elseif datatype == "Multichoice" then
			KateEngine.Settings[data.Key] = KateEngine.Settings[data.Key] or data.Default;
			local dropdown = tab.Dropdown({
				Text = data.Text;
				Callback = function(value)
					if data.Callback then
						data.Callback(value);
					end
					KateEngine.Settings[data.Key] = value;
					writefile("KateEngine/config.png", game:GetService("HttpService"):JSONEncode(KateEngine.Settings));
				end;
				Options = data.Options;
				Default = KateEngine.Settings[data.Key] or data.Default;
			});

			if data.Callback then
				data.Callback(KateEngine.Settings[data.Key] or data.Default);
			end
		elseif datatype == "Color3" then
			KateEngine.Settings[data.Key] = KateEngine.Settings[data.Key] or data.Default;
			tab.ColorPicker({
				Text = data.Text;
				Callback = function(value)
					if data.Callback then
						data.Callback(value);
					end
					KateEngine.Settings[data.Key] = KateEngine.ColorJSON.Encode(value);
					writefile("KateEngine/config.png", game:GetService("HttpService"):JSONEncode(KateEngine.Settings));
				end;
				Default = KateEngine.ColorJSON.Decode(KateEngine.Settings[data.Key] or data.Default);
			});

			if data.Callback then
				data.Callback(KateEngine.ColorJSON.Decode(KateEngine.Settings[data.Key] or data.Default));
			end;
		elseif datatype == "TextField" then
			KateEngine.Settings[data.Key] = KateEngine.Settings[data.Key] or data.Default;
			tab.TextField({
				Text = data.Text;
				Callback = function(value)
					if data.Callback then
						data.Callback(value);
					end
					KateEngine.Settings[data.Key] = value;
					writefile("KateEngine/config.png", game:GetService("HttpService"):JSONEncode(KateEngine.Settings));
				end;
				Default = KateEngine.Settings[data.Key] or data.Default;
			});

			if data.Callback then
				data.Callback(KateEngine.Settings[data.Key] or data.Default);
			end
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
end);

Watermark.MouseButton1Click:Connect(function()
	material.Self.Enabled = not material.Self.Enabled
end);

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

	KateEngine.Cache["CurrentChart"] = Framework.SongPlayer.CurrentSongData; -- unbelievable

	return diff;
end

function ReselectBotAccuracy()
	-- Get the difficulty from KateEngine.Settings.BotDifficulty
	local diff = KateEngine.Settings.BotDifficulty;
	local Difficulties = {
		["Average Blimey (Insane) Player"] = {
			Sick = 10;
			Good = 15;
			OK = 15;
			Bad = 60;
		};
		["Easy"] = {
			Sick = 70;
			Good = 15;
			OK = 10;
			Bad = 5;
		};
		["Normal"] = {
			Sick = 85;
			Good = 10;
			OK = 5;
			Bad = 0;
		};
		["Hard"] = {
			Sick = 97;
			Good = 2;
			OK = 1;
			Bad = 0;
		};
		["Insane"] = {
			Sick = 99;
			Good = 1;
			OK = 0;
			Bad = 0;
		};
		["PFC"] = {
			Sick = 100;
			Good = 0;
			OK = 0;
			Bad = 0;
		};
	};
	local NoteAccuracy = {
		Sick = 100;
		Good = 94;
		OK = 87;
		Bad = 0; -- Considered as a miss but meh
	};

	-- Select a random accuracy from the difficulty; The numbers represent the percentage of chance of getting that accuracy
	local Notes = Difficulties[diff];
	local Total = {};

	for i,v in pairs(Notes) do
		for i2 = 1, v do
			table.insert(Total, i);
		end
	end;

	local Selected = Total[math.random(1, #Total)];

	-- Get the accuracy from the note accuracy table
	local Accuracy = NoteAccuracy[Selected];

	Framework.Settings.BotPlayAccuracy.Value = Accuracy;
end

local Ratings = {
	Simple = {
		[100] = "S";
		[99] = "A";
		[97] = "A-";
		[80] = "B";
		[70] = "C";
		[60] = "D";
		[50] = "F";
		[30] = "F-";
		[0] = "🗿";
	};
	Regular = {
		[100] = "SS";
		[99.5] = "S+";
		[99.3] = "S:";
		[99.2] = "S.";
		[99] = "S";
		[98] = "AAA";
		[97.5] = "AA+";
		[97] = "AA:";
		[96.5] = "AA.";
		[96] = "AA";
		[95] = "A+";
		[94] = "A:";
		[93] = "A.";
		[91.5] = "A";
		[90] = "A-";
		[85] = "B+";
		[80] = "B";
		[70] = "C";
		[60] = "D";
		[50] = "F+";
		[40] = "F";
		[0] = "🗿";
	};
}

local function UpdateHealth() -- To be fired every time health is added/reduced
	-- If healthbar is disabled, set health to 40 (starting value) and return.
	if not KateEngine.InSolo then KateEngine.Health.Current = 40; return end;
	if not KateEngine.Settings.Healthbar then KateEngine.Health.Current = 40; return end;

	-- Otherwise, clamp the health between 0 and 100 and update the healthbar.
	KateEngine.Health.Current = math.clamp(KateEngine.Health.Current,0,KateEngine.Health.Max);
	UpdateIcons(KateEngine.Health.Current);
	HBFront.Size = UDim2.new(KateEngine.Health.Current/KateEngine.Health.Max,0,1,0);
	if KateEngine.Health.Current == 0 and KateEngine.Settings.Healthbar_DeathOnZero then
		LocalPlayer.Character.Humanoid.Health = -100;

		if KateEngine.Settings.DeathEffect == "Explosion" then
			-- Spawn an explosion where the player is
			local explosion = Instance.new("Explosion");
			explosion.Position = LocalPlayer.Character.HumanoidRootPart.Position;
			explosion.BlastRadius = 2;
			explosion.Parent = workspace;
		elseif KateEngine.Settings.DeathEffect == "Burn" then
			-- Add fire to the player
			local fire = Instance.new("Fire");
			fire.Heat = 30;
			fire.Size = 10;
			fire.Parent = LocalPlayer.Character.HumanoidRootPart;
		elseif KateEngine.Settings.DeathEffect == "Pipe" then
			-- Pipe'd lol
			task.spawn(function()
				local sprite = Framework.KateEngine.Modcharter.Sprite("rbxassetid://12427705637", UDim2.fromScale(0.5,0.5), UDim2.fromScale(1,1), 5, Vector2.new(0.5, 0.5));
				sprite.ImageTransparency = 0.5;

				local aspectratio = Instance.new("UIAspectRatioConstraint");
				aspectratio.AspectRatio = 1;
				aspectratio.Parent = sprite;

				task.wait(0.2);
				local tween = TweenService:Create(sprite, TweenInfo.new(0.3), {ImageTransparency = 1});
				tween:Play();
				tween.Completed:Wait();
				sprite:Destroy();
			end);

			Framework.KateEngine.Modcharter.Sound(FetchAsset("metalpipe.mp3"), 1, 1);
		end
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

	local result1 = string.split(IngameUI.Arrows.Stats.Text,"\n")
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
		elseif res[2] == 1 and res[3] == 1 and res[4] == 1 and miss == 1 then
			ManiaRating.Text = "OMNI-FLAG"
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

IngameUI.Arrows.InfoBar:GetPropertyChangedSignal("Text"):Connect(function()
	local t = IngameUI.Arrows.InfoBar.Text
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
			local head = LocalPlayer.Character.Head
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

IngameUI.Arrows:GetPropertyChangedSignal("Visible"):Connect(function()
	if IngameUI.Arrows.Visible == false then
		ManiaComboCounter.Visible = false
		KateEngine.Topbar.OriginTime = 0;
		KateEngine.Topbar.SongDifficulty = 0;
		KateEngine.Health.Current = 40;
		KateEngine.InSolo = false;
		KateEngine.Mania.Combo = 0;
		KateEngine.Mania.TotalNotes = 0;
		KateEngine.Mania.Perfects = 0;
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

local songstart = os.time(); -- used for both modcharting and rich presence

local FormatToTime = function(seconds)
	local minutes = math.floor(seconds / 60);
	local seconds = math.floor(seconds % 60);
	return string.format("%02d:%02d", minutes, seconds);
end;

IngameUI.Topbar.Center:FindFirstChild('Text').Label:GetPropertyChangedSignal("Text"):Connect(function() --not good?
	local nofunktxt = string.split(IngameUI.Topbar.Center:FindFirstChild('Text').Label.ContentText,'\n')[1];
	local realtxt = IngameUI.Topbar.Center:FindFirstChild('Text').Label.Text;
	local txttable = string.split(realtxt,"\n");
	TopbarLabel.Text = txttable[1];
	if txttable[3] then
		local tim = string.split(txttable[3],":");
		local seconds = tonumber(tim[1])*60 + tonumber(tim[2])
		if KateEngine.Topbar.OriginTime == 0 then
			KateEngine.Topbar.OriginTime = seconds
			KateEngine.Topbar.SongDifficulty = CalcDifficultyRating(seconds);
		end

		local function handler()
			local m = seconds/KateEngine.Topbar.OriginTime -- seconds left / total seconds
			m = 1-m -- reverse the value
			TopbarProgress:TweenSize(UDim2.new(m,0,1,0),Enum.EasingDirection.Out,Enum.EasingStyle.Linear,1,true)
			TopbarLabel.Text ..= " - " .. txttable[3];

			Bloxstrap.SetRichPresence({
				details = "Funky Friday - Playing a song",
				state = nofunktxt, --..' - '..FormatToTime(math.abs(KateEngine.Topbar.OriginTime-seconds))..' / '..FormatToTime(KateEngine.Topbar.OriginTime),
				timeEnd = math.floor( os.time() + math.abs( seconds ) ),
				timeStart = songstart,
			});
		end

		handler();
	end;
end)


Framework.Settings.MissedSound.Value = false;
if KateEngine.Settings.CamManipulation then
	Framework.Settings.CameraDirectionMovement.Value = false;
end

function Framework:GetEvent(Name)
    return self.EventAction.Events[Name];
end

Framework:GetEvent("SettingsChanged"):Connect(function()
	Framework.Settings.MissedSound.Value = false;
	if KateEngine.Settings.CamManipulation then
		Framework.Settings.CameraDirectionMovement.Value = false;
	end
end);

IngameUI.Topbar.Center:FindFirstChild('Text').Label:GetPropertyChangedSignal("Visible"):Connect(function()
	IngameUI.Topbar.Center:FindFirstChild('Text').Label.Visible = false; 
end)

local newloc = PromptUI.SongSelector.Frame.Start
newloc.Toggle.Visible = false;
newloc = newloc.Start
local buttontemplate = newloc.StartButton;

buttontemplate.MouseButton1Click:Connect(function()
	SendPlay("normal");
end)

-- Stats UI clone
local statgui = IngameUI.Arrows.Stats:Clone()
statgui.RichText = true; -- Force rich text on the stats
statgui.Parent = IngameUI.Arrows

IngameUI.Arrows.Stats:GetPropertyChangedSignal("Visible"):Connect(function()
	if IngameUI.Arrows.Stats.Visible then
		IngameUI.Arrows.Stats.Visible = false;
	end
end)

IngameUI.Arrows.Stats:GetPropertyChangedSignal("Text"):Connect(function() -- This function should show any 'shadow' stats
	IngameUI.Arrows.Stats.Visible = false;
	local result1 = string.split(IngameUI.Arrows.Stats.Text,"\n")
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

	statgui.Text = "<font color='#50C5FF'>Sick</font>: "..tostring(tonumber(stats.sick)-KateEngine.Mania.Perfects) .."\n<font color='#8AFF50'>Good</font>: "..stats.good.."\n<font color='#FFC550'>OK</font>: "..stats.ok.."\n<font color='#FF5050'>Bad</font>: "..stats.bad.."\n<font color='#888888'>Missed</font>: "..stats.missed

	if res ~= KateEngine.Mania.TotalNotes then
		statgui.Text = "<font color='#50C5FF'>Sick</font>: "..stats.sick.."\n<font color='#8AFF50'>Good</font>: "..stats.good.."\n<font color='#FFC550'>OK</font>: "..stats.ok.."\n<font color='#FF5050'>Bad</font>: "..stats.bad .. " <font color='#AAAAAA'>(+"..KateEngine.Mania.TotalNotes - res..")</font>".."\n<font color='#888888'>Missed</font>: "..stats.missed
		showtotalnotes = true;
	end

	if KateEngine.Mania.Perfects > 0 then
		statgui.Text = "<font color='#ff0090'>Marvelous</font>: "..KateEngine.Mania.Perfects.."\n"..statgui.Text
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
local EventClock = 0;
local TotalSteps = 0;
local BPMChanges = {}; -- Track the BPM changes here so we can sync the song steps correctly

local debugtext = "";

local function CameraBind(inst, strength)
	local compilation, isUI = pcall(function()
		if inst.BackgroundTransparency then
			return true;
		end
	end);

	if not compilation or not isUI then
		return false;
	end
	
	table.insert(KateEngine.CameraBinds, {
		Self = inst,
		Strength = strength
	});

	return true;
end;

-- Events we listen to
local LanePressed = Framework:GetEvent("LanePressed") -- This is the event that is fired whenever you press a strum; @param {table {Direction : number<0-3>, Position : ?}}
local SceneLoaded = Framework:GetEvent("SceneLoaded"); -- This is the event that gets fired when a scene is loaded; @param {string? = scenename, folder? = sceneinstance | nil = scene unloading}
local SoundEvent = Framework:GetEvent("SoundEvent"); -- This is the event that gets fired when a song starts or ends; @param {boolean = songstarted/songended}
local NoteMiss = Framework:GetEvent("NoteMissed"); -- This is the event that gets fired when a note is missed, used for modcharts; @param {table NoteClass, table Receptor(?)}
local NoteHit = Framework:GetEvent("NoteHitBegan"); -- NoteHitEnded is also available, but we need the NoteHit part because it contains the ms; @param: {table {HitAccuracy:number<0-100>, MS:float?, Note:table {NoteData}, HitTime:float<tick()>}, table {?}}
local NoteHitEnd = Framework:GetEvent("NoteHitEnded"); -- @param {table NoteClass, table Receptor, ?}
local NoteCreated = Framework:GetEvent("NoteCreated"); -- This is the event that gets fired when a note is created?; @param {table NoteClass?, table? self}
local NotePassed = Framework:GetEvent("NotePassed"); -- @param {table NoteClass}

ModchartSystem = {
	-- Camera zooming thing
	CameraZoom = function(Strength)
		if not Strength then
			Strength = (KateEngine.Settings.Modcharts_CameraStrength * 0.2);
		end;

		-- Tween the camera
		local tweenInfo = TweenInfo.new(((60/KateEngine.Song.BPM)*3.5), Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		Camera.FieldOfView = FOV-(1*Strength);
		local camtween = TweenService:Create(Camera, tweenInfo, {FieldOfView = FOV});
		local txttween = TweenService:Create(ManiaRating, tweenInfo, {TextSize = 30});
		IngameUI.Arrows.Size = UDim2.fromScale(1+(0.04 * Strength), 1+(0.04 * Strength));
		local hudtween = TweenService:Create(IngameUI.Arrows, tweenInfo, {Size = UDim2.fromScale(1, 1)});
		camtween:Play();
		txttween:Play();
		hudtween:Play();
		task.spawn(function()
			camtween.Completed:Wait();
			camtween:Destroy();
			txttween:Destroy();
			hudtween:Destroy();
		end);
	end;

	SetIcons = function(IconTable, Side)
		if not Side then Side = Framework.UI.CurrentSide; end;
		local Target = IconP2; -- Change own icons
		if Side ~= Framework.UI.CurrentSide then
			Target = IconP1; -- Change opponent icons
		end;

		-- Store the current icons
		if not KateEngine.Cache["Icons_"..Side] then
			KateEngine.Cache["Icons_"..Side] = {
				Idle = Target==IconP1 and KateEngine.Settings.Healthbar_IconOpponent or KateEngine.Settings.Healthbar_IconPlayer;
				Losing = Target==IconP1 and KateEngine.Settings.Healthbar_IconOpponentLosing or KateEngine.Settings.Healthbar_IconPlayerLosing;
				Winning = Target==IconP1 and KateEngine.Settings.Healthbar_IconOpponentWinning or KateEngine.Settings.Healthbar_IconPlayerWinning;
			};
		end;

		-- Set the icons
		if Target == IconP1 then
			KateEngine.Settings.Healthbar_IconOpponent = IconTable.Idle;
			KateEngine.Settings.Healthbar_IconOpponentLosing = IconTable.Losing or "";
			KateEngine.Settings.Healthbar_IconOpponentWinning = IconTable.Winning or "";
		elseif Target == IconP2 then
			KateEngine.Settings.Healthbar_IconPlayer = IconTable.Idle;
			KateEngine.Settings.Healthbar_IconPlayerLosing = IconTable.Losing or "";
			KateEngine.Settings.Healthbar_IconPlayerWinning = IconTable.Winning or "";
		end;

		UpdateIcons(KateEngine.Health.Current);
	end;

	SetBPM = function(newbpm)
		table.insert(BPMChanges, {
			KateEngine.Song.Step, -- Step
			KateEngine.Song.BPM, -- Previous BPM
			newbpm -- New BPM
		});

		KateEngine.Song.BPM = newbpm;
		local BPS = newbpm / 60; -- BPS (Beats per second)
		local SPB = 1 / BPS; -- SPB (Seconds per beat)
		local SPS = SPB / 4; -- SPS (Steps per second)
		KateEngine.Song.SPS = SPS;

		songstart = os.time();
		
		CurrentStep = 2;
	end;

	ResetIcons = function(Side)
		if not KateEngine.Cache["Icons_"..Side] then return; end;

		if not Side then Side = Framework.UI.CurrentSide; end;
		local Target = IconP2; -- Change own icons
		if Side ~= Framework.UI.CurrentSide then
			Target = IconP1; -- Change opponent icons
		end;

		-- Reset the icons
		if Target == IconP1 then
			KateEngine.Settings.Healthbar_IconOpponent = KateEngine.Cache["Icons_"..Side].Idle;
			KateEngine.Settings.Healthbar_IconOpponentLosing = KateEngine.Cache["Icons_"..Side].Losing;
			KateEngine.Settings.Healthbar_IconOpponentWinning = KateEngine.Cache["Icons_"..Side].Winning;
		elseif Target == IconP2 then
			KateEngine.Settings.Healthbar_IconPlayer = KateEngine.Cache["Icons_"..Side].Idle;
			KateEngine.Settings.Healthbar_IconPlayerLosing = KateEngine.Cache["Icons_"..Side].Losing;
			KateEngine.Settings.Healthbar_IconPlayerWinning = KateEngine.Cache["Icons_"..Side].Winning;
		end;

		KateEngine.Cache["Icons_"..Side] = nil;
	end;

	SetHealthColor = function(Color, Side)
		if not Side then Side = Framework.UI.CurrentSide; end;
		local Target = HBFront;
		if Side ~= Framework.UI.CurrentSide then
			Target = Healthbar;
		end;

		if not KateEngine.Cache["Color_"..Side] then
			KateEngine.Cache["Color_"..Side] = Target.BackgroundColor3;
		end;

		-- Set the color
		Target.BackgroundColor3 = Color;
	end;

	ResetHealthColor = function(Side)
		if not KateEngine.Cache["Color_"..Side] then return; end;

		if not Side then Side = Framework.UI.CurrentSide; end;
		local Target = HBFront;
		if Side ~= Framework.UI.CurrentSide then
			Target = Healthbar;
		end;

		-- Reset the color
		Target.BackgroundColor3 = KateEngine.Cache["Color_"..Side];

		KateEngine.Cache["Color_"..Side] = nil;
	end;

	SetString = function(Key, NewString)
		KateEngine.Strings[Key] = NewString;

		-- Check the key and update accordingly
		task.spawn(function()
			task.wait(); -- Wait a single heartbeat; Enough time for the string to realize it's changed
			if Key == "ScoreL" then
				IngameUI.Score.Left.Text = "lol "..IngameUI.Score.Left.Text:split(" ")[2];
			elseif Key == "ScoreR" then
				IngameUI.Score.Right.Text = "lol "..IngameUI.Score.Right.Text:split(" ")[2];
			end;
		end);
	end;

	ResetAnimation = function()
		-- Reset the animation to the equipped one
		Framework.AnimController:Stop(LocalPlayer.Character);
		Framework.AnimController:Start(LocalPlayer.Character, Framework.UI.CurrentSide == "Right" and 2 or 1, Framework.KateEngine.Network.Server:GetDataValue("MoveSet").Idle);
	end;

	SetAnimation = function(Animation) -- Limited to localplayer only for now in order to avoid issues with the opponent's animation
		if not Animation then
			-- Just reset the animation to the equipped one; Equivelant to ResetAnimation();
			Framework.AnimController:Stop(LocalPlayer.Character);
			Framework.AnimController:Start(LocalPlayer.Character, Framework.UI.CurrentSide == "Right" and 2 or 1, Framework.KateEngine.Network.Server:GetDataValue("MoveSet").Idle);

			return;
		end;

		-- Set the animation
		Framework.AnimController:Stop(LocalPlayer.Character);
		Framework.AnimController:Start(LocalPlayer.Character, Framework.UI.CurrentSide == "Right" and 2 or 1, Animation);
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
		if not Framework:GetKEValue("SavedArrowsStyle") then return end -- If there's no saved arrows style, don't do anything (likely there's no need to do anything in the first place)
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

	Object = {
		BindToCamera = CameraBind;

		Sprite = function(SpriteID, Position, Size, ZIndex, AnchorPoint)
			local Sprite = Instance.new("ImageLabel");
			Sprite.Image = SpriteID;
			Sprite.BackgroundTransparency = 1;
			Sprite.Size = Size or UDim2.new(0, 100, 0, 100);
			Sprite.Position = Position or UDim2.new(0.5, 0, 0.5, 0);
			Sprite.ZIndex = ZIndex or 1;
			Sprite.Parent = IngameUI;
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

		Text = function(Text, Position, Size, ZIndex, AnchorPoint)
			local TextLabel = Instance.new("TextLabel");
			TextLabel.Text = Text;
			TextLabel.BackgroundTransparency = 1;
			TextLabel.TextSize = Size or 14;
			TextLabel.Position = Position or UDim2.new(0.5, 0, 0.5, 0);
			TextLabel.ZIndex = ZIndex or 1;
			TextLabel.Parent = IngameUI;
			TextLabel.AnchorPoint = AnchorPoint or Vector2.new(0.5, 0.5);
			table.insert(KateEngine.Assets, TextLabel);
			return TextLabel;
		end;

		Video = function(VideoID, Position, Size, ZIndex, AnchorPoint)
			-- TODO
		end;
	};

	Sprite = function(SpriteID, Position, Size, ZIndex, AnchorPoint)
		local Sprite = Instance.new("ImageLabel");
		Sprite.Image = SpriteID;
		Sprite.BackgroundTransparency = 1;
		Sprite.Size = Size or UDim2.new(0, 100, 0, 100);
		Sprite.Position = Position or UDim2.new(0.5, 0, 0.5, 0);
		Sprite.ZIndex = ZIndex or 1;
		Sprite.Parent = IngameUI;
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

	Health = {
		IncreaseMax = function(Amount)
			KateEngine.Health.Max += Amount;
			UpdateHealth();
		end;

		DecreaseMax = function(Amount)
			KateEngine.Health.Max -= Amount;
			UpdateHealth();
		end;

		SetMax = function(Amount)
			KateEngine.Health.Max = Amount;
			UpdateHealth();
		end;

		Increase = function(Amount)
			KateEngine.Health.Current += Amount;
			UpdateHealth();
		end;

		Decrease = function(Amount)
			KateEngine.Health.Current -= Amount;
			UpdateHealth();
		end;

		Set = function(Amount)
			KateEngine.Health.Current = Amount;
			UpdateHealth();
		end;

		Hurt = function(Amount, MinimumHealth) -- Amount is the amount of health to take away, MinimumHealth is the minimum amount of health to leave the player with (if the player has less than this, this will do nothing)
			if not MinimumHealth then MinimumHealth = 0 end
			if KateEngine.Health.Current <= MinimumHealth then return end

			KateEngine.Health.Current -= Amount;
			if KateEngine.Health.Current < MinimumHealth then KateEngine.Health.Current = MinimumHealth end

			UpdateHealth();
		end;

		Reset = function()
			KateEngine.Health.Max = 100;
			KateEngine.Health.Current = 40;
			UpdateHealth();
		end;
	};

	-- Note Controls; It is recommended to only call this exact function once, rather than calling it on every step/hit/whatever. heck, use the Variables table for that.
	Note = function(NoteKey) -- TODO
		if NoteKey > 7 or NoteKey < 0 then error("Key invalid - Modcharting abilities are only allowed for 4Key songs.") end -- If the note key is invalid, error out.

		-- Find which side the note is; 0 to 3 = Left, 4 to 7 = Right
		local NoteKey = tonumber(NoteKey);
		local Side = NoteKey < 4 and "Left" or "Right";
		local Number = NoteKey < 4 and NoteKey or NoteKey - 4;

		-- Attempt to find the note
		local Note = IngameUI.Arrows[Side].Arrows['Arrow'..tostring(Number)];

		-- In order to avoid errors due to a NIL, we'll send a table regardless of if the note exists or not; However, all functions will return instantly if the note doesn't exist.
		return {
			Fetch = function() -- Returns the note object itself, or nil if one wasn't found.
				return Note;
			end;

			TweenXPosition = function(PositionChange, Time, Enum_EasingStyle, Enum_EasingDirection)
				if not Note then return end;

				if not PositionChange then 
					return;
				end;

				if not Time then
					Time = 0.5;
				end;

				if not Enum_EasingStyle then
					Enum_EasingStyle = Enum.EasingStyle.Linear;
				end;

				if not Enum_EasingDirection then
					Enum_EasingDirection = Enum.EasingDirection.InOut;
				end;

				-- Tween the note
				Note.InnerFrame:TweenPosition(UDim2.fromScale(Note.InnerFrame.Position.X.Scale + PositionChange, Note.InnerFrame.Position.Y.Scale), Enum_EasingDirection, Enum_EasingStyle, Time, true);
			end;

			TweenYPosition = function(PositionChange, Time, Enum_EasingStyle, Enum_EasingDirection)
				if not Note then return end;

				if not PositionChange then 
					return;
				end;

				if not Time then
					Time = 0.5;
				end;

				if not Enum_EasingStyle then
					Enum_EasingStyle = Enum.EasingStyle.Linear;
				end;

				if not Enum_EasingDirection then
					Enum_EasingDirection = Enum.EasingDirection.InOut;
				end;

				-- Tween the note
				Note.InnerFrame:TweenPosition(UDim2.fromScale(Note.InnerFrame.Position.X.Scale, Note.InnerFrame.Position.Y.Scale + PositionChange), Enum_EasingDirection, Enum_EasingStyle, Time, true);
			end;

			TweenAngle = function(AngleChange, Time)
				if not Note then return end;

				if not AngleChange then 
					return;
				end;

				if not Time then
					Time = 0.5;
				end;

				-- Create a tween
				local Tween = TweenService:Create(Note.InnerFrame[Number], TweenInfo.new(Time), {Rotation = AngleChange});

				-- Start the tween
				Tween:Play();

				Tween.Completed:Once(function()
					Tween:Destroy();
				end);
			end;

			TweenAlpha = function(NewAlpha, Time)
				if not Note then return end;

				-- Tween the note transparency (Uses the receptor's UpdateTransparency function, apparently)
				local IntValue = Instance.new("NumberValue");
				IntValue.Value = KateEngine.Cache["CurrentNoteAlpha"..tostring(NoteKey)] or 0; -- Assuming the alpha range is 0-255 = 0 is opaque, 255 is transparent;

				if not NewAlpha then
					NewAlpha = 0;
				end;

				if not Time then
					Time = 0;
				end;

				local TweenCompleteEvent = IntValue.Changed:Connect(function()
					Note:UpdateTransparency(IntValue.Value / 255);
				end);

				if Time > 0 then
					local Tween = TweenService:Create(IntValue, TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Value = NewAlpha});

					Tween:Play();
					Tween.Completed:Once(function()
						TweenCompleteEvent:Disconnect();
						Tween:Destroy();
					end);
				else
					IntValue.Value = NewAlpha;
				end;

				IntValue:Destroy();
			end;
		}
	end;

	AllNotes = {
		SetAlpha = function(NewAlpha)
			if not NewAlpha then
				NewAlpha = 0;
			end;

			for _, Note in pairs(Framework.UI.Arrows.Receptors) do
				Note:UpdateTransparency(NewAlpha / 255);
			end;
		end;

		TweenAlpha = function(NewAlpha, Time)
			if not NewAlpha then
				NewAlpha = 0;
			end;

			if not Time then
				Time = 0;
			end;

			local IntValue = Instance.new("NumberValue");
			IntValue.Value = 0; -- Assuming the alpha range is 0-255 = 0 is opaque, 255 is transparent;

			local TweenCompleteEvent = IntValue.Changed:Connect(function()
				for _, Note in pairs(Framework.UI.Arrows.Receptors) do
					Note:UpdateTransparency(IntValue.Value / 255);
				end;
			end);

			if Time > 0 then
				local Tween = TweenService:Create(IntValue, TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Value = NewAlpha});

				Tween:Play();
				Tween.Completed:Once(function()
					TweenCompleteEvent:Disconnect();
					Tween:Destroy();
				end);
			else
				IntValue.Value = NewAlpha;
			end;

			IntValue:Destroy();
		end;
	};

	Lane = function(LaneKey) -- TODO

	end;

	CamHUD = {
		SetAngle = function(Angle)
			Framework.IngameUI.Arrows.Rotation = Angle;
		end;

		GetAngle = function()
			return Framework.IngameUI.Arrows.Rotation;
		end;

		TweenAngle = function(Angle, Time)
			if not Angle then
				Angle = 0;
			end;

			if not Time then
				Time = 0;
			end;

			if Time > 0 then
				local Tween = TweenService:Create(Framework.IngameUI.Arrows, TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Rotation = Angle});

				Tween:Play();
				Tween.Completed:Once(function()
					Tween:Destroy();
				end);
			else
				Framework.IngameUI.Arrows.Rotation = Angle;
			end;
		end;
	}
};

KateEngine.Modcharter = ModchartSystem;
local CurrentSongId = nil;
-- Check if KateEngine/Modcharts.lua exists;
-- If yes, we can load it instead of the default modcharts from github;

if isfile("KateEngine/Modcharts.lua") then
	local ModchartFile = readfile("KateEngine/Modcharts.lua");
	-- Attempt to load the modcharts file
	local Success, ModchartStuff = pcall(loadstring, ModchartFile);
	if Success then
		local Test = ModchartStuff();
		if type(Test) == "function" then
			Modcharts = ModchartStuff()();
		elseif type(Test) == "table" then
			Modcharts = ModchartStuff();
		end

		function KateEngine.ReloadModcharts()
			local ModchartFile = readfile("KateEngine/Modcharts.lua");
			local Success, ModchartStuff = pcall(loadstring, ModchartFile);
			if Success then
				local Test = ModchartStuff();
				if type(Test) == "function" then
					Modcharts = ModchartStuff()();
				elseif type(Test) == "table" then
					Modcharts = ModchartStuff();
				end
			end
		end
	else
		-- If it fails, we can't load it
		-- So we load the default modcharts from github
		Modcharts = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/main/modcharts.lua",true))();
	end
else
	Modcharts = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/main/modcharts.lua",true))();
end

function spawnError(err:string)
    --TODO: Create a UI specifically for errors and send them here.
    --Apparently errors and warnings are not filtered through the exploits, so they can be detected by Roblox easily.
    --(hi java)
end;

function generateModchartError(state, ...)
	-- temporary :3
	local err=...;
	warn('===== FUNKIFY =====\nA modchart error has occured!\nPlease report this to the Funkify devs or help fix it yourself by creating a pull request!\n\nSongId: '..CurrentSongId..' | State: '..state..'\n\nError: '..err..'\n\n' .. debug.traceback().. '===== END =====');
end

function callLuaState(state, ...)
	-- woops
	if not CurrentSongId then return end;
	if not Modcharts then return end;
	if not Modcharts[CurrentSongId] then return end;

	local AttemptCall = function(...)
		local s,f = pcall(Modcharts[CurrentSongId][state], Framework, ...);
		if not s then
			generateModchartError(state, f);
		end
	end;

	if Modcharts[CurrentSongId][state] then
		task.spawn(AttemptCall, ...);
	end
end;

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

	-- try finding if we have a song?

	-- Can't do anything with modcharts due to the fact that the song hasn't started yet, hence no songID can be grabbed!
	-- If the modcharters want to do something with the scene, they could theoretically use the SongStart event and use the KE values above to do the stuff they want to do.
end);

local NoteHitTween = nil;
NoteHit:Connect(function(NoteHitData, Note)
	-- @param: {table NoteClass, table {?}}
	-- NoteHitData.HitAccuracy is the accuracy of the note hit
	-- NoteHitData.MS is the ms of the note hit
	-- NoteHitData.HitTime is the tick() of the note hit

	--local Modchart = Framework:GetKEValue("CurrentModchart")

	ReselectBotAccuracy();

	--if Modchart and Modchart.NoteHit then
	--	Modchart.NoteHit(Framework, NoteHitData, Note); -- Send the raw data to the modchart so the modcharter has full control over the note hit
	--end;

    if not Note then return end;
    if not NoteHitData then return end;

	callLuaState("NoteHit", NoteHitData, Note);
	if Note.Side and Note.Side == Framework.UI.CurrentSide then
		callLuaState("PlayerNoteHit", NoteHitData, Note);
	else
		callLuaState("OpponentNoteHit", NoteHitData, Note);
	end;

	if Note and Note.NoteDataConfigs and (Note.NoteDataConfigs.Type == "Poison" or Note.NoteDataConfigs.Type == "LividLycanthrope") and Note.Side and Note.Side == Framework.UI.CurrentSide then
		-- This only affects the player if they are in solo anyways.
		ModchartSystem.DecrementHealth(20);
	end;

	if not Note then
		-- This is a fake note hit, so we don't want to do anything with it
		return;
	end

	if math.abs(tonumber(NoteHitData.MS) or 999) <= (KateEngine.Settings.PerfectTimeframe) and KateEngine.Settings.PerfectRating and Note and Note.Side and (Note.Side == Framework.UI.CurrentSide) then
		KateEngine.Mania.Perfects += 1;
	end;

	if KateEngine.Settings.Mania_JudgementOverlays then
		if Note and Note.Side and not (Note.Side == Framework.UI.CurrentSide) then return end;

		if KateEngine.Settings.Mania_NonPerfectOverlays then
			-- Show the overlay only if the note was not perfect
			if ((NoteHitData.HitAccuracy > 95) and not (math.abs(tonumber(NoteHitData.MS)) <= (0.5 * KateEngine.Settings.PerfectTimeframe) and KateEngine.Settings.PerfectRating)) then
				return;
			end
		end

		ManiaJudgementOverlay.Visible = true;

		if NoteHitData.HitAccuracy >= 95 then
			ManiaJudgementOverlay.ImageColor3 = Color3.fromRGB(80, 197, 255);
		elseif NoteHitData.HitAccuracy >= 90 then
			ManiaJudgementOverlay.ImageColor3 = Color3.fromRGB(138, 255, 80);
		elseif NoteHitData.HitAccuracy >= 85 then
			ManiaJudgementOverlay.ImageColor3 = Color3.fromRGB(255, 197, 80);
		else
			ManiaJudgementOverlay.ImageColor3 = Color3.fromRGB(255, 80, 80);
		end;

		if math.abs(tonumber(NoteHitData.MS)) <= (0.5 * KateEngine.Settings.PerfectTimeframe) and KateEngine.Settings.PerfectRating then -- PERFECT HIT!!
			ManiaJudgementOverlay.ImageColor3 = Color3.fromRGB(255, 0, 140);
		end;

		ManiaJudgementOverlay.ImageTransparency = 0;

		if NoteHitTween then
			NoteHitTween:Cancel();
		end;

		NoteHitTween = TweenService:Create(ManiaJudgementOverlay, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageTransparency = 1});
		NoteHitTween:Play();

		NoteHitTween.Completed:Once(function()
			NoteHitTween = nil;
		end);
	else
		ManiaJudgementOverlay.Visible = false;
	end
end);

NoteHitEnd:Connect(function(Note, Receptor)
	-- @param: {table NoteClass, table Receptor, ?}
	-- no clue what the 3rd parameter is

	callLuaState("NoteHitEnd", Note, Receptor);
	if Note.Side == Framework.UI.CurrentSide then
		callLuaState("PlayerNoteHitEnd", Note, Receptor);
	else
		callLuaState("OpponentNoteHitEnd", Note, Receptor);
	end;

    if KateEngine.Settings.MissHighlight then
        if LocalPlayer.Character:FindFirstChild("MissHighlight") then
            LocalPlayer.Character:FindFirstChild("MissHighlight"):Destroy();
        end;
    end;
end);

NoteMiss:Connect(function(Note, Receptor)
	-- @param: { table NoteClass, table Receptor(?) }

	--[[
	local Modchart = Framework:GetKEValue("CurrentModchart")

	if Modchart and Modchart.NoteMiss then
		Modchart.NoteMiss(Framework, Note, Receptor, Note.Side==Framework.UI.CurrentSide);
	end]]

	if Note.Side==Framework.UI.CurrentSide then
		callLuaState("NoteMiss", Note, Receptor);
	else
		callLuaState("OpponentNoteMiss", Note, Receptor);
	end;

    if KateEngine.Settings.MissHighlight then
        if LocalPlayer.Character:FindFirstChild("MissHighlight") then
            LocalPlayer.Character:FindFirstChild("MissHighlight"):Destroy();
        end;

        local Highlight = Instance.new("Highlight");
        Highlight.FillTransparency = 0.6;
        Highlight.FillColor = Color3.new(0.556863, 0.000000, 0.925490);
        Highlight.OutlineTransparency = 1;
        Highlight.Name = 'MissHighlight';

        Highlight.Parent = LocalPlayer.Character;

        task.delay(0.5, function()
            if Highlight.Parent then
                Highlight:Destroy();
            end;
        end);
    end;
end);

NotePassed:Connect(function(Note)
	-- @param: { table NoteClass }
	-- Literally no clue what it does lol
	-- Is it just another Miss? Oh well
	callLuaState("NotePassed", Note);
end);

NoteCreated:Connect(function(Note)
	--[[
	@param: { table NoteClass }
	local Modchart = Framework:GetKEValue("CurrentModchart")

	if Modchart and Modchart.NoteCreated then
		Modchart.NoteCreated(Framework, Note);
	end
	]]

	callLuaState("NoteCreated", Note);
end);

local curPos = nil

local function CreateModchartDebug(songmodchart)
	local debugtext = "";

	if songmodchart then
		if songmodchart.Name then
			debugtext = debugtext.."\n\nModchart Loaded - "..(songmodchart.Name);
		else
			debugtext = debugtext.."\n\nModchart Loaded";
		end;

		if songmodchart.Author then
			debugtext = debugtext.."\nAuthor: "..songmodchart.Author;
		elseif songmodchart.PortedBy then
			debugtext = debugtext.."\nPorted By: "..songmodchart.PortedBy;
		end;

		if songmodchart.Lyrics then
			debugtext = debugtext.."\nLyrics: ";
			local amount = 0;
			for _ in pairs(songmodchart.Lyrics) do
				amount += 1;
			end;
			debugtext = debugtext..amount;
		end

		if songmodchart.Events then
			debugtext = debugtext.."\nEvents: ";
			local amount = 0;
			for _ in pairs(songmodchart.Events) do
				amount += 1;
			end;
			debugtext = debugtext..amount;
		end

		if songmodchart.EventDefinitions then
			debugtext = debugtext.."\nEvent Definitions: ";
			local amount = 0;
			for _ in pairs(songmodchart.EventDefinitions) do
				amount += 1;
			end;
			debugtext = debugtext..amount;
		end

		if songmodchart.SetBPM then
			debugtext = debugtext.."\nManual BPM: "..songmodchart.SetBPM;
		end

		if songmodchart.ShitpostChart then
			debugtext = debugtext.."\n\n(Modchart marked as Shitpost)";
		end
	end

	return debugtext;
end;

LanePressed:Connect(function(direction, isActive)
	-- Here we are with the strumLine stuffs!
	-- @param: {direction:table {Direction : number<0-3>, Position : ?}}
	-- The paramater isActive signifies when the lane is currently being held or not

	local cameraDisplace : number = KateEngine.Settings.CamDisplace / 10;
	local cameraManipulationTable = {
		["0"] = CFrame.new(-cameraDisplace, 0, 0),
		["1"] = CFrame.new(0, -cameraDisplace, 0),
		["2"] = CFrame.new(0, cameraDisplace, 0),
		["3"] = CFrame.new(cameraDisplace, 0, 0)
	};
	-- We check to see if we can go ahead with the camera displacement
	if Framework.SongPlayer and Framework.SongPlayer.CurrentlyPlaying and direction.Side == Framework.UI.CurrentSide then
		if isActive then
			curPos = direction.Direction or direction.Position;
			Framework.StageCam:SetOffset("Direction", cameraManipulationTable[tostring(curPos)]);

			for _, bind in pairs(KateEngine.CameraBinds) do
				-- Assume the bind is active if bind.Self isn't nil
				if not bind.Self then continue end; -- oops?

				local Element = bind.Self;
				local Strength = bind.Strength;
				Element:TweenPosition(UDim2.new(Element.Position.X.Scale + (cameraManipulationTable[tostring(curPos)].X * Strength), Element.Position.X.Offset, Element.Position.Y.Scale + (cameraManipulationTable[tostring(curPos)].Y * Strength), Element.Position.Y.Offset), "Out", "Quad", 0.25, true);
			end;

			return;
		end;
		if direction.Direction == curPos then
			Framework.StageCam:SetOffset("Direction", nil);

			for _, bind in pairs(KateEngine.CameraBinds) do
				-- Assume the bind is active if bind.Self isn't nil
				if not bind.Self or not bind.Self.Parent then continue end; -- oops?

				local Element = bind.Self;
				local Strength = bind.Strength;
				Element:TweenPosition(UDim2.new(Element.Position.X.Scale - (cameraManipulationTable[tostring(curPos)].X * Strength), Element.Position.X.Offset, Element.Position.Y.Scale - (cameraManipulationTable[tostring(curPos)].Y * Strength), Element.Position.Y.Offset), "Out", "Quad", 0.25, true);
			end;
		end;
	end;
end);

SoundEvent:Connect(function(Active)
	if Active == false then
		if connectedevent then -- Avoid an error (💀)
			connectedevent:Disconnect();
			connectedevent = nil;
		end;

		--[[if Framework:GetKEValue("CurrentModchart") and Framework:GetKEValue("CurrentModchart").SongEnd then
			Framework:GetKEValue("CurrentModchart").SongEnd(Framework);
		end;
		--]]
		callLuaState("SongEnd");

		ModchartSystem.SetLyrics(""); -- Clear out the lyrics (how did i miss that)
		Framework:SetKEValue("CurrentModchart", nil);
		ModchartSystem.LoadArrowsStyle(); -- Return the arrows to their original style

		ModchartSystem.ResetIcons("Left");
		ModchartSystem.ResetIcons("Right");

		ModchartSystem.ResetHealthColor("Left");
		ModchartSystem.ResetHealthColor("Right");

		BPMChanges = {}; -- Reset the BPM changes

		-- Reset the strings to the default ones
		for key, default in pairs(KateEngine.DefaultStrings) do
			ModchartSystem.SetString(key, default);
		end;

		for ae,v in pairs(KateEngine.CameraBinds) do
			if v.Self then
				v.Self:Destroy();
			end;

			v.Self = nil;

			table.remove(KateEngine.CameraBinds, ae);
		end;

		callLuaState('cleanUp');

		Bloxstrap.SetRichPresence({
			details = "Funky Friday - In the lobby",
			timeStart = math.floor(LoadStartTime),
		});
	end
	id = id + 1;
	local assigned = id;
	local realstart = tick();
	songstart = os.time();
	if Active == true then
		ModchartSystem.SaveArrowsStyle();
		local defaultbumping = true;
		local songmodchart = nil;
		local songmodcharttext = "";

		KateEngine.Assets.Healthbar.Front.AnchorPoint = Vector2.new((Framework.UI.CurrentSide == "Right" and 1 or 0), 0.5);
		KateEngine.Assets.Healthbar.Front.Position = UDim2.new((Framework.UI.CurrentSide == "Right" and 1 or 0), 0, 0.5, 0);
		IconCheck(Framework.UI.CurrentSide);

		local songid = Framework.SongPlayer.CurrentlyPlaying and Framework.SongPlayer.CurrentlyPlaying.SoundId:gsub("rbxassetid://","");
		CurrentSongId = songid; -- for CallLuaState
		KateEngine.Song.Instance = Framework.SongPlayer.CurrentlyPlaying;
		-- Should come out as just the ID number of the song
		-- Like this; rbxassetid://12345 => 12345

		Framework:SetKEValue("SongID", songid); -- TO BE DEPRECATED IN FAVOR OF [[ Engine.Song.Id ]]
		KateEngine.Song.Id = songid;

		-- Check if the song has a modchart
		if Modcharts and Modcharts[songid] then
			if (Modcharts[songid].ShitpostChart and KateEngine.Settings.Modcharts_AllowShitposts) or (not Modcharts[songid].ShitpostChart) then
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

				--Framework:SetKEValue("CurrentModchart", Modcharts[songid]);
				songmodchart = Modcharts[songid];
				songmodcharttext = CreateModchartDebug(Modcharts[songid]);
			end
		end;

		local Zone = Framework.StageZone and Framework.StageZone.CurrentZone;
		local Stage = Zone and (Zone.Parent.Name:match("Stage") and Zone.Parent);
		if Stage then
			local BPM = (Modcharts[songid] and Modcharts[songid].SetBPM) or Stage:GetAttribute("BPM");
			KateEngine.Song.BPM = BPM;
			local OFFSET = Stage:GetAttribute("Offset");
			if BPM then
				local BPS = BPM / 60; -- BPS (Beats per second)
				local SPB = 1 / BPS; -- SPB (Seconds per beat)
				local SPS = SPB / 4; -- SPS (Steps per second)
				if OFFSET then
					task.wait(OFFSET % SPB);
				end;
				EventClock = 0;
				CurrentStep = 0;
				CurrentBeat = 0;
				CurrentSection = 0;
				TotalSteps = 0;
				BPMChanges = {};
				KateEngine.Song.SPS = SPS;
				local laststepcheck = 0;
				local lastclockcheck = 0;
				local lastposcheck = 0;

				-- Insert all event definitions into a table so we can use them in the song later
				local eventdefinitions = {};

				KateEngine.Song.Clock = 0;
				KateEngine.Song.Step = 0;
				KateEngine.Song.Beat = 0;
				KateEngine.Song.Section = 0;

				if songmodchart and songmodchart.EventDefinitions then
					for i,v in pairs(songmodchart.EventDefinitions) do
						eventdefinitions[i] = v;
					end
				end

				connectedevent = game:GetService("RunService").RenderStepped:Connect(function() -- Use this to more accurately time the steps
					if id ~= assigned or not KateEngine.Settings.Modcharts then
						return;
					end;

					if CurrentStep == 0 then
						CurrentStep = 1;
						CurrentBeat = 1;
						CurrentSection = 1;
						EventClock = 1;

						KateEngine.Song.Clock = 1;
						KateEngine.Song.Step = 1;
						KateEngine.Song.Beat = 1;
						KateEngine.Song.Section = 1;
					end;

					laststepcheck = tick();
					lastclockcheck = tick();

					-- This is here because PsychEngine's EventClock is based on milliseconds, rather than 20th of seconds. Made for more accurate modcharts.
					if songmodchart and songmodchart.TimeStamps then
						local songpos = Framework.SongPlayer.CurrentlyPlaying and Framework.SongPlayer.CurrentlyPlaying.TimePosition;
						songpos = songpos and songpos * 1000;
						local poscheck = lastposcheck;
						lastposcheck = songpos;
						if songpos then
							for i,v in pairs(songmodchart.TimeStamps) do
								if i > poscheck and i <= songpos then
									task.spawn(function()
										-- This is a timestamp that we need to run the function for
										-- Structure: [Timestamp] = {FunctionName, ... Arguments}
										if eventdefinitions[v[1]] then
											eventdefinitions[v[1]](Framework, unpack(v, 2));
										else
											ModchartSystem.SetLyrics("<font color='#ff2020'>Event '"..songmodchart.Events[EventClock][1].."' is not defined!</font>");
											task.delay(2, function()
												ModchartSystem.SetLyrics("");
											end);
										end
									end);
								end
							end
						end
					end

					-- An EventClock is used to tick every 1/20th of a second, regardless of the song's BPM; Made in order to accurately time events regardless of the song's BPM
					if (lastclockcheck + 0.05) > (realstart + (EventClock/20)) then
						EventClock = EventClock + 1;
						KateEngine.Song.Clock = EventClock;
						--if songmodchart and songmodchart.Clock then
						--	songmodchart.Clock(Framework, EventClock);
						--end
						callLuaState("Clock", EventClock);

						if songmodchart and songmodchart.Lyrics and (songmodchart.Lyrics["Method"] and songmodchart.Lyrics["Method"] == "Clock") and songmodchart.Lyrics[EventClock] then
							ModchartSystem.SetLyrics(songmodchart.Lyrics[EventClock]);
						end

						--todo; rewrite and remake modcharts using this later
						if songmodchart and songmodchart.Events then
							if songmodchart.Events[EventClock] then
								task.spawn(function()
									-- An event is structured like this;
									-- [EventClock] = {DefinedEvent, ... (Parameters)};
									-- Example: [1] = {"SetBPM", 100};
									if eventdefinitions[songmodchart.Events[EventClock][1]] then
										eventdefinitions[songmodchart.Events[EventClock][1]](Framework, unpack(songmodchart.Events[EventClock], 2));
									else
										ModchartSystem.SetLyrics("<font color='#ff2020'>Event '"..songmodchart.Events[EventClock][1].."' is not defined!</font>");
										task.delay(2, function()
											ModchartSystem.SetLyrics("");
										end);
									end
								end)
							end
						end
					end;

					if (laststepcheck + KateEngine.Song.SPS) > (realstart + (KateEngine.Song.SPS * CurrentStep)) then
						CurrentStep = CurrentStep + 1;
						TotalSteps = TotalSteps + 1;
						--if songmodchart and songmodchart.OnStep then
						--	KateEngine.Song.Step = TotalSteps-1;
						--	task.spawn(function()
						--		songmodchart.OnStep(Framework, TotalSteps-1);
						--	end);
						--end
						callLuaState("OnStep", TotalSteps-1);

						if songmodchart and songmodchart.Lyrics and (songmodchart.Lyrics["Method"] and songmodchart.Lyrics["Method"] == "Step") and songmodchart.Lyrics[TotalSteps-1] then
							ModchartSystem.SetLyrics(songmodchart.Lyrics[TotalSteps-1]);
						end
					else
						debugtext = "BPM: "..KateEngine.Song.BPM.."\nEvent Clock: "..EventClock.."\nStep: "..(TotalSteps-1).."\nBeat: "..(CurrentBeat-1).."\nSection: "..(CurrentSection-1).."\nSongID: "..songid;
						BPMSheet.Text = debugtext..songmodcharttext;
						return;
					end;

					if CurrentStep % 4 == 2 then -- Every 4 steps is a beat
						CurrentBeat = CurrentBeat + 1;
						KateEngine.Song.Beat = CurrentBeat;
						if songmodchart and songmodchart.IconBop then
							ModchartSystem.IconBop(KateEngine.Song.BPM, (60 / KateEngine.Song.BPM), IconP2, IconP1); -- Send the icons to the modchart to handle the bopping
						else
							BopIcons(KateEngine.Song.BPM, (60 / KateEngine.Song.BPM));
						end;
						--if songmodchart and songmodchart.OnBeat then
						--	task.spawn(function()
						--		songmodchart.OnBeat(Framework, CurrentBeat);
						--	end);
						--end
						callLuaState("OnBeat", CurrentBeat);
					else
						debugtext = "BPM: "..KateEngine.Song.BPM.."\nEvent Clock: "..EventClock.."\nStep: "..(TotalSteps-1).."\nBeat: "..(CurrentBeat-1).."\nSection: "..(CurrentSection-1).."\nSongID: "..songid;
						BPMSheet.Text = debugtext..songmodcharttext;
						return;
					end;

					-- Every 4 beats is a section
					if CurrentBeat % 4 == 2 then
						CurrentSection = CurrentSection + 1;
						KateEngine.Song.Section = CurrentSection-1;
						if defaultbumping then
							ModchartSystem.CameraZoom();
						end
						--if songmodchart and songmodchart.OnSection then
						--	task.spawn(function()
						--		songmodchart.OnSection(Framework, CurrentSection-1);
						--	end);
						--end;
						callLuaState("OnSection", CurrentSection-1);
					end;

					debugtext = "BPM: "..KateEngine.Song.BPM.."\nEvent Clock: "..EventClock.."\nStep: "..(TotalSteps-1).."\nBeat: "..(CurrentBeat-1).."\nSection: "..(CurrentSection-1).."\nSongID: "..songid;
					BPMSheet.Text = debugtext..songmodcharttext;
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

-- Misc Functions; Edit the existing stuff the framework already has in order to give a better experience overall
if not missing["setidentity"] then
	local setidentity = (type(syn) == 'table' and syn.set_thread_identity) or setidentity or setthreadcontext

	setidentity(2);

	Framework.SongPlayer.Countdown = function(self)
		Framework.SongPlayer.CountDown = true;
		local Zone = Framework.StageZone and Framework.StageZone.CurrentZone;
		local Stage = Zone and (Zone.Parent.Name:match("Stage") and Zone.Parent);
		local songid = Framework.SongPlayer.CurrentlyPlaying and Framework.SongPlayer.CurrentlyPlaying.SoundId:gsub("rbxassetid://","");
		local bpm = (Modcharts[songid] and Modcharts[songid].SetBPM) or (Stage and Stage:GetAttribute("BPM")) or 120;
		local delta = (60 / bpm);
		local countdowntext = Instance.new("ImageLabel");
		countdowntext.Name = "Countdown";
		countdowntext.BackgroundTransparency = 1;
		countdowntext.Image = "";
		countdowntext.AnchorPoint = Vector2.new(0.5, 0.5);
		countdowntext.Size = UDim2.new(0.5, 0, 0.5, 0);
		countdowntext.Position = UDim2.new(0.5, 0, 0.5, 0);
		countdowntext.Parent = IngameUI.Arrows;

		Framework.SoundHandler:Play("3", Framework.SoundService);
		task.wait(delta);
		Framework.SoundHandler:Play("2", Framework.SoundService);
		countdowntext.Image = "rbxassetid://6443228613";
		countdowntext.ImageTransparency = 0;
		TweenService:Create(countdowntext, TweenInfo.new(delta,Enum.EasingStyle.Linear), {ImageTransparency = 1}):Play();
		task.wait(delta);
		Framework.SoundHandler:Play("1", Framework.SoundService);
		countdowntext.Image = "rbxassetid://6443225217";
		countdowntext.ImageTransparency = 0;
		TweenService:Create(countdowntext, TweenInfo.new(delta,Enum.EasingStyle.Linear), {ImageTransparency = 1}):Play();
		task.wait(delta);
		Framework.SoundHandler:Play("Go", Framework.SoundService);
		countdowntext.Image = "rbxassetid://6443224742";
		countdowntext.ImageTransparency = 0;
		TweenService:Create(countdowntext, TweenInfo.new(delta,Enum.EasingStyle.Linear), {ImageTransparency = 1}):Play();
		task.wait(delta);
		Framework.SongPlayer.CountDown = false;
		countdowntext:Destroy();
	end;

	setidentity(7); -- return to default identity
end;

loadtext.Text = "Loaded - Have fun!";
task.delay(1, function()
	funkything:Destroy();
end);

Bloxstrap.SetRichPresence({
	details = "Funky Friday - In the lobby",
	timeStart = math.floor(LoadStartTime),
});

return Framework;
