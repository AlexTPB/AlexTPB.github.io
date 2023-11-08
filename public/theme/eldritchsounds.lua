local rser = game:GetService("RunService")
local death = false

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
            rser.RenderStepped:Wait()
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

setfpscap(999)

game.Players.LocalPlayer.Character.Humanoid.HealthChanged:connect(function()
    if game.Players.LocalPlayer.Character.Humanoid.Health < 1 then
        death = true
    end
end)

game.UserInputService.InputBegan:Connect(function(Input, IsTyping)
    if Input.KeyCode == Enum.KeyCode.Zero then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 3072040984, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.One then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 3072042204, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.Two then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 3072042975, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    elseif Input.KeyCode == Enum.KeyCode.Three then
        if IsTyping or death == true then return end
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
        MainSoundSystem:Execute({ ["Action"] = "Create", ["Id"] = 3062479927, ["Volume"] = 500, ["Loop"] = false, ["Cooldown"] = true })
    end
end)
