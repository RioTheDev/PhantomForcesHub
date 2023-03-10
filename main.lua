

local SilentAim = loadstring(game:HttpGet("https://raw.githubusercontent.com/RioTheDev/EnergyAssaultHub/master/scripts/SilentAim.lua"))()
local Rayfield=loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
print(SilentAim)

local clearStr="\n"
for i = 1, 60, 1 do
    clearStr..="\n"
end
print(clearStr)

-- Window
local Window = Rayfield:CreateWindow({
    Name="Rio's Hub",
    LoadingTitle="Loading Rio's Hub",
    LoadingSubtitle="By RIO#8750",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = "RioHub",
        FileName = "Rios Hub"
     },
})

--#region SilentAim
-- Silent Aim Tab
local SilentAimTab = Window:CreateTab("Legit")

-- Silent Aim Toggle
SilentAimTab:CreateToggle({
    Name="Enable",
    CurrentValue=false,
    Flag="SilentAimEnable",
    Callback=function(Value)
        if Value then
            SilentAim:Enable()
        else
            SilentAim:Disable()
        end
    end
})
-- Silent Aim Visibility Toggle
SilentAimTab:CreateToggle({
    Name="Visibility",
    CurrentValue=true,
    Flag="SilentAimVisEnable",
    Callback=function(Value)
        SilentAim.isVisible=Value
    end
})

-- Silent Aim Hit Part
local drop = SilentAimTab:CreateDropdown({
    Name="Hit Part",
    Options={"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg","Random"},
    CurrentOption="Head",
    Flag="SilentAimHitPart",
    Callback=function(Value)
        local hitpartDic = {
            Head="head",
            Torso="torso",
            ["Left Arm"]="larm",
            ["Right Arm"]="rarm",
            ["Left Leg"]="lleg",
            ["Right Leg"]="rleg",
        }
        if Value=="Random" then
            SilentAim["hitpart"]="Random"
            return
        end
        SilentAim["hitpart"]=hitpartDic[Value]
    end
})


--Silent Aim FOV
SilentAimTab:CreateSlider({
    Name="FOV",
    Range={10,1000},
    Increment=10,
    CurrentValue=1000,
    Suffix="Pixels",
    Flag="SilentAimFOV",
    Callback=function(Value)
        SilentAim["fov"]=Value
    end
})
--#endregion