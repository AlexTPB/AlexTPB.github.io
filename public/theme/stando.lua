setfpscap(999)

local uis = game:GetService("UserInputService")
local ABDSound = {}
ABDSound.Sounds = {}
local TweenService = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local debounce = false
local l = game:GetService("Lighting")
local chr = plr.Character
local HumanoidRootPart1 = game.Players.LocalPlayer.Character.HumanoidRootPart
local getLighting = game:GetService("Lighting")
local PunchDeb = false
local LpHum = plr.Character.Humanoid
local mouse = plr:GetMouse()
local BlockingDeb = false
local BarrageDeb = false
local HealBarrageDeb = false
local s = chr:WaitForChild("Stand")
local sh = s:WaitForChild("Stand Head")
local stor = s:WaitForChild("Stand Torso")
local sra = s:WaitForChild("Stand Right Arm")
local sla = s:WaitForChild("Stand Left Arm")
local srl = s:WaitForChild("Stand Right Leg")
local sll = s:WaitForChild("Stand Left Leg")
local shum = s:WaitForChild("StandHumanoidRootPart")
local rs = game:GetService("ReplicatedStorage")
local Mode_Cancel = false
local debounceMode3 = false
local debounceMode = false
local OldCFrame = nil
local debounceMode2 = false
local debounceModeLegit = true
local h = chr["Head"]
local tor = chr["Torso"]
local ra = chr["Right Arm"]
local la = chr["Left Arm"]
local rl = chr["Right Leg"]
local ll = chr["Left Leg"]
local deb = false
local IntValue = Instance.new("IntValue")
local IntroDeb = false
local Int_Val_Mod = 0
local Invisible = false
local hum = chr.Humanoid
local hrp = chr.HumanoidRootPart
local death = false
local deathevent = rs.Death
local deletestand = nil
local doppioslam = game.ReplicatedStorage.DoppioSlam
local sg = game:GetService("StarterGui")
local strongpunchevent = rs.PlayerStrongPunch
local w = game.Workspace
local rST = game.ReplicatedStorage
local p = game.Players.LocalPlayer
local m = p:GetMouse()
local rser = game:GetService("RunService")
local move = false
local D11S = rST.Damage11Sans
local D3 = rST.Damage3
local D12S = rST.Damage12Sans
local D11 = rST.Damage11
local VD = rST.VampireDash
local D12 = rST.Damage12
local ACH = rST.Anchor
local debris = game:GetService("Debris")
local STWC = rST.STWRTZClient

local Players = game:GetService("Players")

local blacklist = {
	"ActiveDefenseSystemX",
	"Atem_1735",
	"ClIowny",
	"xXbluecubeXx",
	"LightDeadpanAdmin5",
	"kennyjeopardy",
	"Puddest",
	"AsteroidBelt1",
	"Flickitfar",
	"Staranen",
	"good1005",
	"finlay546",
	"YuuzuRinn",
	"aquiferouss",
	"mothematical",
	"asceius",
	"xdzero_0",
	"Shi1bo",
	"LiteralRCM",
	"kur_Dev",
	"Lornalla",
	"PerilousWind",
	"Ask4more",
	"CharcoalFlavored",
	"exbini"
}

Players.PlayerAdded:Connect(function(player)
   if table.find(blacklist, player.Name) then
	   if death == true then return end
       Players.LocalPlayer:Kick("Blacklisted player has just joined the server.")
   end
end)

for i,v in pairs(game.Players:GetChildren())do
	if table.find(blacklist, v.Name) then
		if death == true then return end
		Players.LocalPlayer:Kick("Blacklisted player is in the server.")
	end
end

for i, v in pairs(getLighting:GetChildren()) do
    for i, v2 in pairs(chr:GetChildren()) do
        if v:IsA("LocalScript") and v2:IsA("LocalScript") then
            if v.Name == v2.Name then
                deletestand = v2.Name
            end
        end
    end
end

chr[deletestand]:Destroy()

local function Asset(Id)
    return "rbxassetid://" .. tostring(Id)
end

local MainSoundSystem = {
    ["Sounds"] = {},
    ["Preloaded"] = {}
}
function MainSoundSystem:Execute(Arguments)
    if Arguments["Action"] == "Preload" then
        local Audio = Instance.new("Sound")
        Audio.Parent = game.ReplicatedStorage
        Audio.SoundId = "rbxassetid://" .. Arguments["Id"]
        game.ContentProvider:PreloadAsync({ Audio })
        repeat
            game.RunService.RenderStepped:Wait()
        until Audio.TimeLength and Audio.TimeLength > 0
        table.insert(MainSoundSystem["Preloaded"], { Arguments["Id"], Audio.TimeLength })
        Audio:Destroy()
    elseif Arguments["Action"] == "Create" then
        MainSoundSystem:Execute({
            ["Action"] = "Preload",
            ["Id"] = Arguments["Id"]
        })
        if MainSoundSystem:Execute({ ["Action"] = "Return", ["Request"] = "IsPlaying", ["Id"] = Arguments["Id"] }) then
            MainSoundSystem:Execute({
                ["Action"] = "Destroy",
                ["Id"] = Arguments["Id"]
            })
        end
        local SoundSystem = {
            ["Id"] = Arguments["Id"],
            ["Pitch"] = Arguments["Pitch"] or 1,
            ["Volume"] = Arguments["Volume"] or 10,
            ["Loop"] = Arguments["Loop"] or false,
            ["StartPosition"] = Arguments["StartPosition"] or 0,
            ["CFrame"] = Arguments["CFrame"] or game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"),
            ["Begin"] = tick(),
            ["Break"] = false,
            ["CoolDown"] = false
        }
        SoundSystem["TimeLength"] = MainSoundSystem:Execute({
            ["Action"] = "Return",
            ["Request"] = "TimeLength",
            ["Id"] = Arguments["Id"]
        })
        if SoundSystem["CFrame"] and SoundSystem["TimeLength"] then
            MainSoundSystem["Sounds"]["rbxassetid://" .. Arguments["Id"]] = SoundSystem
            function SoundSystem:Execute(SoundArguments)
                if not SoundSystem["CoolDown"] then
                    if SoundArguments["Action"] == "FixTimePosition" then
                        rser.RenderStepped:Wait()
                        SoundArguments["Audio"].TimePosition = SoundSystem["StartPosition"] +
                            ((tick() - SoundSystem["Begin"]) * SoundSystem["Pitch"])
                    elseif SoundArguments["Action"] == "Create" then
                        if not game.Lighting.TS.Value then
                            if game.PlaceId == 2686500207 then
                                game.ReplicatedStorage.Damage11Sans:FireServer(
                                    game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"),
                                    SoundSystem["CFrame"].CFrame, 0.00001, 0, Vector3.new(), 9e999,
                                    "rbxassetid://" .. Arguments["Id"], SoundSystem["Pitch"], SoundSystem["Volume"])
                            elseif game.PlaceId == 7040744449 then
                                game.ReplicatedStorage.Damage12:FireServer(
                                    game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"),
                                    SoundSystem["CFrame"].CFrame, 0.00001, 0, Vector3.new(), 9e999,
                                    "rbxassetid://" .. Arguments["Id"], SoundSystem["Pitch"], SoundSystem["Volume"])
                            end
                        end
                    elseif SoundArguments["Action"] == "Play" then
                        local function Play()
                            SoundSystem["Begin"] = (tick() - 0.014)
                            for Index = 1, SoundArguments["Updates"] do
                                if SoundSystem["Break"] or not SoundSystem then
                                    break
                                end
                                SoundSystem:Execute({
                                    ["Action"] = "Create"
                                })
                                task.wait(0.69625)
                            end
                            if not SoundSystem["Break"] and SoundSystem and SoundSystem["Loop"] then
                                SoundSystem["StartPosition"] = 0
                                SoundArguments["Updates"] = math.ceil(((SoundSystem["TimeLength"] / 0.69625) / SoundSystem["Pitch"]))
                                Play()
                            else
                                SoundSystem:Execute({
                                    ["Action"] = "Break"
                                })
                                MainSoundSystem["Sounds"]["rbxassetid://" .. Arguments["Id"]] = nil
                                System = nil
                            end
                        end
                        Play()
                    elseif SoundArguments["Action"] == "Break" then
                        SoundSystem["Break"] = true
                        SoundSystem["CoolDown"] = true
                    elseif SoundArguments["Action"] == "Change" then
                        SoundSystem[SoundArguments["Change"]] = SoundArguments["Value"]
                    end
                end
            end

            if (SoundSystem["TimeLength"] - SoundSystem["StartPosition"]) <= 0.69625 then
                SoundSystem:Execute({
                    ["Action"] = "Create"
                })
            elseif (SoundSystem["TimeLength"] - SoundSystem["StartPosition"]) > 0.69625 then
                task.spawn(function()
                    SoundSystem:Execute({
                        ["Action"] = "Play",
                        ["Updates"] = math.ceil(((SoundSystem["TimeLength"] - SoundSystem["StartPosition"]) / 0.69625) / SoundSystem["Pitch"])
                    })
                end)
            end
        end
    elseif Arguments["Action"] == "Destroy" then
        if Arguments["Id"] ~= "All" then
            for Id, System in next, MainSoundSystem["Sounds"] do
                if System["Id"] == Arguments["Id"] then
                    System["Loop"] = false
                    System:Execute({
                        ["Action"] = "Break"
                    })
                    MainSoundSystem["Sounds"][Id] = nil
                    System = nil
                end
            end
        else
            for Id, System in next, MainSoundSystem["Sounds"] do
                System["Loop"] = false
                System:Execute({
                    ["Action"] = "Break"
                })
                MainSoundSystem["Sounds"][Id] = nil
                System = nil
            end
            MainSoundSystem["Sounds"] = {}
        end
    elseif Arguments["Action"] == "Change" then
        if Arguments["Id"] ~= "All" then
            for Id, System in next, MainSoundSystem["Sounds"] do
                if System["Id"] == Arguments["Id"] then
                    System:Execute({
                        ["Action"] = "Change",
                        ["Change"] = Arguments["Change"],
                        ["Value"] = Arguments["Value"]
                    })
                end
            end
        else
            for Id, System in next, MainSoundSystem["Sounds"] do
                System:Execute({
                    ["Action"] = "Change",
                    ["Change"] = Arguments["Change"],
                    ["Value"] = Arguments["Value"]
                })
            end
        end
    elseif Arguments["Action"] == "Return" then
        if Arguments["Request"] == "Preloaded" then
            for Index, Table in next, MainSoundSystem["Preloaded"] do
                if Table[1] == Arguments["Id"] then
                    return true
                end
            end
            return false
        elseif Arguments["Request"] == "TimeLength" then
            for Index, Table in next, MainSoundSystem["Preloaded"] do
                if Table[1] == Arguments["Id"] then
                    return Table[2]
                end
            end
            return nil
        elseif Arguments["Request"] == "IsPlaying" then
            for Id, System in next, MainSoundSystem["Sounds"] do
                if System["Id"] == Arguments["Id"] then
                    return true
                end
            end
            return false
        end
    end
