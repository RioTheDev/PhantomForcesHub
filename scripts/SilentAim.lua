
local playerSvc = game:GetService("Players")

local localPlayer = playerSvc.LocalPlayer
local camera = workspace.CurrentCamera
local shared = getrenv().shared

assert(shared.require,"Require not working lolz")
local network = shared.require("network")
local trajectory = shared.require("physics").trajectory
local bulletAcceleration = shared.require("PublicSettings").bulletAcceleration
local entryTable = debug.getupvalue(shared.require("ReplicationInterface").getEntry, 1);

local SilentAim = {fov=math.huge,hitpart="head",isVisible=true}
if oldSilentAim then
    network.send=oldSilentAim
end

local function isVisible(position)
    return #camera:GetPartsObscuringTarget({ position }, { workspace.Terrain, workspace.Ignore, camera }) == 0;
end

local function getClosest(fov,bodypartName,isVis)
    local _distance = fov or math.huge
    local _bodypart = nil
    local _player = nil
    for player,entry in next,entryTable do
        if player and entry and player.Team ~=localPlayer.Team then
            local thirdpersonObj = entry and entry:getThirdPersonObject()
            local bodypart = thirdpersonObj and thirdpersonObj:getBodyPart(bodypartName)
            if bodypart then
                if isVis and isVisible(bodypart.Position) then
                    continue
                end       
                local screenpos, onscreen = camera:WorldToViewportPoint(bodypart.Position)
                local middle = camera.ViewportSize/2
                local distance = (Vector2.new(screenpos.X,screenpos.Y)-middle).Magnitude
                if onscreen and distance and distance<_distance then
                    _distance=distance
                    _bodypart=bodypart
                    _player=player
                end
            end
        end
    end
    return _bodypart,_player
end
local old=network.send

function SilentAim:Enable()
    function network:send(name,...)
        local args = {...}
        if name=="newbullets" then
            local bodypartTable ={"head","torso","larm","rarm","lleg","rleg"} 

            local part = if SilentAim.hitpart=="Random" then bodypartTable[math.random(1,#bodypartTable)] else SilentAim.hitpart
            print(part)
            local bodypart,player = getClosest(SilentAim.fov,part,SilentAim.isVisible)
            if bodypart and player then
                local bullets = args[1]["bullets"]
                local firepos = args[1]["firepos"]

                local velocity = trajectory(firepos,bulletAcceleration,bodypart.Position,bullets[1][1].Magnitude)
                for _,bullet in bullets do
                    bullet[1]=velocity
                end
                
                old(self,name,table.unpack(args))

                for _, bullet in bullets do
                    old(self,"bullethit",player,bodypart.Position,bodypart.Name,bullet[2],self:getTime())
                end
                return
            end
        end
        return old(self,name,...)
    end
end

function SilentAim:Disable()
    network.send=old
end
getgenv().oldSilentAim=old
return SilentAim