-- For scripter role application by tpbb (A different script in the game)

-- Following is old code

-- // Locals // --

local rus = game:GetService("RunService")
local debris = game:GetService("Debris")
local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local rservice = game:GetService("RunService")

local remotes = rs:WaitForChild("Remotes")
local effects = rs:WaitForChild("Effects")

local combatRemote = remotes:WaitForChild("Combat")
local blockRemote = remotes:WaitForChild("Block")

local animations = rs:WaitForChild("Animations")
local movementAnimations = animations:WaitForChild("Movement")

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local humrp = chr:WaitForChild("HumanoidRootPart")

local dashRemote = remotes:WaitForChild("Dash")
local settingsRemote = remotes:WaitForChild("Settings")

local gameSettings = UserSettings().GameSettings
local camera = workspace.CurrentCamera

local dashing = false
local dashdb = false
local dashdb2 = false
local dashdb3 = false
local forward = false
local backward = false
local held = false

local lastRagdollCancelUse = {}

-- // Functions // --

local function slowDash(plr, forward, dashAnim, dashSfx, backward) -- Dashing function
	local chr = plr.Character
	local hum = chr:WaitForChild("Humanoid")
	local humrp = chr:WaitForChild("HumanoidRootPart")
	
	local dashSfx = game.SoundService:WaitForChild(dashSfx):Clone() -- Sound
	dashSfx.Parent = humrp -- Parent the Sound to rootpart
	dashSfx:Destroy() -- Sound is Playable on Remove
	
	local dashAnim = hum:LoadAnimation(dashAnim) -- Load animation
	dashAnim:Play() -- Play it
	
	local dashVelocity = Instance.new("BodyVelocity", humrp) -- Velocity of the dash
	dashVelocity.Name = "DashVelocity"
	dashVelocity.MaxForce = Vector3.new(99999,0,99999)
	
	local connection
	
	task.spawn(function() -- Make sure anything else doesnt change the walkspeed or jump power
		connection = hum.Changed:Connect(function(prop)
			if prop == "WalkSpeed" then
				hum.WalkSpeed = 0
			elseif prop == "JumpPower" then
				hum.JumpPower = 0
			end
		end)
	end)
	
	humrp:FindFirstChild("Running").Playing = false -- Disable the running animation (ignore this)
	
	if forward then -- If its forward dash
		dashRemote:FireServer("forwardVelocity") -- Fire to server that we are using front dash attack
		for i = 40, 0, -1 do -- 40 to 0 with step -1
			if chr:GetAttribute("Stunned") then break end -- If stunned then stop the velocity from updating
			dashVelocity.Velocity = humrp.CFrame.LookVector * i -- Velocity equals what we are looking at by the run we are on (cant rlly explain this)
			wait(0.001/60) -- Locked wait to 60 frames
		end
		task.delay(5,function() -- Delay 5 second before setting the debounce to false
			dashdb2 = false
		end)
		if dashVelocity then -- Destroy the velocity immediately after the for loop ended
			dashVelocity:Destroy()
		end
	elseif backward then -- Else if its backward dash
		gameSettings.RotationType = Enum.RotationType.CameraRelative -- Character rotate with camera
		for i = 50, 5, -4 do -- 50 to 5 with step -4
			if chr:GetAttribute("Stunned") then break end -- If stunned then stop the velocity from updating
			local md = hum.MoveDirection
			
			dashVelocity.Velocity = Vector3.new(md.X * i, 0, md.Z * i) -- Velocity with how we move
			wait(0.001/60)
		end
		dashVelocity:Destroy()
		task.wait(0.15)
		local dashVelocityBack = Instance.new("BodyVelocity", humrp)
		dashVelocityBack.Name = "BackVelocity"
		dashVelocityBack.MaxForce = Vector3.new(99999,0,99999)
		
		for i = 38, 5, -1.5 do
			if chr:GetAttribute("Stunned") then break end
			local md = hum.MoveDirection
			
			dashVelocityBack.Velocity = Vector3.new(md.X * i, 0, md.Z * i) -- Copy and paste
			wait(0.001/60)
		end
		task.delay(3.5,function()
			dashdb3 = false
		end)
		dashVelocityBack:Destroy()
	else then -- Else if its sideways dash
		gameSettings.RotationType = Enum.RotationType.CameraRelative -- Character rotate with camera
		for i = 38, 10, -1.5 do
			if chr:GetAttribute("Stunned") then break end
			local md = hum.MoveDirection
			
			dashVelocity.Velocity = Vector3.new(md.X * i, 0, md.Z * i)
			wait(0.001/60)
		end
		task.delay(2.5,function()
			dashdb = false
		end)
		if dashVelocity then
			dashVelocity:Destroy()
		end
	end
	
	gameSettings.RotationType = Enum.RotationType.MovementRelative
	dashing = false
	humrp:FindFirstChild("Running").Playing = true
	
	task.spawn(function()
		if forward or backward then -- If its forward dash or backward dash then wait a lil before setting walkspeed to 16
			task.wait(0.15)
		end
		if connection then -- If its still running then disconnect
			connection:Disconnect()
		end
		if chr:GetAttribute("Slowed") then -- If slowed then set walkspeed slow and no jump power
			hum.WalkSpeed = 10
			hum.JumpPower = 0
		end
		if chr:GetAttribute("Stunned") or chr:GetAttribute("Slowed") then return end -- if stunned or slowed then dont set walkspeed or jump power
		if chr:GetAttribute("Running") then
			hum.WalkSpeed = 18
		else
			hum.WalkSpeed = 16
		end
		hum.JumpPower = 40
	end)
end