end

game.Workspace.Effects.DescendantAdded:Connect(function(Object)
    if Object.ClassName == "Sound" then
        if MainSoundSystem["Sounds"][Object.SoundId] then
            MainSoundSystem["Sounds"][Object.SoundId]:Execute({
                ["Action"] = "FixTimePosition",
                ["Audio"] = Object
            })
        end
    end
end)

hum.HealthChanged:connect(function()
    if hum.Health < 1 then
        rs.RTZ:FireServer(false)
        wait(0.1)
        hum:SetStateEnabled(3, false)
        hum:SetStateEnabled(15, false)
        deathevent:FireServer(false)
        wait(0.1)
        death = true
        rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,
            "rbxassetid://5083223890", 1, 20)
		trans1()
    end
end)

local GUIConnections = {}

function RemakeMenuGui(AbilityName, PowerStat, SpeedStat, DurabilityStat)
    local Returner = {}
    pcall(function()
        for Index, Connection in GUIConnections do
            if Connection then
                Connection:Disconnect()
            end
        end
        GUIConnections = {}
    end)
    local function MouseOver(GuiObject, EnterText, LeaveText)
        local Left = false
        local Enter = GuiObject.MouseEnter:Connect(function()
            local Index = 1
            GuiObject.Text = EnterText[Index]
            coroutine.resume(coroutine.create(function()
                if #EnterText ~= 1 then
                    repeat
                        wait(0.4)
                        Index = Index + 1
                        GuiObject.Text = EnterText[Index]
                        if Index == #EnterText then
                            Index = 0
                        end
                    until Left == true
                end
            end))
        end)
        table.insert(GUIConnections, Enter)
        local Leave = GuiObject.MouseLeave:Connect(function()
            Left = true
            GuiObject.Text = LeaveText
        end)
        table.insert(GUIConnections, Leave)
    end
    if plr.PlayerGui:FindFirstChild("MenuGUI") then
        if plr.PlayerGui.MenuGUI:FindFirstChild("Background") then
            for Index, Child in next, plr.PlayerGui.MenuGUI.Background:GetChildren() do
                if Child:IsA("TextLabel") then
                    if Child.Name == "Power" then
                        Child.Visible = false
                        local Clone = Child:Clone()
                        Clone.Name = "NewStat_" .. Child.Name
                        Clone.Parent = Child.Parent
                        Clone.Visible = true
                        Clone.Text = "Destructive Power"
                        MouseOver(Clone, PowerStat, "Destructive Power")
                        Child:Destroy()
                        Returner.Power = Clone
                    elseif Child.Name == "Speed" then
                        Child.Visible = false
                        local Clone = Child:Clone()
                        Clone.Name = "NewStat_" .. Child.Name
                        Clone.Parent = Child.Parent
                        Clone.Visible = true
                        Clone.Text = "Speed"
                        MouseOver(Clone, SpeedStat, "Speed")
                        Child:Destroy()
                        Returner.Speed = Clone
                    elseif Child.Name == "Durability" then
                        Child.Visible = false
                        local Clone = Child:Clone()
                        Clone.Name = "NewStat_" .. Child.Name
                        Clone.Parent = Child.Parent
                        Clone.Visible = true
                        Clone.Text = "Durability"
                        MouseOver(Clone, DurabilityStat, "Durability")
                        Child:Destroy()
                        Returner.Durability = Clone
                    elseif Child.Name == "Ability" then
                        Child.Visible = false
                        local Clone = Child:Clone()
                        Clone.Name = "NewStat_" .. Child.Name
                        Clone.Parent = Child.Parent
                        Clone.Visible = true
                        Clone.Text = AbilityName
                        Child:Destroy()
                        Returner.Ability = Clone
                    end
                end
            end
        end
    end
    if Returner.Power then
        return Returner
    else
        return nil
    end
end

RemakeMenuGui("Shadow SIGMA\n Platinum Over GYATT", { "🤑" }, { "🤑" }, { "🤑" })

rser.RenderStepped:Connect(function()
    for i, v in pairs(hrp:GetDescendants()) do
        if v:IsA("BodyVelocity") or v:IsA("BodyPosition") or v:IsA("BodyAngularVelocity") or v:IsA("BodyForce") or v:IsA("BodyGyro") or v:IsA("BodyThrust") then
            v:Destroy()
        end
    end

	for index, Descendant in pairs(chr:GetDescendants()) do
        if Descendant:IsA("Part") or Descendant:IsA('UnionOperation') or Descendant:IsA('MeshPart') then
            Descendant.Anchored = false
        end
    end
	rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), false)
	rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Head"), false)
	rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Torso"), false)
	rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Left Arm"), false)
	rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Right Arm"), false)
	rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Left Leg"), false)
	rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Right Leg"), false)
end)

coroutine.resume(coroutine.create(function()
    print("coroutine")
    chr = game.Players.LocalPlayer.Character
    Human = chr.Humanoid

    Human:SetStateEnabled(3, true) -- Enables Jumping
    lleg = chr["Left Leg"]
    rleg = chr["Right Leg"]
    larm = chr["Left Arm"]
    rarm = chr["Right Arm"]
    head = chr["Head"]
    tors = chr["Torso"]
    hrp = chr["HumanoidRootPart"]
    rs = game:GetService("ReplicatedStorage")
    a = rs.Anchor
    Stand = chr.Stand

	while rser.Stepped:Wait() do
		Human.PlatformStand = false
		chr.Ragdoll.Value = false
		chr.Disabled.Value = false
		Human.AutoRotate = true
	end
end))

--[[
rser.RenderStepped:Connect(function()
    for i, v in pairs(hrp:GetDescendants()) do
        if v:IsA("BodyVelocity") or v:IsA("BodyPosition") or v:IsA("BodyAngularVelocity") or v:IsA("BodyForce") or v:IsA("BodyGyro") or v:IsA("BodyThrust") then
			v:Destroy()
			wait(0.1)
			v:Destroy()
        end
    end

    for index, Descendant in pairs(chr:GetDescendants()) do
        if Descendant:IsA("Part") or Descendant:IsA('UnionOperation') or Descendant:IsA('MeshPart') then
            Descendant.Anchored = false
        end
    end
end)
]]

function NanHp()
    game:GetService("ReplicatedStorage").Block:FireServer(true)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    game.ReplicatedStorage.GravityShift:FireServer(hum, math.huge * 0)
    --game:GetService("ReplicatedStorage").BurnDamage:FireServer(Humanoid, CFrame.new(0, -50, 0), - 0 * math.huge, 0, Vector3.new(0, 0, 0), "rbxassetid://241837157", 0, Color3.new(255, 255, 255), "rbxassetid://260430079", 0, 0)
    --wait()
    --game:GetService("ReplicatedStorage").BurnDamage:FireServer(Humanoid, CFrame.new(0, -50, 0), 0 * math.huge, 0, Vector3.new(0, 0, 0), "rbxassetid://241837157", 0, Color3.new(255, 255, 255), "rbxassetid://260430079", 0, 0)
end

NanHp()

--[[
function gokuintro()
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	R_Punch = Instance.new("Animation")
	R_Punch.AnimationId = Asset(5621883393)
	R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
	R_PunchAnim:Play()
	MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 3367974639, ["Volume"] = math.huge, ["Loop"] = false })
	wait(0.5)
	MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 4471125043, ["Volume"] = math.huge, ["Loop"] = false })
	for i = 1,10 do
		game:GetService("ReplicatedStorage").Damage12Sans:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 0.6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		wait(0.01)
	end
	wait(0.5)
	MainSoundSystem:Execute({ ["Action"] = "Destroy", ["Id"] = 4471125043 })
	MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 4471125043, ["Volume"] = math.huge, ["Loop"] = false })
	for i = 1,5 do
		game:GetService("ReplicatedStorage").Damage12Sans:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 0.6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ReversedJump:FireServer(BrickColor.new("White"))
		wait(0.2)
	end
	R_PunchAnim:Stop()
	wait(0.5)
	MainSoundSystem:Execute({ ["Action"] = "Destroy", ["Id"] = 4471125043 })
	MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 4471125043, ["Volume"] = math.huge, ["Loop"] = false })
	for i = 1,5 do
		game:GetService("ReplicatedStorage").Damage12Sans:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 0.6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ULFDamage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 6, "", 1, 1)
		game:GetService("ReplicatedStorage").ReversedJump:FireServer(BrickColor.new("White"))
	end
	hum.WalkSpeed = 16
	hum.JumpPower = 50
