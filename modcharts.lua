return {
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

	["10575656167"] = { -- Seek's Cool Deltarune Mod - HYPERLINK
		Lyrics = {
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
			[670] = "[MAMAA]";
			[671] = "[MAMAAAA]";
			[672] = "[MAMAAAAAAAA]";
			[673] = "[MAMAAAAAAAAAA]";
			[674] = "";
			[720] = "[[Pipis]]";
			[724] = "";
			[816] = "Now's your chance to be a big shot";
			[826] = "Now's your chance to be a <font color='#ffff00'>[[PI</font> shot";
			[829] = "Now's your chance to be a [[PI<font color='#ffff00'>PIS]]</font>";
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
		}
	}
}
