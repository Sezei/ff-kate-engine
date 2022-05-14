--local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezei/ff-kate-engine/main/loader.lua",true))();

-- Services and Variables
local tweenservice = game:GetService("TweenService")
local gameUi = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GameUI")
local origintime = 0;
local version = "v0.2"
local prevcombo = 0
local event = game.ReplicatedStorage.RE;
local inNoMiss = false;
local SicksOnly = false;

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
watermark.Text = "Kate Engine | "..version.."\nCreated by Sezei"
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

local function CalcRating(one,two)
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
end

local function updateCombo(combo,acc,miss)
    if not miss then miss = 0 end -- bandaid for some reason
    
    local result1 = string.split(game.Players.LocalPlayer.PlayerGui.GameUI.Arrows.Stats.Text,"\n")
    local res = {};
    for k,f in pairs(result1) do
        res[k] = tonumber(string.split(f," ")[2]);
    end
    
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
    
    local accur = string.split(acc,".")
    local num = string.gsub(accur[2], "%D", "")
    
    if secondary.Text ~= "" then
        secondary.Text ..= " | "..CalcRating(tonumber(accur[1]),tonumber(num))
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
    prevcombo = combo
    
    if combo < 20 then
        return
    else
        funny.Visible = true
    end

    if combo >= 400 then
        funny.TextColor3 = Color3.new(1, 1, 0)
    elseif combo >= 300 then
        funny.TextColor3 = Color3.new(1, 1, 0.25)
    elseif combo >= 200 then
        funny.TextColor3 = Color3.new(1, 1, 0.5)
    elseif combo >= 100 then
        funny.TextColor3 = Color3.new(1, 1, 0.75)
    else
        funny.TextColor3 = Color3.new(1, 1, 1)
    end
    funny.Text = combo
    funny.TextSize = (combo >= 100 and 75 or 65)
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

gameUi.Arrows.InfoBar:GetPropertyChangedSignal("Text"):Connect(
    function()
        local t = gameUi.Arrows.InfoBar.Text
        local tt = string.split(t, " ")
        local num;

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
                task.wait(0.5)
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
                task.wait(0.5)
                topb.Text = '<font color="#ff5555">Sicks-Only failed at a combo of '..tostring(prevcombo)..'!</font>'
                task.wait(5)
                if topb.Text == '<font color="#ff5555">Sicks-Only failed at a combo of '..tostring(prevcombo)..'!</font>' then -- in case a different message appeared
                    topb.Text = ''
                end
            else
                gameUi.Arrows.InfoBar.Text = "SICKS ONLY MODE "..(tt[10])
            end
        end
    end
)

gameUi.Arrows:GetPropertyChangedSignal("Visible"):Connect(
    function()
        if gameUi.Arrows.Visible == false then
            funny.Visible = false
            inNoMiss = false;
            SicksOnly = false;
            origintime = 0;
        end
    end
)

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
        
        local function handler()
            local m = math.floor((seconds/origintime)*75)
            local s = ""
            for i=1,math.abs(m-75) do 
                s = s..string.split(txttable[1],">")[1]..'>|</font>'
            end
            for i=1,m do 
                s = s..'|'
            end
            return s
        end
        
        topb.Text = newtxt.."\n["..handler().."]"
    end
end)
gameUi.TopbarLabel:GetPropertyChangedSignal("Visible"):Connect(function()
     gameUi.TopbarLabel.Visible = false;  
end)

gameUi.SongSelector.Frame.Body.Settings.Solo.SoloInfoLabel.Visible = false;

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
NoMiss.Position = UDim2.new(0,230,0,0)

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
SicksOnlyB.Position = UDim2.new(0,460,0,0)

gameUi.SongSelector.Frame.Body.Settings.Solo:GetPropertyChangedSignal("Visible"):Connect(function() -- Don't let the people press the no-miss if it's not solo
    NoMiss.Visible = gameUi.SongSelector.Frame.Body.Settings.Solo.Visible;
    SicksOnlyB.Visible = gameUi.SongSelector.Frame.Body.Settings.Solo.Visible;
end)
gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() -- Don't let the people press the no-miss if it's not solo
    NoMiss.Visible = gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.R >= gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.G;
    SicksOnlyB.Visible = gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.R >= gameUi.SongSelector.Frame.Body.Settings.Solo.SoloPlay.BackgroundColor3.G;
end)

return gameUi