end
gokuintro()
wait(0.5)
]]
function trans1()
    for i, v in pairs(game.Players.LocalPlayer.Character.Stand:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Texture") or v:IsA("Decal") then
            if v.Name == "StandHumanoidRootPart" then
                game.ReplicatedStorage.Transparency:FireServer(v, 1)
            else
                game.ReplicatedStorage.Transparency:FireServer(v, 1)
            end
        end
    end
end

function trans0()
    for i, v in pairs(game.Players.LocalPlayer.Character.Stand:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Texture") or v:IsA("Decal") then
            if v.Name == "StandHumanoidRootPart" then
                game.ReplicatedStorage.Transparency:FireServer(v, 1)
            else
                game.ReplicatedStorage.Transparency:FireServer(v, 0.4)
            end
        end
    end
end

--this was spoh
function legstrans()
    game.ReplicatedStorage.Transparency:FireServer(
        game.Players.LocalPlayer.Character.Stand:FindFirstChild("Stand Left Leg"), 1)
    game.ReplicatedStorage.Transparency:FireServer(
        game.Players.LocalPlayer.Character.Stand:FindFirstChild("Stand Right Leg"), 1)
    for i, v in pairs(game.Players.LocalPlayer.Character.Stand:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Texture") or v:IsA("Decal") then
            if v.Name == "shoe" then
                game.ReplicatedStorage.Transparency:FireServer(v, 1)
            end
        end
    end
    for i, v in pairs(game.Players.LocalPlayer.Character.Stand:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Texture") or v:IsA("Decal") then
            if v.Name == "band" and v.Material == "Glass" then
                game.ReplicatedStorage.Transparency:FireServer(v, 1)
            end
        end
    end
end
--[[
--crazy diamond
function legstrans()
    game.ReplicatedStorage.Transparency:FireServer(
        game.Players.LocalPlayer.Character.Stand:FindFirstChild("Stand Left Leg"), 1)
    game.ReplicatedStorage.Transparency:FireServer(
        game.Players.LocalPlayer.Character.Stand:FindFirstChild("Stand Right Leg"), 1)
    for i, v in pairs(game.Players.LocalPlayer.Character.Stand.lleg:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Texture") or v:IsA("Decal") then
			game.ReplicatedStorage.Transparency:FireServer(v, 1)
        end
    end
	for i, v in pairs(game.Players.LocalPlayer.Character.Stand.rleg:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Texture") or v:IsA("Decal") then
			game.ReplicatedStorage.Transparency:FireServer(v, 1)
        end
    end
end
--gold experience
function legstrans()
    game.ReplicatedStorage.Transparency:FireServer(
        game.Players.LocalPlayer.Character.Stand:FindFirstChild("Stand Left Leg"), 1)
    game.ReplicatedStorage.Transparency:FireServer(
        game.Players.LocalPlayer.Character.Stand:FindFirstChild("Stand Right Leg"), 1)
	for i, v in pairs(game.Players.LocalPlayer.Character.Stand:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Texture") or v:IsA("Decal") then
            if v.Name == "Part" then
                game.ReplicatedStorage.Transparency:FireServer(v, 1)
            end
        end
    end
end
]]

function idle()
	r6 = Instance.new("Animation")
	r6.AnimationId = Asset(180435571)
	r6Anim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(r6)
	r6Anim:Play()
end
idle()
--[[
function FunnyIntro()
local mathSinVal = 0
G_Punch = Instance.new("Animation")
G_Punch.AnimationId = Asset(5621883393)
G_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(G_Punch)
G_PunchAnim:Play()
rs.RTZEffect:FireServer()
MainSoundSystem:Execute({["Action"] = "Create",["Id"] = 3367974639,["Volume"] = math.huge,["Loop"] = false})
for i = 1,90 do
wait(0.001)
mathSinVal = mathSinVal + 0.01
rs.Damage11:FireServer(hum, hrp.CFrame * CFrame.new(math.sin(mathSinVal * 5)*5, math.cos(mathSinVal * 25)*2, math.sin(mathSinVal * 10)*11), 0, 0, Vector3.new(0, 0, 0), 0.01, "rbxassetid://6398250128", 1, 0)
rs.Damage11:FireServer(hum, hrp.CFrame * CFrame.new(math.sin(mathSinVal * 4)*12, math.cos(mathSinVal * 25)*2, math.sin(mathSinVal * 4)*18), 0, 0, Vector3.new(0, 0, 0), 0.01, "rbxassetid://6398250128", 1, 0)
rs.Damage11:FireServer(hum, hrp.CFrame * CFrame.new(math.sin(mathSinVal * 5)*18, math.cos(mathSinVal * 25)*2, math.sin(mathSinVal * 10)*11), 0, 0, Vector3.new(0, 0, 0), 0.02, "rbxassetid://6398250128", 1, 0)
rs.Damage11:FireServer(hum, hrp.CFrame * CFrame.new(math.sin(mathSinVal * 5)*5, math.cos(mathSinVal * 25)*2, math.sin(mathSinVal * 8)*18), 0, 0, Vector3.new(0, 0, 0), 0.01, "rbxassetid://6398250128", 1, 0)
rs.Damage11:FireServer(hum, hrp.CFrame * CFrame.new(math.sin(mathSinVal * 5)*7, math.cos(mathSinVal * 25)*5, math.sin(mathSinVal * 10)*10), 0, 0, Vector3.new(0, 0, 0), 0.01, "rbxassetid://6398250128", 1, 0)
end
task.wait(4.896)
game:GetService("ReplicatedStorage").RTZ:FireServer(true)
G_PunchAnim:Stop()
end
FunnyIntro()
--]]

local tera = true
local posing = false
function jojopose()
    if posing == false then
        posing = true
		--musics {original rock music 9042632936, tacobot-3000 9245552700, its raining tacos 142376088, cool rock 1837853076, sta4 music 9245361730}
        rs.Menacing:FireServer(true)
        poseanimation = Instance.new("Animation")
        poseanimation.AnimationId = "rbxassetid://5624096541"
        poseanim = plr.Character.Humanoid:LoadAnimation(poseanimation)
        poseanim:Play()
        hum.WalkSpeed = 0
        hum.JumpPower = 0
        wait(1)
        poseanim:AdjustSpeed(0)
        wait(0.1)
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 9042632936, ["Volume"] = 5, ["Loop"] = true, ["Cooldown"] = true })
        Active = true
        --repeat
        --wait()
        --game.ReplicatedStorage.Damage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(2.5,6,5), 1, 0, Vector3.new(), "", 2, Color3.fromHSV(tick() % 2 / 2, 1, 1), "", 0, 0)
        --game.ReplicatedStorage.Damage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(-0.5,6,5), 1, 0, Vector3.new(), "", 2, Color3.fromHSV(tick() % 2 / 2, 1, 1), "", 0, 0)
        --game.ReplicatedStorage.Damage:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(-3.5,6,5), 1, 0, Vector3.new(), "", 2, Color3.fromHSV(tick() % 2 / 2, 1, 1), "", 0, 0)
        --until Active == false
    else
        MainSoundSystem:Execute({ ["Action"] = "Destroy", ["Id"] = 9042632936 })
        rs.Menacing:FireServer(false)
        poseanim:Stop()
        hum.WalkSpeed = 16
        hum.JumpPower = 50
        posing = false
        Active = false
    end
end

--[[nvm this is only for twoh
function sigmaknife()
	knife = Instance.new("Animation")
	knife.AnimationId = Asset(3445785160)
	knifeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(knife)
	knifeAnim:Play()
	wait(0.1)
	game.ReplicatedStorage.OHKnife:FireServer()
end
]]

function notimestopmonkey()
	for Index, Instance in pairs(game.Lighting:GetChildren()) do
		if Instance.ClassName == "BoolValue" then
			Instance.Changed:Connect(function()
				if Instance.Value == true then
					if death == true then return end
					game.ReplicatedStorage.RTZEffect:FireServer(true)
					R_Punch = Instance.new("Animation")
					R_Punch.AnimationId = Asset(3445811665)
					R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
					R_PunchAnim:Play()
					wait(1.5)
					R_PunchAnim:Stop()
					Instance.Value = false
				end
			end)
		end
	end
end

notimestopmonkey()

function standjump()
	R_Punch = Instance.new("Animation")
	R_Punch.AnimationId = Asset(3445780399)
	R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
	R_PunchAnim:Play()
	R_PunchAnim:AdjustSpeed(0)
	rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,"rbxassetid://157878578", 1, 10)
	local standjump = Instance.new("BodyPosition", game.Players.LocalPlayer.Character.Torso)
	standjump.maxForce = Vector3.new(100000, 100000, 100000)
	standjump.Position = (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame) * CFrame.new(0, 50, -75).p
	rs.Jump:FireServer(BrickColor.new("Institutional white"))
	wait(0.2)
	R_PunchAnim:Stop()
	wait(0.4)
	standjump:Destroy()
end

function bdmg1()
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (stor.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                game.ReplicatedStorage.Damage2:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 99, 0,
                    Vector3.new(0, 0, 0), 0.05, "rbxassetid://7269543118", 1, 20)
                game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 99, 0,
                    Vector3.new(0, 0, 0), 9e999, "rbxassetid://6011094380", 1, 20)
            end
        end
    end
end

function healbarrage()
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (stor.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                game.ReplicatedStorage.Heal6:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 300, 0.25,
                    Vector3.new(0, 0, 0), 0.25, "", 1.2, 1)
                game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 1e-320, 0,
                    hrp.CFrame.LookVector * 50, 9e999, "", 1, 20)
            end
        end
    end
end

