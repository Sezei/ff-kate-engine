local TweenService = game:GetService("TweenService");
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
};

for _,v in pairs(PreRequisites) do
	FetchAsset(v);
end;

return {
	-- The full documentation will be open soon on the github wiki, but for now you'll have to do with the examples below I guess.

	["9134422683"] = { -- FNF - Mother
		DisableDefault = true;
		OnBeat = function(Framework, Beat)
			if Beat >= 169 and Beat <= 201 then
				Framework.KateEngine.Modcharter.CameraZoom();
			end
		end;
		OnSection = function(Framework, Section)
			Framework.KateEngine.Modcharter.CameraZoom();
		end;
	};

	["9103750413"] = { -- Salty's Legacy - Best Girl
		SetBPM = 190;
	};

	["9103763718"] = { -- Salty's Legacy - Sour n' Scary
		SetBPM = 140;
	};

	["9103758137"] = { -- Salty's Legacy - Opheebop
		SetBPM = 195;
	};

	["9103759493"] = { -- Salty's Legacy - Protect
		SetBPM = 120;
	};

	["9103753373"] = { -- Salty's Legacy - Defend
		SetBPM = 130;
	};

	["9103760328"] = { -- Salty's Legacy - Rising Star
		SetBPM = 120;
	};

	["10527124142"] = { -- Kreadian Funk - Rave 404
		EventDefinitions = {
			["Warning"] = function(Framework)
				local sprite = Framework.KateEngine.Modcharter.Sprite(FetchAsset("KF_warning.png"),UDim2.fromScale(0.5,0.5), UDim2.fromScale(1,1), 0, Vector2.new(0.5, 0.5));
				sprite.ImageTransparency = 0;
				task.wait(0.2);
				local tween = TweenService:Create(sprite, TweenInfo.new(0.3), {ImageTransparency = 1});
				tween:Play();
				tween.Completed:Wait();
				sprite:Destroy();
			end;
		};
		Events = {
			-- Ticks/Stamps are taken from the 'events.lua' modchart in the mod.
			[195*2] = {"Warning", nil};
			[243*2] = {"Warning", nil};
			[291*2] = {"Warning", nil};
			[339*2] = {"Warning", nil};
			[375*2] = {"Warning", nil};
			[567*2] = {"Warning", nil};
			[1539*2] = {"Warning", nil};
			[1587*2] = {"Warning", nil};
			[1635*2] = {"Warning", nil};
			[1659*2] = {"Warning", nil};
			[1683*2] = {"Warning", nil};
			[1695*2] = {"Warning", nil};
			[1704*2] = {"Warning", nil};
			[1710*2] = {"Warning", nil};
			[1716*2] = {"Warning", nil};
			[1719*2] = {"Warning", nil};
			[1722*2] = {"Warning", nil};
			[1725*2] = {"Warning", nil};
			[2115*2] = {"Warning", nil};
			[2127*2] = {"Warning", nil};
			[2139*2] = {"Warning", nil};
			[2151*2] = {"Warning", nil};
			[2163*2] = {"Warning", nil};
			[2175*2] = {"Warning", nil};
			[2187*2] = {"Warning", nil};
			[2199*2] = {"Warning", nil};
			[2211*2] = {"Warning", nil};
			[2223*2] = {"Warning", nil};
			[2235*2] = {"Warning", nil};
			[2247*2] = {"Warning", nil};
			[2259*2] = {"Warning", nil};
			[2271*2] = {"Warning", nil};
			[2283*2] = {"Warning", nil};
			[2295*2] = {"Warning", nil};
			[2307*2] = {"Warning", nil};
			[2319*2] = {"Warning", nil};
			[2331*2] = {"Warning", nil};
			[2343*2] = {"Warning", nil};
			[2355*2] = {"Warning", nil};
			[2367*2] = {"Warning", nil};
			[2379*2] = {"Warning", nil};
			[2391*2] = {"Warning", nil};
			[2403*2] = {"Warning", nil};
			[2415*2] = {"Warning", nil};
			[2427*2] = {"Warning", nil};
			[2439*2] = {"Warning", nil};
			[2451*2] = {"Warning", nil};
			[2463*2] = {"Warning", nil};
			[2475*2] = {"Warning", nil};
			[2487*2] = {"Warning", nil};
		};
	};

	["10482500352"] = { -- Playable Final Escape
		Clock = function(Framework, Tick)
			if Tick >= 375 then
				Framework.KateEngine.Modcharter.Health.Hurt(0.125, 1);
			end;
		end;
		NoteMiss = function(Framework, Note)
			if not Note then return end;
			if Note.Side == Framework.UI.CurrentSide then
				-- Check if it's not a GOAL note
				if Note.Type and table.find(Framework.UI.IgnoredNoteTypes, Note.Type) then return end; -- ignored note types = return
				Framework:SetKEValue("Rings", Framework:GetKEValue("Rings") - 1);
				Framework.KateEngine.Modcharter.SetLyrics(Framework:GetKEValue("Rings").." <font face='Arcade' color='#FFFF00'>O</font>");

				if Framework:GetKEValue("Rings") < 0 then
					Framework.KateEngine.Modcharter.Health.Set(0);
				end
			end
		end;
		SongStart = function(Framework)
			Framework.KateEngine.Cache["RealHealthGain"] = Framework.KateEngine.Settings["Healthbar_HealthGain"] or 5;
			Framework.KateEngine.Cache["RealHealthLoss"] = Framework.KateEngine.Settings["Healthbar_HealthLoss"] or 15;
			Framework.KateEngine.Settings["Healthbar_HealthGain"] = 2;
			Framework.KateEngine.Settings["Healthbar_HealthLoss"] = 5;

			Framework:SetKEValue("Rings", 10);
			Framework.KateEngine.Modcharter.SetLyrics("10 <font face='Arcade' color='#FFFF00'>O</font>");
		end;
		SongEnd = function(Framework)
			Framework.KateEngine.Settings["Healthbar_HealthGain"] = Framework.KateEngine.Cache["RealHealthGain"];
			Framework.KateEngine.Settings["Healthbar_HealthLoss"] = Framework.KateEngine.Cache["RealHealthLoss"];
			Framework.KateEngine.Cache["RealHealthGain"] = nil; -- Clear the cache
			Framework.KateEngine.Cache["RealHealthLoss"] = nil;
		end;
	};

	["10729979967"] = { -- Vs. LSE - Means of Destruction
		OnBeat = function(Framework, Beat)
			if Beat == 140 then
				Framework.KateEngine.Modcharter.SetAllArrows("CircularWide");
				Framework:GetEvent("ArrowDataChanged"):Fire();
			elseif Beat == 306 then
				Framework.KateEngine.Modcharter.LoadArrowsStyle();
				Framework:GetEvent("ArrowDataChanged"):Fire();
			end
		end;
	};

	["10729982629"] = { -- Vs. LSE - DAW Wars
		OnBeat = function(Framework, Beat)
			if Beat == 308 then
				Framework.KateEngine.Modcharter.SetAllArrows("CircularWide");
				Framework:GetEvent("ArrowDataChanged"):Fire();
			elseif Beat == 436 then
				Framework.KateEngine.Modcharter.LoadArrowsStyle();
				Framework:GetEvent("ArrowDataChanged"):Fire();
			end
		end;
	};

	["9103779046"] = { -- Secret Histories - Confrontation
		Lyrics = {
			["Method"] = "Step";
			[1624] = "They were impostors, Sonic!";
			[1654] = "They didn't love you";
			[1675] = "I loved you!";
			[1688] = "You think they were your friends?!";
			[1717] = "<i>I</i> WAS YOUR BEST FRIEND, SONIC!";
			[1754] = "DON'T YOU GET IT?";
			[1770] = "SONIC'S BEST FRIEND IS TAILS!";
			[1808] = "<font size='70'><u>ME!</u></font>";
			[1824] = "[Maniacal Laugher]";
			[1838] = "";
		};
	};

	["11533694882"] = { -- D-Sides - Ridge
		SetBPM = 148;
	};

	["9106848224"] = { -- Neon - Transgression
		SetBPM = 206;
	};

	["9103069682"] = { -- Hex - Glitcher
		SetBPM = 175;
	};

	["9462575360"] = { -- Hotline 024 - Uncanny Valley
		SetBPM = 170;
	};

	["9462566270"] = { -- Hotline 024 - Fun Is Infinite (Majin)
		SetBPM = 129;
	};

	["9462578694"] = { -- Hotline 024 - Casette Girl Megamix
		SetBPM = 85;
	};

	["9103346396"] = { -- Vs. Kapi: Arcade Showdown - Sanctuary
		OnStep = function(Framework, Step) -- Need precise timing for these ones xd!
			if Step == 700 or Step == 1680 then
				task.spawn(function()
					local sprite = Framework.KateEngine.Modcharter.Sprite("rbxassetid://12301335754", UDim2.fromScale(0.5,0.5), UDim2.fromScale(0.5,0.5), 5, Vector2.new(0.5, 0.5));
					sprite.ImageTransparency = 0;

					local aspectratio = Instance.new("UIAspectRatioConstraint");
					aspectratio.AspectRatio = 1;
					aspectratio.Parent = sprite;

					task.wait(0.2);
					local tween = TweenService:Create(sprite, TweenInfo.new(0.3), {ImageTransparency = 1});
					tween:Play();
					tween.Completed:Wait();
					sprite:Destroy();
				end);
			end;
		end;
	};

	["9104474200"] = { -- Vs. Bob - Run
		SetBPM = 200;
	};

	["9104471276"] = { -- Vs. Bob - Onslaugh
		PortedBy = "Sezei";
		OnBeat = function(Framework, Beat)
			-- Camera Zoom
			if Beat < 64 then
				Framework.KateEngine.Modcharter.CameraZoom();
			end;

			if Beat >= 130 and Beat <= 354 then
				-- Roll a dice to show a popup
				Framework:GetKEValue("FakeAd")();
			end;

			if Beat == 98 or Beat == 241 then
				Framework:GetKEValue("ReceptorVisible")(false);
			elseif Beat == 130 or Beat == 353 then
				Framework:GetKEValue("ReceptorVisible")(true);
			end;

			if Beat == 130 then
				Framework:GetKEValue("ROTATE")();
			end;
		end;
		SongStart = function(Framework)
			Framework:SetKEValue("FakeAd", function()
				if Framework.UI.CurrentSide == "Left" then return end;

				if math.random(1, 25) == 1 then
					-- Sprite(image, position, size, zindex, anchorpoint)
					local popup = Framework.KateEngine.Modcharter.Sprite(FetchAsset("popup"..math.random(1,11)..".png"), UDim2.fromScale(math.random(),math.random()), UDim2.fromOffset(505,298), 5, Vector2.new(0.5, 0.5));
					popup.ImageTransparency = 0;

					Framework.KateEngine.Modcharter.Sound(FetchAsset("pop_up.mp3"), 1, 1);

					task.delay(3, function()
						popup:Destroy();
					end);
				end;
			end);
			Framework:SetKEValue("ReceptorVisible", function(isVisible)
				if Framework.UI.CurrentSide == "Left" then return end;

				for i = 4, 7 do
					local note = Framework.KateEngine.Modcharter.Note(i);
					if note then
						local Frame = note.Fetch().InnerFrame;
						Frame:FindFirstChild(tostring(i-4)).Arrow.Layers.Visible = isVisible;

						if isVisible then
							Framework.KateEngine.Modcharter.Sound(FetchAsset("woeM.mp3"), 1, 1);
						elseif not isVisible then
							Framework.KateEngine.Modcharter.Sound(FetchAsset("Meow.mp3"), 1, 1);
						end;
					end;
				end;
			end);
			Framework:SetKEValue("ROTATE", function()
				if Framework.UI.CurrentSide == "Left" then return end;

				for i = 4, 7 do
					local note = Framework.KateEngine.Modcharter.Note(i);
					if note then
						local Frame = note.Fetch().InnerFrame;
						local Arrow = Frame:FindFirstChild(tostring(i-4)).Arrow.Layers;

						Arrow.Rotation = 0;
						TweenService:Create(Arrow, TweenInfo.new(
							30,
							Enum.EasingStyle.Quad,
							Enum.EasingDirection.In
							), {Rotation = 360*35}):Play();
					end;
				end;
			end);
		end;
	};

	["9398363530"] = { -- Below the Depths - Sink
		SetBPM = 140;
		DisableDefault = true;
		OnSection = function(Framework, Section)
			if Section >= 76 and Section <= 91 or Section == 106 then
				return;
			end;

			Framework.KateEngine.Modcharter.CameraZoom();
		end;
	};

	["9103362495"] = { -- Hypno's Lullaby - Safety Lullaby
		Lyrics = {
			["Method"] = "Step";
			[65] = "Come little Girlfriend, come with me!";
			[96] = "Boyfriend is waiting, steadily!";
			[128] = "";
			[192] = "Alone at night, now let us run..";
			[224] = "With Hypno, you'll have so much fun!";
			[258] = "";
			[320] = "Oh little Girlfriend, please don't cry!";
			[353] = "Hypno wouldn't hurt a fly!";
			[385] = "";
			[447] = "Your father clearly doesn't get...";
			[480] = "Deep in the forest, BF I met!";
			[512] = "";
			[576] = "Oh little Girlfriend, please don't squirm!";
			[606] = "These ropes, I know: Will hold you firm...";
			[640] = "Hypno tells you; \"This is true\"...";
			[670] = "...but sadly, Hypno lied to you!";
			[705] = "";
			[770] = "Oh little Girlfriend, you shall not leave...";
			[800] = "Your father for you will never grieve!";
			[835] = "";
			[897] = "Minds unravel at the seams...";
			[928] = "Allowing me to haunt their dreams!";
			[960] = "Surely now, you must know...";
			[991] = "That it is time for you to go!";
			[1024] = "";
			[1090] = "Oh little Girlfriend, you weren't clever...";
			[1120] = "RESISTING";
			[1130] = "<font color=\"#ffcccc\">RESISTING ME</font>";
			[1135] = "<font color=\"#ffaaaa\">RESISTING ME ONLY</font>";
			[1142] = "<font color=\"#ff8888\">RESISTING ME ONLY MAKES</font>";
			[1147] = "<font color=\"#ff5555\">RESISTING ME ONLY MAKES ME</font>";
			[1153] = "<font color=\"#ff2222\">RESISTING ME ONLY MAKES ME BITTER!</font>";
			[1186] = "";
		};
	};

	["9105940727"] = { -- shitpost test (Vs. Camellia - First Town)
		ShitpostChart = true; -- gotta make this a setting later lol
		Name = "Camellia - Pipe Town";
		Author = "Sezei";
		NoteMiss = function(Framework, Note, _, MySide)
			if MySide == true then
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
			end;
		end;
	};

	["10575657222"] = { -- Seek's Cool Deltarune Mod - In My Way
		SetBPM = 155;
		Lyrics = {
			["Method"] = "Clock";
			[694] = "[Laugher]";
			[718] = "";
			[1340] = "STOP SINGING!";
			[1365] = "";
			[1846] = "SHUT UP!";
			[1860] = "";
		};
		Clock = function(Framework, Tick)
			if Framework.UI.CurrentSide == "Left" then return end;

			if Tick == 1086 or Tick == 1365 or Tick == 1412 or Tick == 1419 or Tick == 1488 or Tick == 1520 or Tick == 1550 then
				Framework.KateEngine.Modcharter.Health.Hurt(15, 10); -- Damage, Minimum Health
				Framework:GetKEValue("ScreenShake")();
				Framework.KateEngine.Modcharter.CameraZoom(0.25);
			elseif Tick == 1645 or Tick == 1675 or Tick == 1705 or Tick == 1735 then
				Framework.KateEngine.Modcharter.Health.Hurt(20, 10);
				Framework:GetKEValue("ScreenShake")();
				Framework.KateEngine.Modcharter.CameraZoom(0.5);
			elseif Tick == 1770 or Tick == 1860 or Tick == 1876 or Tick == 1885 or Tick == 1890 or Tick == 1922 or Tick == 1984 then
				Framework.KateEngine.Modcharter.Health.Hurt(25, 10);
				Framework:GetKEValue("ScreenShake")();
				Framework.KateEngine.Modcharter.CameraZoom(0.75);
			elseif Tick == 2045 or Tick == 2090 or Tick == 2100 then
				Framework.KateEngine.Modcharter.Health.Hurt(35, 10);
				Framework:GetKEValue("ScreenShake")();
				Framework.KateEngine.Modcharter.CameraZoom(1);
			end;
		end;
		SongStart = function(Framework)
			Framework:SetKEValue("ScreenShake", function()
				for i = 4, 7 do
					local note = Framework.KateEngine.Modcharter.Note(i);
					if note then
						-- Save the Note's location
						local Frame = note.Fetch().InnerFrame;
						local savedpos = Frame.Position;

						task.spawn(function()
							Frame.Position = UDim2.fromScale((math.random(-5,5)/10), (math.random(-5,5)/10));
							Frame:TweenPosition(savedpos, "Out", "Quad", 0.25, true);
						end);
					end;
				end;
			end);
		end;
	};

	["10575656167"] = { -- Seek's Cool Deltarune Mod - HYPERLINK
		DisableDefault = true;
		OnSection = function(Framework, Section)
			if Section >= 28 and Section <= 30 then
				return;
			elseif Section == 65 or Section == 66 or Section == 85 then
				return;
			end;
			Framework.KateEngine.Modcharter.CameraZoom();
		end;
		SongStart = function(Framework)
			Framework.KateEngine.Modcharter.SetString("ScoreR", "<Score> [[PIPIS]]");
			Framework.KateEngine.Modcharter.SetString("ScoreL", "Kromer: <Score>");
		end;
		Lyrics = {
			["Method"] = "Step";
			[4] = "[[Attention customers,";
			[14] = "clean up on aisle 3]]";
			[26] = "SOMEONE LEFT THEIR";
			[27] = "OSMEONE LEFT THEIR";
			[28] = "SOMOENE LEFT THEIR";
			[29] = "SOMEONE LEFT THEIR";
			[39] = "[[HeartShapedObject]]";
			[45] = "LYING AROUND";
			[57] = "";
			[66] = "IT'S TIME TO MAKE";
			[80] = "A VERY";
			[87] = "A VREY";
			[88] = "A VYER";
			[89] = "A VERY";
			[95] = "[[Specil]]";
			[101] = "DEAL!";
			[108] = "[Laugher]";
			[128] = "";
			[272] = "[[Congratulations!]]";
			[280] = "";
			[336] = "[[3.99]]";
			[344] = "";
			[384] = "Now's your chance to be a big shot";
			[400] = "be";
			[402] = "big";
			[404] = "be";
			[406] = "big";
			[408] = "Now's your";
			[412] = "shot";
			[416] = "";
			[421] = "WHAT???";
			[429] = "ARE YOU KIDDING ME?";
			[436] = "ARE YOU KIDIDNG ME?";
			[437] = "ARE YOU KIDIDGNI ME?";
			[438] = "ARE YOU DIKDING ME?";
			[439] = "ARE YOU KIDDING ME?";
			[448] = "IT'S [[For you.]]";
			[459] = "";
			[520] = "[Laugher]";
			[528] = "Now's your chance to be a big shot";
			[542] = "[[Yeah]]";
			[544] = "Friday";
			[546] = "   da ";
			[548] = "[[Pipis]]";
			[552] = "[[Freaky on a Friday]]";
			[560] = "Now's your chance";
			[565] = "Now's your chan  ";
			[566] = "Now's your chance";
			[567] = "Now's your chan  ";
			[568] = "";
			[570] = "Friday Night";
			[576] = "Now's your chance";
			[580] = "[Now's your chance]";
			[584] = "[[Now's your chance]]";
			[585] = "";
			[586] = "[[Now's your chance]]";
			[587] = "";
			[588] = "[[Now's your chance]]";
			[589] = "";
			[590] = "[[Now's your chance]]";
			[592] = "";
			[639] = "WATCH ME FLY,";
			[656] = "[MAMA]";
			[674] = "";
			[720] = "[[Pipis]]";
			[724] = "";
			[816] = "Now's your chance to be a big shot";
			[826] = "Now's your chance to be a [[PI <s>shot</s>";
			[829] = "Now's your chance to be a [[PIPIS]]";
			[832] = "";
			[924] = "[[Ugh]]";
			[926] = "";
			[939] = "[[Ugh]]";
			[940] = "";
			[941] = "[[Ugh]]";
			[942] = "";
			[1007] = "WHAT.";
			[1018] = "IT'S FOR ME???";
			[1032] = "";
			[1216] = "[[Pipis]]";
			[1220] = "[[Pipis]] [[Pipis]]";
			[1224] = "[[Pipis]] [[Pipis]] [[Pipis]]";
			[1228] = "[[Pipis]] [[Pipis]] [[Pipis]] [[Pipis]]";
			[1232] = "";
			[1296] = "[[Earthquakes and Thunderstorms,";
			[1311] = "bass smashing through]]";
			[1321] = "";
			[1322] = "bass smashing through]]";
			[1323] = "";
			[1324] = "bass smashing through]]";
			[1325] = "";
			[1326] = "bass smashing through]]";
			[1327] = "";
			[1344] = "[[Deal or no deal]]";
			[1356] = "Deal";
			[1357] = "";
			[1358] = "Deal";
			[1359] = "";
		};
	};
};