local function updateRagdollCancels(chr) -- Update the ragdoll cancels attribute
	local ragdollCancels = chr:GetAttribute("RagdollCancels") -- Attribute
	local plr = game.Players:GetPlayerFromCharacter(chr)
	
	if not lastRagdollCancelUse[plr] then
		lastRagdollCancelUse[plr] = os.clock()
	end
	
	local passedTime = os.clock() - lastRagdollCancelUse[plr]
	
	if passedTime > 10 then -- If we passed 10 seconds then bring it back to default
		chr:SetAttribute("RagdollCancels", 1)
	else
		chr:SetAttribute("RagdollCancels", ragdollCancels - 1) -- If not, minus 1
		if ragdollCancels <= 0 then -- if it equals 0
			chr:SetAttribute("RagdollCancels", 0)
		end
	end
	
	lastRagdollCancelUse[plr] = os.clock()
end

-- // Input // --

uis.InputBegan:Connect(function(input, isTyping)
	if isTyping then return end
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 then -- If we clicked
		if plr.savedStats:WaitForChild("AutoUse").Value == true then -- If we have auto use setting
			held = true
			task.spawn(function()
				while held == true do -- While we are holding, Fire combat remote to punch and wait 0.03 seconds
					local jumping = uis:IsKeyDown(Enum.KeyCode.Space)
					combatRemote:FireServer(jumping) -- Fires false if we arent holding space, if its true then Uppercut attack
					task.wait(0.03)
				end
			end)
		elseif plr.savedStats:WaitForChild("AutoUse").Value == false then -- If we dont have auto use setting
			local jumping = uis:IsKeyDown(Enum.KeyCode.Space)
			combatRemote:FireServer(jumping) -- Fire punch remote
		end
	elseif input.KeyCode == Enum.KeyCode.F then -- If we press F
		if chr:GetAttribute("Emoting") == true then return end -- If we are emoting then no
		blockRemote:FireServer(true) -- Blocking remote
		
	elseif input.KeyCode == Enum.KeyCode.Q then -- If we press Q to dash
		local attacking = chr:GetAttribute("Attacking") -- Attributes
		local punching = chr:GetAttribute("Punching")
		local blocking = chr:GetAttribute("Blocking")
		local stunned = chr:GetAttribute("Stunned")
		local ragdolled = chr:GetAttribute("Ragdolled")
		local ragdollCancelUses = chr:GetAttribute("RagdollCancels")
		
		if ragdolled then -- If we are ragdolled for ragdoll cancel
			if dashdb == false and not (forward or backward) then -- If no debounce and it isnt forward or backward dash then
				updateRagdollCancels(chr) -- Update ragdoll cancel uses
				
				if ragdollCancelUses > 0 then -- If ragdoll cancel uses is greater than 0
					dashRemote:FireServer("RagdollCancel") -- Fire dash remote for ragdoll cancel
				end
			else -- Else if debounce and its forward or backwards dash then stop continue the code below
				return
			end
		end
		
		if attacking or punching or blocking or hum.Health <= 0 or stunned or ragdollCancelUses == 0 then return end
		-- Dont dash if ur attacking or punching or blocking or dead or stunned or ragdoll cancel uses is 0
		
		local md = hum.MoveDirection.Magnitude
		
		if dashing or md <= 0 then return end
		
		--If we are already dashing or the magnitude of our move direction is less or equal 0 then no
		
		local MoveDirection = camera.CFrame:VectorToObjectSpace(hum.MoveDirection)
		
		local left = math.round(MoveDirection.X) == -1
		local right = math.round(MoveDirection.X) == 1
		local front = math.round(MoveDirection.Z) == -1
		local back = math.round(MoveDirection.Z) == 1
		
		forward = false
		backward = false
		local dashAnim
		local dashSfx
		
		if uis:IsKeyDown(Enum.KeyCode.W) then -- If we are holding W 
			if dashdb2 then return end -- If debounce no
			forward = true -- Forward yes
			dashdb2 = true -- Debounce yes
			dashAnim = animations.Extra.None -- The animation value to play for the slow dash function
			dashSfx = "Dash" -- The sound value to play for the slow dash function
			
		elseif uis:IsKeyDown(Enum.KeyCode.D) then -- If we are holding D
			if dashdb then return end
			dashdb = true -- Same stuff
			dashAnim = animations.Movement.DashRight
			dashSfx = "SideDash"
			
		elseif uis:IsKeyDown(Enum.KeyCode.A) then -- If we are holding A
			if dashdb then return end
			dashdb = true -- Same stuff
			dashAnim = animations.Movement.DashLeft
			dashSfx = "SideDash"
			
		elseif uis:IsKeyDown(Enum.KeyCode.S) then -- If we are holding backwards
			if dashdb3 then return end -- If the backwards dash debounce no
			backward = true -- Backward yes
			dashdb3 = true -- Backward dash Debounce yes
			dashAnim = animations.Movement.DashBackwards -- Animation
			dashSfx = "SideDash" -- Sound
			
		end
		dashing = true -- Dashing yes
		slowDash(plr, forward, dashAnim, dashSfx, backward) -- Use the function and return our values
	end
end)

uis.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then -- If we stopped holding click then
		held = false -- Stop auto punching for the auto use setting
	elseif input.KeyCode == Enum.KeyCode.F then -- If we stopped holding F then
		blockRemote:FireServer(false) -- Stop blocking
	end
end)

dashRemote.OnClientEvent:Connect(function(arg) -- Collect remote from server
	if arg == "DestroyVelocity" then -- Server tell client we hit someone with the hitbox so we shouldnt keep dashing
		humrp:FindFirstChild("DashVelocity"):Destroy() -- Stop the dash velocity
	end
end)