function rtz()
	attackpose = Instance.new("Animation")
	attackpose.AnimationId = Asset(2876970625)
	attackposeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(attackpose)
	attackposeAnim:Play()
    G_Punch = Instance.new("Animation")
    G_Punch.AnimationId = Asset(14016033850)
    G_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(G_Punch)
    G_PunchAnim:Play()
    G_PunchAnim:AdjustSpeed(1.5)
    rs.RTZEffect:FireServer()
    hum.WalkSpeed = 0
    hum.JumpPower = 0
    MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 3367974639, ["Volume"] = math.huge, ["Cooldown"] = true })
    wait(2)
    rs.RealityOverwriteArm:FireServer(true)
    MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 2652099910, ["Volume"] = math.huge, ["Cooldown"] = true })
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (hrp.Position - v.HumanoidRootPart.Position).Magnitude < 100 then
                for i = 1, 30 do
                    rs.Knock:FireServer(v.Humanoid)
                    game.ReplicatedStorage.Damage3:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 99, 0.1,
                        Vector3.new(0, 60, 0), 0.05, "rbxassetid://7269543118", 1, 20)
                    game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 1e-320, 0.1,
                        Vector3.new(0, 50, 0), 9e999, "rbxassetid://157878578", 1, 20)
                end
            end
        end
    end
    hum.WalkSpeed = 16
    hum.JumpPower = 50
	attackposeAnim:Stop()
end

function smite()
	attackpose = Instance.new("Animation")
	attackpose.AnimationId = Asset(2876970625)
	attackposeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(attackpose)
	attackposeAnim:Play()
    G_Punch = Instance.new("Animation")
    G_Punch.AnimationId = Asset(3166494872)
    G_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(G_Punch)
    G_PunchAnim:Play()
    hum.WalkSpeed = 5
    hum.JumpPower = 0
    MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 2553993071, ["Volume"] = math.huge, ["Cooldown"] = true })
    wait(1.5)
    rs.RealityOverwriteArm:FireServer(true)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (hrp.Position - v.HumanoidRootPart.Position).Magnitude < 140 then
                rs.Slam:FireServer()
                for i = 1, 10 do
                    rs.Knock:FireServer(v.Humanoid)
                    game.ReplicatedStorage.Damage3:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 99, 0.1,
                        Vector3.new(0, 60, 0), 0.05, "", 1, 20)
                    game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 1e-320, 0.1,
                        Vector3.new(0, 50, 0), 9e999, "", 1, 20)
                end
            end
        end
    end
    hum.WalkSpeed = 16
    hum.JumpPower = 50
end

local function kamevisual()
	for i = 1,55 do
		rs.PlayerStrongPunch:FireServer(Vector3.new(1, 40, 1), Vector3.new(0.5, 12, 0.5), BrickColor.new("Institutional white"))
		wait(0.01)
	end
end
local usingkamehameha = false

function kamehameha()
	if usingkamehameha == false then
		usingkamehameha = true
		hum.WalkSpeed = 0
		hum.JumpPower = 0
		MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 9100023087, ["Volume"] = math.huge, ["StartPosition"] = 0.1 })
		R_Punch = Instance.new("Animation")
		R_Punch.AnimationId = Asset(3558779904)
		R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
		R_PunchAnim:Play()
		for i = 1, 23 do
			game.ReplicatedStorage.Damage12Sans:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character["Right Arm"].CFrame, 0, 0, Vector3.new(), 0.03, "", 1, 0)
			wait(0.01)
		end
		R_PunchAnim:AdjustSpeed(0)
		for i = 1, 85 do
			game.ReplicatedStorage.Damage12Sans:FireServer(game.Players.LocalPlayer.Character.Humanoid, game.Players.LocalPlayer.Character["Right Arm"].CFrame, 0, 0, Vector3.new(), 0.03, "", 1, 0)
			wait(0.01)
		end
		R_PunchAnim:AdjustSpeed(2)
		wait(0.2)
		R_PunchAnim:AdjustSpeed(0)
		local hitbox1 = Instance.new("Part", game.workspace.Effects)
		hitbox1.Anchored = true
		hitbox1.CFrame = game.Players.LocalPlayer.Character["HumanoidRootPart"].CFrame * CFrame.new(0, 0, -120)
		hitbox1.Name = "hitbox"
		hitbox1.CanCollide = false
		hitbox1.Size =  Vector3.new(15,15,250)
		hitbox1.Massless = true
		hitbox1.Transparency = 0.8
		wait(0.4)
		local weld = Instance.new("WeldConstraint",hitbox1)
		hitbox1.Anchored = false
		weld.Part0 = hitbox1
		weld.Part1 = game.Players.LocalPlayer.Character["HumanoidRootPart"]
		MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 8899285496, ["Volume"] = math.huge })
		hum.WalkSpeed = 0
		hum.JumpPower = 0
		spawn(kamevisual)
		hitbox1.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= game.Players.LocalPlayer.Name then
				if hit.Parent:FindFirstChild("HumanoidRootPart") then
					for i = 1, 5 do
						if not hit.Parent:FindFirstChild("HumanoidRootPart") then return end
						game.ReplicatedStorage.Damage2:FireServer(hit.Parent.Humanoid, hit.Parent.HumanoidRootPart.CFrame, 99, 0, Vector3.new(0, 0, 0), 0.2, "", 1, math.huge)
						rs.Damage11Sans:FireServer(hit.Parent.Humanoid, hit.Parent.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,"rbxassetid://8899285496", 1, 10)
						wait(1)
						rs.Damage11Sans:FireServer(hit.Parent.Humanoid, hit.Parent.HumanoidRootPart.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,"rbxassetid://8899285496", 1, 10)
					end
				end
			end
		end)
		wait(3.5)
		if hitbox1 then
			hitbox1:Destroy()
		end
		hum.WalkSpeed = 16
		hum.JumpPower = 50
		R_PunchAnim:AdjustSpeed(2)
	usingkamehameha = false
	end
end

function uppercut()
    R_Punch = Instance.new("Animation")
    R_Punch.AnimationId = Asset(5635099356)
    R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
    R_PunchAnim:Play()
    R_PunchAnim:AdjustSpeed(2)
    game.ReplicatedStorage.Damage11Sans:FireServer(hum, hrp.CFrame, 99, 0.1, Vector3.new(), 9e999,
        "rbxassetid://4774842889", 1, 20)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (hrp.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                rs.Knock:FireServer(v.Humanoid)
                game.ReplicatedStorage.Damage3:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 45, 0.1,
                    Vector3.new(0, 60, 0), 0.05, "rbxassetid://7269543118", 1, 20)
                game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 1e-320, 0.1,
                    Vector3.new(0, 50, 0), 9e999, "rbxassetid://175024455", 1, 20)
            end
        end
    end
end

function impale()
	attackpose = Instance.new("Animation")
	attackpose.AnimationId = Asset(2876970625)
	attackposeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(attackpose)
	attackposeAnim:Play()
	R_Punch = Instance.new("Animation")
	R_Punch.AnimationId = Asset(5563162928)
	R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
	R_PunchAnim:Play()
	MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 5515252943, ["Pitch"] = 1, ["Volume"] = 10, ["Loop"] = false, ["Cooldown"] = true })
	wait(0.7)
	for i, v in pairs(game.Workspace.Entities:GetChildren()) do
		if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
			if (tor.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
				for i = 1, 20 do
					game.ReplicatedStorage.VampireDamage:FireServer(v.Humanoid, 119.9, 0.25, Vector3.new(0, -0, -0))
					rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,"rbxassetid://4988625180", 0.8, 10)
				end
			end
		end
	end
end

function kick()
    R_Punch = Instance.new("Animation")
    R_Punch.AnimationId = Asset(4782250127)
    R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
    R_PunchAnim:Play()
    R_PunchAnim:AdjustSpeed(1)
    game.ReplicatedStorage.Damage11Sans:FireServer(hum, hrp.CFrame, 99, 0.1, Vector3.new(), 9e999,
        "rbxassetid://4774842889", 1, 20)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (hrp.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                rs.Knock:FireServer(v.Humanoid)
                game.ReplicatedStorage.Damage3:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 40, 0.1,
                    Vector3.new(0, 30, 0), 0.05, "rbxassetid://7269543118", 1, 20)
                game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 1e-320, 0.1,
                    Vector3.new(0, 50, 0), 9e999, "rbxassetid://175024455", 1, 20)
            end
        end
    end
end

function stwdashpunch()
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (hrp.Position - v.HumanoidRootPart.Position).Magnitude < 3 then
                game.ReplicatedStorage.Damage3:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 60, 0.1,
                    hrp.CFrame.LookVector * 50, 0.1, "rbxassetid://7269543118", 1, 20)
                game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 1e-320, 0.1,
                    Vector3.new(), 9e999, "rbxassetid://1837829473", 1, 20)
            end
        end
    end
end

local punchvalue = 0

