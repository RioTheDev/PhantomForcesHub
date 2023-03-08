if Rayfield then
    Rayfield:Destroy()
end

getgenv().Rayfield=loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

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
        Enabled = true,
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
        print(Value)
    end
})
-- Silent Aim Visibility Toggle
SilentAimTab:CreateToggle({
    Name="Visibility",
    CurrentValue=true,
    Flag="SilentAimVisEnable",
    Callback=function(Value)
        print(Value)
    end
})

-- Silent Aim Hit Part
SilentAimTab:CreateDropdown({
    Name="Hit Part",
    Options={"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg"},
    CurrentOption="Head",
    Flag="SilentAimHitPart",
    Callback=function(Value)
        print(Value)
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
        print(Value)
    end
})
--#endregion