function standpunch()
    punchvalue += 1
    if punchvalue == 1 then
		attackpose = Instance.new("Animation")
		attackpose.AnimationId = Asset(2876970625)
		attackposeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(attackpose)
		attackposeAnim:Play()
        L_Punch = Instance.new("Animation")
        L_Punch.AnimationId = Asset(2876963877)
        L_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(L_Punch)
        L_PunchAnim:Play()
        rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,
            "rbxassetid://200632136", 1, 3)
        for i, v in pairs(game.Workspace.Entities:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
                if (hrp.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                    game.ReplicatedStorage.Damage3:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 12.5, 0.1,
                        Vector3.new(0, 0, 0), 0.05, "rbxassetid://6011094380", 1, 10)
                end
            end
        end
		attackposeAnim:Stop()
    elseif punchvalue == 2 then
		attackpose = Instance.new("Animation")
		attackpose.AnimationId = Asset(2876970625)
		attackposeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(attackpose)
		attackposeAnim:Play()
        R_Punch = Instance.new("Animation")
        R_Punch.AnimationId = Asset(2876963057)
        R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
        R_PunchAnim:Play()
        rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,
            "rbxassetid://200632136", 1, 3)
        for i, v in pairs(game.Workspace.Entities:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
                if (hrp.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                    game.ReplicatedStorage.Damage3:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 12.5, 0.1,
                        Vector3.new(0, 0, 0), 0.05, "rbxassetid://6011094380", 1, 10)
                end
            end
        end
		attackposeAnim:Stop()
        punchvalue = 0
    end
end

function slap()
    R_Punch = Instance.new("Animation")
    R_Punch.AnimationId = Asset(4774749466)
    R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
    R_PunchAnim:Play()
    R_PunchAnim:AdjustSpeed(1)
    game.ReplicatedStorage.Damage11Sans:FireServer(hum, hrp.CFrame, 99, 0.1, Vector3.new(), 9e999,
        "rbxassetid://5925552387", 1, 20)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (hrp.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                rs.Knock:FireServer(v.Humanoid)
                game.ReplicatedStorage.Damage3:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 20, 0.1,
                    hrp.CFrame.LookVector * 10, 0.05, "rbxassetid://7269543118", 1, 20)
                game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 1e-320, 0.1,
                    hrp.CFrame.LookVector * 50, 9e999, "rbxassetid://175024455", 1, 20)
            end
        end
    end
end

function clickattack()
    R_Punch = Instance.new("Animation")
    R_Punch.AnimationId = Asset(4774879706)
    R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
    R_PunchAnim:Play()
    R_PunchAnim:AdjustSpeed(1)
    game.ReplicatedStorage.Damage11Sans:FireServer(hum, hrp.CFrame, 99, 0.1, Vector3.new(), 9e999,
        "rbxassetid://200632136", 1.25, 20)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (hrp.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                game.ReplicatedStorage.Damage3:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 10, 0.1,
                    Vector3.new(0, -10, 0), 0.05, "rbxassetid://7269543118", 1, 20)
                game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 1e-320, 0.1,
                    Vector3.new(), 9e999, "rbxassetid://8595980577", 1, 20)
            end
        end
    end
end

function healpunch()
    R_Punch = Instance.new("Animation")
    R_Punch.AnimationId = Asset(3587456538)
    R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
    R_PunchAnim:Play()
    R_PunchAnim:AdjustSpeed(1)
    task.wait(0.7)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (stor.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                game.ReplicatedStorage.Heal6:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 300, 0.25,
                    Vector3.new(0, 0, 0), 0.25, "", 1.2, 1)
                game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 1e-320, 0,
                    hrp.CFrame.LookVector * 50, 9e999, "", 1, 20)
            end
        end
    end
end

function overwrite()
	attackpose = Instance.new("Animation")
	attackpose.AnimationId = Asset(2876970625)
	attackposeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(attackpose)
	attackposeAnim:Play()
    R_Punch = Instance.new("Animation")
    R_Punch.AnimationId = Asset(2876986199)
    R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
    R_PunchAnim:Play()
    R_PunchAnim:AdjustSpeed(1)
    task.wait(1)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (stor.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                for i = 1, 20 do
                    game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 99, 0.1,
                        hrp.CFrame.LookVector * 50, 9e999, "rbxassetid://1202656211", 1, 50)
                    game.ReplicatedStorage.Damage5:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 99, 0.3,
                        Vector3.new(9999, 0, 0), 0.1, "rbxassetid://1846163746", 1, 50)
                    rs.Knock:FireServer(v.Humanoid)
                end
            end
        end
    end
	attackposeAnim:Stop()
end

function punch()
	attackpose = Instance.new("Animation")
	attackpose.AnimationId = Asset(2876970625)
	attackposeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(attackpose)
	attackposeAnim:Play()
    R_Punch = Instance.new("Animation")
    R_Punch.AnimationId = Asset(2876947195)
    R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
    R_PunchAnim:Play()
    R_PunchAnim:AdjustSpeed(1)
    task.wait(0.6)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (stor.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                game.ReplicatedStorage.Damage11Sans:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 99, 0.1,
                    hrp.CFrame.LookVector * 50, 9e999, "rbxassetid://6011094380", 1, 20)
                game.ReplicatedStorage.Damage3:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 99, 0,
                    Vector3.new(9999, 0, 0), 0.1, "rbxassetid://157878578", 0.5, 20)
                rs.Knock:FireServer(v.Humanoid)
            end
        end
    end
	attackposeAnim:Stop()
end

function heal()
	attackpose = Instance.new("Animation")
	attackpose.AnimationId = Asset(2876970625)
	attackposeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(attackpose)
	attackposeAnim:Play()
    R_Punch = Instance.new("Animation")
    R_Punch.AnimationId = Asset(2876947195)
    R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
    R_PunchAnim:Play()
    R_PunchAnim:AdjustSpeed(1)
    task.wait(0.6)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (stor.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                rs.Heal7:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, math.huge * 0, 0,
                    Vector3.new(0, 0, 0), 0.1, "rbxassetid://", 1, 20)
            end
        end
    end
end

function brehwatisthis()
    wry = Instance.new("Animation")
    wry.AnimationId = Asset(2876965810)
    WRRYY = hum:LoadAnimation(wry)
    WRRYY:Play()
    hum.WalkSpeed = 0
    hum.JumpPower = 0
    MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 5736107502, ["Volume"] = math.huge, ["Cooldown"] = true })
    task.wait(1.5)
    hum.WalkSpeed = 16
    hum.JumpPower = 50
    for i = 1, 8 do
        for i, v in pairs(game.workspace.Entities:GetChildren()) do
            if v:FindFirstChild("Humanoid") then
                rs.Anchor:FireServer(v:FindFirstChild("Torso"), true)
                rs.Anchor:FireServer(v:FindFirstChild("Head"), true)
                rs.Anchor:FireServer(v:FindFirstChild("Right Arm"), true)
                rs.Anchor:FireServer(v:FindFirstChild("Left Arm"), true)
                rs.Anchor:FireServer(v:FindFirstChild("Right Leg"), true)
                rs.Anchor:FireServer(v:FindFirstChild("Left Leg"), true)
				rs.Anchor:FireServer(v:FindFirstChild("HumanoidRootPart"), true)
                --local player
                rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Torso"), false)
                rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Head"), false)
                rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Right Arm"), false)
                rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Left Arm"), false)
                rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Right Leg"), false)
                rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("Left Leg"), false)
				rs.Anchor:FireServer(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), false)
            end
        end
        rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,
            "rbxassetid://903267862", 1, math.huge)
        task.wait(1)
    end
    MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 7950167096, ["Volume"] = math.huge, ["Cooldown"] = true })
    task.wait(2)
    for i, v in pairs(game.workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") then
            rs.Anchor:FireServer(v:FindFirstChild("Torso"), false)
            rs.Anchor:FireServer(v:FindFirstChild("Head"), false)
            rs.Anchor:FireServer(v:FindFirstChild("Right Arm"), false)
            rs.Anchor:FireServer(v:FindFirstChild("Left Arm"), false)
            rs.Anchor:FireServer(v:FindFirstChild("Right Leg"), false)
            rs.Anchor:FireServer(v:FindFirstChild("Left Leg"), false)
			rs.Anchor:FireServer(v:FindFirstChild("HumanoidRootPart"), false)
        end
    end
end

function blooddamage()
    R_Punch = Instance.new("Animation")
    R_Punch.AnimationId = Asset(4775746784)
    R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
    R_PunchAnim:Play()
    R_PunchAnim:AdjustSpeed(1)
    game.ReplicatedStorage.Damage11Sans:FireServer(hum, hrp.CFrame, 99, 0.1, Vector3.new(), 9e999,
        "rbxassetid://4775664015", 1, 20)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (tor.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                for i = 1, 7 do
                    game.ReplicatedStorage.VampireDamage:FireServer(v.Humanoid, 119.9, 0.25, Vector3.new(0, -0, -0))
                end
            end
        end
    end
    task.wait(0.27)
    MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 4775664015, ["Volume"] = math.huge, ["Cooldown"] = true })
    task.wait(1.83)
    R_PunchAnim:Stop()
end

function bloodsuck()
    R_Punch = Instance.new("Animation")
    R_Punch.AnimationId = Asset(3675049044)
    R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
    R_PunchAnim:Play()
    R_PunchAnim:AdjustSpeed(1)
    game.ReplicatedStorage.Damage11Sans:FireServer(hum, hrp.CFrame, 99, 0.1, Vector3.new(), 9e999,
        "rbxassetid://300208109", 1, 20)
    task.wait(0.8)
    for i, v in pairs(game.Workspace.Entities:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
            if (tor.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
                blooddamage()
            end
        end
    end
	R_PunchAnim:Stop()
end

----modes
local summonval = 0
local summon = false
plr:GetMouse().KeyDown:Connect(function(key)
    if key == "q" then
        if death == true then return end
        summonval = summonval + 1
        if summonval == 1 then
            game.ReplicatedStorage.Damage11Sans:FireServer(game.Players.LocalPlayer.Character.Humanoid,
                game.Players.LocalPlayer.Character.Head.CFrame * CFrame.new(0, 0.85, -0.1), 0.0001, 0,
                Vector3.new(9e999, 9e999, 0), 0.0025, "rbxassetid://463010917", 1, 20)
            summon = true
			if nothing then
			nothingAnim:Stop()
			end
			idle = Instance.new("Animation")
			idle.AnimationId = Asset(5565685756)
			idleAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(idle)
			idleAnim:Play()
            trans0()
            legstrans()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SummonFX"):FireServer()
        end
        if summonval == 2 then
			idleAnim:Stop()
			nothing = Instance.new("Animation")
			nothing.AnimationId = Asset(3445813188)
			nothingAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(nothing)
			nothingAnim:Play()
            trans1()
            summonval = 0
            summon = false
        end
    end
end)
_G.aurausing = false
----- universal stuff
plr:GetMouse().KeyDown:Connect(function(key)
    if key == "n" then
        if death == true then return end
        local args = {
            [1] = game.Players.LocalPlayer.Character:FindFirstChild("Head"),
            [2] = "rbxassetid://2740829879",
            [3] = math.huge,
            [4] = 5,
            [5] = 0,
        }

        game:GetService("ReplicatedStorage").Taunt:FireServer(unpack(args))
    end
    if key == "c" then
        if death == true then return end
        rs.VampireDash:FireServer(BrickColor.new("Really black"))
        local args = {[1] = {["MousePos"] = Vector3.new(mouse.hit.p.X, mouse.hit.p.Y + 1, mouse.hit.p.Z)}}
        game:GetService("ReplicatedStorage"):WaitForChild("SPOHTP"):FireServer(unpack(args))
		--plr.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.hit.p.X, mouse.hit.p.Y + 1, mouse.hit.p.Z)
    end
	if key == "b" then
        if death == true then return end
		if _G.aurausing == false then
			rs.Menacing:FireServer(true)
			emoting = Instance.new("Animation")
			emoting.AnimationId = Asset(5243891580)
			emotingAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(emoting)
			emotingAnim:Play()
			emotingAnim:AdjustSpeed(2)
			MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 9245361730, ["Volume"] = 5, ["Loop"] = true, ["Cooldown"] = true })
			_G.aurausing = true
		elseif _G.aurausing == true then
			rs.Menacing:FireServer(false)
			emotingAnim:Stop()
			MainSoundSystem:Execute({ ["Action"] = "Destroy", ["Id"] = 9245361730 })
			_G.aurausing = false
		end
    end
end)
-----
local yess = false
plr:GetMouse().KeyDown:Connect(function(key)
    if key == "y" then
        if summon == true then return end
        if death == true then return end
        bloodsuck()
    end
	if key == "f" then
        if summon == true then return end
        if death == true then return end
        kamehameha()
    end
    if key == "t" then
        if summon == true then return end
        if death == true then return end
        uppercut()
    end
    if key == "e" then
        if summon == true then return end
        if death == true then return end
        slap()
    end
    if key == "g" then
        if yess == true then yess = false end
        if summon == true then return end
        if death == true then return end
        G_Punch = Instance.new("Animation")
        G_Punch.AnimationId = Asset(4814777086)
        G_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(G_Punch)
        G_PunchAnim:Play()
        G_PunchAnim:AdjustSpeed(1)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
        wait(1)
        game.ReplicatedStorage.Damage11Sans:FireServer(hum, hrp.CFrame, 99, 0.1, Vector3.new(), 9e999,
            "rbxassetid://5612141890", 1, 20)
        coroutine.resume(coroutine.create(function()
            repeat
                task.wait()
                stwdashpunch()
            until yess == true
        end))
        local Boost = Instance.new("BodyVelocity")
        Boost.Name = "BaBaBoeySpeed"
        Boost.MaxForce = Vector3.new(100000, 0, 100000)
        Boost.P = math.huge
        Boost.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 85
        Boost.Parent = game.Players.LocalPlayer.Character.Torso
        wait(0.8)
        yess = true
        game.Players.LocalPlayer.Character.Torso.BaBaBoeySpeed:Destroy()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
    if key == "r" then
        if summon == true then return end
        if death == true then return end
        kick()
    end
end)
mouse.Button1Down:Connect(function()
    if summon == true then return end
    if death == true then return end
    clickattack()
end)
---stand on
plr:GetMouse().KeyDown:Connect(function(key)
	if key == "z" then
        if summon == false then return end
        if death == true then return end
        standjump()
    end
    if key == "p" then
        if summon == false then return end
        if death == true then return end
        jojopose()
    end
    if key == "f" then
        if summon == false then return end
        if death == true then return end
        brehwatisthis()
    end
    if key == "t" then
        if summon == false then return end
        if death == true then return end
        rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,
            "rbxassetid://2553993071", 1, 10)
        overwrite()
    end
    if key == "r" then
        if summon == false then return end
        if death == true then return end
        rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,
            "rbxassetid://5121719889", 1, 10)
        punch()
    end
    if key == "=" then
        if summon == false then return end
        if death == true then return end
        rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,
            "rbxassetid://5121719889", 1, 10)
        heal()
    end
    if key == "u" then
        if summon == false then return end
        if death == true then return end
        impale()
    end
    if key == "h" then
        if summon == false then return end
        if death == true then return end
        rtz()
    end
    if key == "g" then
        if summon == false then return end
        if death == true then return end
        smite()
    end
end)
mouse.Button1Down:Connect(function()
    if summon == false then return end
    if death == true then return end
    standpunch()
end)
--block
uis.InputBegan:Connect(function(Input, IsTyping)
    if IsTyping then return end
    if Input.KeyCode == Enum.KeyCode.X then
        if summon == false then return end
        if death == true then return end
		if BlockingDeb == true then return end
        barrageanimation = Instance.new("Animation")
        barrageanimation.AnimationId = Asset(2876961881)
        barrageanim = plr.Character.Humanoid:LoadAnimation(barrageanimation)
        barrageanim:Play()
        rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,"rbxassetid://648479338", 1, 2)
		game:GetService("ReplicatedStorage").Deflect:FireServer(true)
		BlockingDeb = true
    end
end)
uis.InputEnded:Connect(function(Input, IsTyping)
    if IsTyping then return end
    if Input.KeyCode == Enum.KeyCode.X then
        if summon == false then return end
        if death == true then return end
        barrageanim:Stop()
		game:GetService("ReplicatedStorage").Deflect:FireServer(false)
        BlockingDeb = false
    end
end)

--barrages
uis.InputBegan:Connect(function(Input, IsTyping)
    if IsTyping then return end
    if Input.KeyCode == Enum.KeyCode.E then
        if summon == false then return end
        if death == true then return end
        if BarrageDeb == true then
            BarrageDeb = false
        end
		attackpose = Instance.new("Animation")
		attackpose.AnimationId = Asset(2876970625)
		attackposeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(attackpose)
		attackposeAnim:Play()
        barrageanimation = Instance.new("Animation")
        barrageanimation.AnimationId = Asset(2763936707)
        barrageanim = plr.Character.Humanoid:LoadAnimation(barrageanimation)
        barrageanim:Play(0.1, 1, 2.5)
        barrageanim:AdjustSpeed(2)
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 2899837055, ["Volume"] = math.huge, ["Cooldown"] = true })
        repeat
            bdmg1()
            barrageanim:Play(0.1, 1, 2.5)
            barrageanim:AdjustSpeed(3)
            task.wait(0.1)
        until BarrageDeb == true
    end
end)
uis.InputEnded:Connect(function(Input, IsTyping)
    if IsTyping then return end
    if Input.KeyCode == Enum.KeyCode.E then
        if summon == false then return end
        if death == true then return end
        MainSoundSystem:Execute({ ["Action"] = "Destroy", ["Id"] = 2899837055 })
		attackposeAnim:Stop()
        barrageanim:Stop()
        BarrageDeb = true
    end
end)
uis.InputBegan:Connect(function(Input, IsTyping)
    if IsTyping then return end
    if Input.KeyCode == Enum.KeyCode.Y then
        if summon == false then return end
        if death == true then return end
        if HealBarrageDeb == true then
            HealBarrageDeb = false
        end
		attackpose = Instance.new("Animation")
		attackpose.AnimationId = Asset(2876970625)
		attackposeAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(attackpose)
		attackposeAnim:Play()
        barrageanimation = Instance.new("Animation")
        barrageanimation.AnimationId = Asset(2763936707)
        barrageanim = plr.Character.Humanoid:LoadAnimation(barrageanimation)
        barrageanim:Play(0.1, 1, 2.5)
        barrageanim:AdjustSpeed(2)
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 2899837055, ["Volume"] = math.huge, ["Cooldown"] = true })
        repeat
            healbarrage()
            barrageanim:Play(0.1, 1, 2.5)
            barrageanim:AdjustSpeed(3)
            task.wait(0.1)
        until HealBarrageDeb == true
    end
end)
uis.InputEnded:Connect(function(Input, IsTyping)
    if IsTyping then return end
    if Input.KeyCode == Enum.KeyCode.Y then
        if summon == false then return end
        if death == true then return end
        MainSoundSystem:Execute({ ["Action"] = "Destroy", ["Id"] = 2899837055 })
		attackposeAnim:Stop()
        barrageanim:Stop()
        HealBarrageDeb = true
    end
end)
-----
--[[ new remotes yipee!!!
rs.Damage:FireServer(v.Humanoid, v.HumanoidRootPart.CFrame, 25, 0, Vector3.new(0,0,0), "rbxassetid://241837157", 0.075, Color3.new(255,255,255), "rbxassetid://8704616653", 1, 3.5)
rs.RoadRollerSlam:FireServer(hum, 1e-320, 6, Vector3.new(9e999,9e999,0))
rs.CalculatedStrike:FireServer(hum, hrp.CFrame, 0, 0, Vector3.new(0, 0, 0), 999999999, "rbxassetid://298181829", 1, 5)
rs.Heal6:FireServer(Target.Character.Humanoid, Target.Character.HumanoidRootPart.CFrame, math.huge*0, 0, Vector3.new(0, 0, 0), 0.1, "rbxassetid://5020631118", 1, 20)
--]]
--coroutine.resume(coroutine.create(function()
--repeat
--wait(0.4)
--d12s:FireServer(hum,h.CFrame, 0, 0, Vector3.new(0, 0, -1), 0.2, "", 0.1, 20)
--end))
--game.ReplicatedStorage.PlayerStrongPunch:FireServer(Vector3.new(.1,.1,.1),Vector3.new(1,10,1),BrickColor.new("Institutional white")) strong punch effect
----MainSoundSystem:Execute({["Action"] = "Create",["Id"] = 4463899554,["Volume"] = math.huge})
--[[ if u wanna make a combo
function createWeld(obj1, obj2)
local weld = Instance.new("WeldConstraint", obj1)
weld.Part0 = obj1
weld.Part1 = obj2
end

function createHitbox(obj, sizeMult)
local hitbox = Instance.new("Part", chr)
hitbox.Name = "hitbox"
hitbox.CFrame = obj.CFrame
hitbox.Anchored = false
hitbox.Transparency = 1
hitbox.Size = obj.Size * sizeMult
hitbox.Massless = true
hitbox.CanCollide = false
hitbox.Color = Color3.new(0,0,0)
createWeld(hitbox, obj)
return hitbox
end

local debounce = false
local moveactive = false
function slapkick()
if not moveactive then
     moveactive = true
     poseanimation = Instance.new("Animation")
     poseanimation.AnimationId = "rbxassetid://2763936707"
     slapanim = plr.Character.Humanoid:LoadAnimation(poseanimation)
     slapanim:Play(0.1, 1, 2)
     task.wait(0.15)
     local hb = createHitbox(ra, 1.3)
     local plrHit = {}
     hb.Touched:Connect(function(hit)
        if hit.parent:FindFirstChild("Humanoid") and hit.parent.Name ~= plr.Name and not debounce then
            debounce = true
            if not table.find(plrHit, hit.parent) then
                table.insert(plrHit, hit.parent)
                D11S:FireServer(hit.parent.Humanoid, hit.parent.HumanoidRootPart.CFrame, 30, 0, Vector3.new(0, 0, 0), 0.001, "rbxassetid://9076225494", 1, 5)
                D3:FireServer(hit.parent.Humanoid, hit.parent.HumanoidRootPart.CFrame, 30, 0.5, Vector3.new(0, 30, 10), 0.01, "rbxassetid://1921987900", 1, 20)
                rs.Damage:FireServer(hit.parent.Humanoid, hit.parent.HumanoidRootPart.CFrame, 15, 0.3, hrp.CFrame.LookVector*20.5, "rbxassetid://241837157", 0.075, Color3.new(255,255,255), "rbxassetid://8704616653", 1, 3.5)
             end
        end
         debounce = false
     end)
     debris:AddItem(hb, 0.4)
     task.wait(0.4)

     poseranimation = Instance.new("Animation")
     poseranimation.AnimationId = "rbxassetid://3804938028"
     highkickanim = plr.Character.Humanoid:LoadAnimation(poseranimation)
     highkickanim:Play(0.1, 2, 3)
     local hb2 = createHitbox(rl, 1.5)
     local plrHit2 = {}
     hb2.Touched:Connect(function(hit)
        if hit.parent:FindFirstChild("Humanoid") and hit.parent.Name ~= plr.Name and not debounce then
            debounce = true
            if not table.find(plrHit2, hit.parent) then
                table.insert(plrHit2, hit.parent)
                D11S:FireServer(hit.parent.Humanoid, hit.parent.HumanoidRootPart.CFrame, 30, 0, Vector3.new(0, 0, 0), 0.001, "rbxassetid://6265148218", 1, 5)
                D3:FireServer(hit.parent.Humanoid, hit.parent.HumanoidRootPart.CFrame, 30, 0.5, Vector3.new(0, 30, 10), 0.01, "rbxassetid://1921987900", 1, 20)
                rs.Damage:FireServer(hit.parent.Humanoid, hit.parent.HumanoidRootPart.CFrame, 15, 0.3, hrp.CFrame.LookVector*20.5, "rbxassetid://241837157", 0.075, Color3.new(255,255,255), "rbxassetid://8704616653", 1, 3.5)
                rs.Knock:FireServer(hit.parent.Humanoid)
             end
        end
         debounce = false
     end)
     debris:AddItem(hb2, 0.4)
     task.wait(0.4)
     moveactive = false
end
end]]
--[[if u wanna make a kamehameha sort of attack
local gammaraydeb = false
function gammarayburst()
	pcall(function()
		G_Punch = Instance.new("Animation")
		G_Punch.AnimationId = Asset(3923038092)
		G_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(G_Punch)
		G_PunchAnim:Play()
		local fxpos = 0
		game.ReplicatedStorage.Damage11Sans:FireServer(hum, hrp.CFrame, 99, 0, Vector3.new(0, 0, 0), 1e-320, "rbxassetid://5835032207", 1, 20)
		local hitbox1 = Instance.new("Part",game.Players.LocalPlayer.Character)
		hitbox1.CFrame = hrp.CFrame
		hitbox1.Name = "hitbox"
		hitbox1.Anchored = false
		hitbox1.CanCollide = false
		local weld = Instance.new("WeldConstraint",hitbox1)
		weld.Part0 = hitbox1
		weld.Part1 = hrp
		hitbox1.Size = Vector3.new(50,10,12)
		hitbox1.Massless = true
		hitbox1.Transparency = 1
		hitbox1.Color = Color3.new(0,0,0)
		coroutine.resume(coroutine.create(function()
			repeat
				wait()
				if fxpos>=30 then
					fxpos=0
				end
				fxpos=fxpos+3
				game.ReplicatedStorage.Damage12Sans:FireServer(game.Players.LocalPlayer.Character.Humanoid,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,0,0,Vector3.new(0,0,0),0.17,"",0,0)
				game.ReplicatedStorage.Damage12Sans:FireServer(game.Players.LocalPlayer.Character.Humanoid,hitbox1.CFrame*CFrame.new(fxpos,0,0),0,0,Vector3.new(0,0,0),0.1,"",0,0)
				game.ReplicatedStorage.Damage12Sans:FireServer(game.Players.LocalPlayer.Character.Humanoid,hitbox1.CFrame*CFrame.new(-fxpos,0,0),0,0,Vector3.new(0,0,0),0.1,"",0,0)
			until gammaraydeb == true
		end))
		hitbox1.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= game.Players.LocalPlayer.Name then
				if hit.Parent:FindFirstChild("HumanoidRootPart") then
					--local A_1 = hit.Parent.Humanoid
					--local A_2 = hit.Parent.HumanoidRootPart.CFrame
					--local A_3 = 0 -- Damage value, dont go above 99, on burn damage you can go to inf
					--local A_4 = 0.25 -- Every attack inserts a new instance of a velocity in the torso, this is the duration of the velocity its limit is 10
					--local A_5 = plr.Character.HumanoidRootPart.CFrame.LookVector*300+Vector3.new(0,0,0)
					--local A_6 = "rbxassetid://"
					--local A_7 = 0.075
					--local A_8 = Color3.new(255, 0, 255)
					--local A_9 = "rbxassetid://0"
					--local A_10 = 0.9
					--local A_11 = 0.44
					--local Event = game:GetService("ReplicatedStorage").Damage
					--Event:FireServer(A_1, A_2, A_3, A_4, A_5, A_6, A_7, A_8, A_9, A_10, A_11)
					game.ReplicatedStorage.Damage3:FireServer(hit.Parent.Humanoid, hit.Parent.HumanoidRootPart.CFrame, 99, 0, Vector3.new(0, 0, 0), 0.1, "rbxassetid://9117969584", 1, 20)
					game.ReplicatedStorage.Damage11Sans:FireServer(hit.Parent.Humanoid, hit.Parent.HumanoidRootPart.CFrame, 99, 0, Vector3.new(0, 0, 0), 1e-320, "rbxassetid://5801257793", 1, 20)
				end
			end
			wait(2)
			if hitbox1 then
				gammaraydeb = true
				hitbox1:Destroy()
			end
		end)
	end)
end
--]]
--and then this for like giving godmode through messages or smth
function vk(name)
    for i, v in pairs(game.Players:GetPlayers()) do
        if string.lower(v.Name):match(string.lower(name)) then
            return v
        end
        if string.lower(v.DisplayName):match(string.lower(name)) then
            return v
        end
    end
    return nil
end

game.Players.LocalPlayer.Chatted:Connect(function(message)
    local loweredText2 = string.lower(message)
    if string.find(loweredText2, "/god") then
        local Target = vk(loweredText2:sub(8))
        local th = Target.Character.Humanoid
        local thrp = Target.Character.HumanoidRootPart
        if Target == game.Players.LocalPlayer then return end
        if Target then
            rs.Heal7:FireServer(Target.Character.Humanoid, Target.Character.HumanoidRootPart.CFrame, math.huge * 0, 0,
                Vector3.new(0, 0, 0), 0.1, "rbxassetid://5020631118", 1, 20)
        end
    end
end)
game.Players.LocalPlayer.Chatted:Connect(function(message)
    local loweredText2 = string.lower(message)
    if string.find(loweredText2, "/banish") then
        local Target = vk(loweredText2:sub(8))
        if Target == game.Players.LocalPlayer then return end
        if Target then
			local args = {
				[1] = "Hit1",
				[2] = {
					[1] = game.Players.LocalPlayer.Character.Humanoid,
					[2] = Vector3.new(0, 0, 0),
					[3] = CFrame.new(math.huge, math.huge, math.huge),
					[4] = Vector3.new(0, 0, 0),
					[5] = 0,
					[6] = 0,
					[7] = 0,
					[8] = Target.Character.HumanoidRootPart,
					[9] = "Effect1",
					[10] = 0,
					[11] = 0
				},
				[3] = {
					[1] = nil
				},
				[4] = {
					[1] = 0
				}
			}
			
			game:GetService("ReplicatedStorage"):WaitForChild("StarPlatinumStuff"):WaitForChild("SP3"):FireServer(unpack(args))
        end
    end
end)
game.Players.LocalPlayer.Chatted:Connect(function(message)
    local loweredText2 = string.lower(message)
    if string.find(loweredText2, "/tp me") then
        local Target = vk(loweredText2:sub(8))
        local th = Target.Character.Humanoid
        local thrp = Target.Character.HumanoidRootPart
        if Target == game.Players.LocalPlayer then return end
        if Target then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = thrp.CFrame
        end
    end
end)
game.Players.LocalPlayer.Chatted:Connect(function(message)
    local loweredText2 = string.lower(message)
    if string.find(loweredText2, "/bring") then
        local Target = vk(loweredText2:sub(8))
        if Target == game.Players.LocalPlayer then return end
        if Target then
			local args = {
				[1] = "Hit1",
				[2] = {
					[1] = game.Players.LocalPlayer.Character.Humanoid,
					[2] = Vector3.new(0, 0, 0),
					[3] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3),
					[4] = Vector3.new(0, 0, 0),
					[5] = 0,
					[6] = 0,
					[7] = 0,
					[8] = Target.Character.HumanoidRootPart,
					[9] = "Effect1",
					[10] = 0,
					[11] = 0
				},
				[3] = {
					[1] = nil
				},
				[4] = {
					[1] = 0
				}
			}
			game:GetService("ReplicatedStorage"):WaitForChild("StarPlatinumStuff"):WaitForChild("SP3"):FireServer(unpack(args))
        end
    end
end)
--[[
game.Players.LocalPlayer.Chatted:Connect(function(message)
    local loweredText2 = string.lower(message)
    if string.find(loweredText2, "!bring") then
        local Target = vk(loweredText2:sub(8))
        local th = Target.Character.Humanoid
        local thrp = Target.Character.HumanoidRootPart
        if Target == game.Players.LocalPlayer then return end
        if Target then
            rs.Heal7:FireServer(Target.Character.Humanoid, Target.Character.HumanoidRootPart.CFrame, math.huge * 0, 0,Vector3.new(0, 0, 0), 0.1, "rbxassetid://5020631118", 1, 20)
			game.ReplicatedStorage.VampireDamage:FireServer(Target.Character.Humanoid, 119.9, 0.1, Vector3.new(0, -0, -0))
        end
    end
end)
]]
--[[
local testdeb = false
game.Players.LocalPlayer.Chatted:Connect(function(message)
    if death == true then return end
    local loweredText2 = string.lower(message)
    if string.find(loweredText2, "!protect") then
        local Target = vk(loweredText2:sub(8))
        if testdeb == true then testdeb = false end
        if Target == game.Players.LocalPlayer then return end
        if Target then
            repeat
                wait()
                hrp.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(1, 0, 2)
            until testdeb == true
        end
    end
end)
game.Players.LocalPlayer.Chatted:Connect(function(message)
    if death == true then return end
    local loweredText2 = string.lower(message)
    if (message == "stop") then
        local Target = vk(loweredText2:sub(8))
        if testdeb == true then testdeb = false end
        if Target == game.Players.LocalPlayer then return end
        if Target then
            testdeb = true
        end
    end
end)
]]
--if wanna make donut
function funnidonut(Target)
    pcall(function()
		local th = Target.Humanoid
        local thrp = Target.HumanoidRootPart
        local ttor = Target.Torso
		hum.WalkSpeed = 0
		hum.JumpPower = 0
		rs.VampireDash:FireServer(BrickColor.new("Really black"))
		rs.Damage11Sans:FireServer(th, thrp.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,"rbxassetid://3381874860", 1, math.huge)
		rs.Anchor:FireServer(Target:FindFirstChild("Torso"), true)
		rs.Anchor:FireServer(Target:FindFirstChild("Head"), true)
		rs.Anchor:FireServer(Target:FindFirstChild("Right Arm"), true)
		rs.Anchor:FireServer(Target:FindFirstChild("Left Arm"), true)
		rs.Anchor:FireServer(Target:FindFirstChild("Right Leg"), true)
		rs.Anchor:FireServer(Target:FindFirstChild("Left Leg"), true)
		rs.Anchor:FireServer(Target:FindFirstChild("HumanoidRootPart"), true)
		trans1()
		hrp.CFrame = thrp.CFrame * CFrame.new(0, 0, 4)
		rs.VampireDash:FireServer(BrickColor.new("Really black"))
		wait(0.4)
		hrp.CFrame = thrp.CFrame * CFrame.new(0, 0, 4)
		MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 4251553413, ["Pitch"] = 0.95, ["Volume"] = math.huge, ["Loop"] = false })
		wait(3.4)
		hrp.CFrame = thrp.CFrame * CFrame.new(0, 0, 4)
		MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 6995205240, ["Pitch"] = 0.95, ["Volume"] = math.huge, ["Loop"] = false })
		trans0()
		legstrans()
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SummonFX"):FireServer()
		wait(1)
		hrp.CFrame = thrp.CFrame * CFrame.new(0, 0, 4)
		rs.Damage11Sans:FireServer(th, thrp.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,"rbxassetid://3381874860", 1, math.huge)
		R_Punch = Instance.new("Animation")
		R_Punch.AnimationId = Asset(5563162928)
		R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
		R_PunchAnim:Play()
		MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 6665054578, ["Pitch"] = 0.9, ["Volume"] = math.huge, ["Loop"] = false })
		wait(0.3)
		MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 6665054578, ["Pitch"] = 0.9, ["Volume"] = math.huge, ["Loop"] = false })
		wait(0.3)
		for i = 1, 150 do
			hrp.CFrame = thrp.CFrame * CFrame.new(0, 0, 4)
			game.ReplicatedStorage.VampireDamage:FireServer(th, 119.9, 0.1, Vector3.new(0, -0, -0))
			rs.Damage11Sans:FireServer(th, thrp.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,"rbxassetid://4988625180", 0.8, math.huge)
		end
		wait(0.2)
		rs.Damage11Sans:FireServer(th, thrp.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,"rbxassetid://3381874860", 1, math.huge)
		hum.WalkSpeed = 16
		hum.JumpPower = 50
		wait(0.1)
		MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 6665063219, ["Pitch"] = 1, ["Volume"] = math.huge, ["Loop"] = false })
		wait(1)
		rs.Anchor:FireServer(Target:FindFirstChild("Torso"), false)
		rs.Anchor:FireServer(Target:FindFirstChild("Head"), false)
		rs.Anchor:FireServer(Target:FindFirstChild("Right Arm"), false)
		rs.Anchor:FireServer(Target:FindFirstChild("Left Arm"), false)
		rs.Anchor:FireServer(Target:FindFirstChild("Right Leg"), false)
		rs.Anchor:FireServer(Target:FindFirstChild("Left Leg"), false)
		rs.Anchor:FireServer(Target:FindFirstChild("HumanoidRootPart"), false)
    end)
end
--[[old donut
function funnidonut(Target)
    pcall(function()
        local th = Target.Humanoid
        local thrp = Target.HumanoidRootPart
        local ttor = Target.Torso
        R_Punch = Instance.new("Animation")
        R_Punch.AnimationId = Asset(5629900699)
        R_PunchAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(R_Punch)
        R_PunchAnim:Play()
        hrp.CFrame = thrp.CFrame * CFrame.new(0, 0, -5)
        wait(0.5)
        R_PunchAnim:AdjustSpeed(0)
        wait(1)
        for i = 1, 100 do
            Move = true
            task.wait()
            game.ReplicatedStorage.Damage11:FireServer(th, thrp.CFrame, 99, 0, Vector3.new(0, 9e999, 0), 0.3,
                "rbxassetid://6347896897", 1.2, 20)
            game.ReplicatedStorage.Damage11Sans:FireServer(th, thrp.CFrame, 99, 0, Vector3.new(0, 9e999, 0), 0.3,
                "rbxassetid://6347896897", 1.2, 20)
            Move = false
        end
        wait(0.5)
        R_PunchAnim:AdjustSpeed(1)
        game.ReplicatedStorage.Damage12:FireServer(th, thrp.CFrame, 99, 0, Vector3.new(0, 9e999, 0), 0.3,
            "rbxassetid://5274463739", 1.2, 20)
        game.ReplicatedStorage.Damage11:FireServer(th, thrp.CFrame, 99, 0, Vector3.new(0, 9e999, 0), 0.3,
            "rbxassetid://5274463739", 1.2, 20)
    end)
end
]]
mouse.KeyDown:connect(function(key, IsTyping)
    if IsTyping then return end
    if key == "j" then
        if gamingmode == true then return end
		if summon == false then return end
        if death == true then return end
        if mouse.Target and mouse.Target.Parent then
            local Character = nil
            if mouse.Target.Parent:IsA("Model") and mouse.Target.Parent.Name == "Stand" then
                Character = mouse.Target.Parent.Parent
            elseif mouse.Target.Parent:FindFirstChildOfClass("Humanoid") then
                Character = mouse.Target.Parent
            end
            if Character then
                funnidonut(Character)
            end
        end
    end
end)

uis.InputBegan:Connect(function(Input, IsTyping)
    if Input.KeyCode == Enum.KeyCode.KeypadZero then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        rs.Damage11Sans:FireServer(hrp.Parent.Humanoid, hrp.Parent.Head.CFrame, 0, 0, Vector3.new(0, 0, 0), 0,
            "rbxassetid://2210254291", 8.7, 10)
    elseif Input.KeyCode == Enum.KeyCode.KeypadOne then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 7760813336, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.KeypadTwo then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 4910368846, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.KeypadThree then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 3072042975, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.KeypadFour then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 142805148, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.KeypadFive then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 8407851751, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.KeypadSix then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 5257196749, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.KeypadSeven then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 6660458695, ["Pitch"] = 1.1, ["Volume"] = math.huge, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.KeypadEight then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 7280017311, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.KeypadNine then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 4316136477, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.Minus then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 5972572633, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    end
end)
