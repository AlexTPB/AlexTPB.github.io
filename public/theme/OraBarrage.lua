-- For scripter role application by tpbb

-- The following code is old and I already learned not to use these bad practices

-- // Locals // --

local debris = game:GetService("Debris")
local rs = game:GetService("ReplicatedStorage")
local remotes = rs:WaitForChild("Remotes")

local ss = game:GetService("ServerStorage")
local modules = ss:WaitForChild("Modules")

local hitbox = require(modules:WaitForChild("Hitbox"))
local slow = require(modules:WaitForChild("Slow"))
local stun = require(modules:WaitForChild("Stun"))
local hitService = require(modules:WaitForChild("hitService"))
local ragdollHandler = require(modules:WaitForChild("RagdollHandler"))
local st = require(modules:WaitForChild("Miscellaneous"))

local TService = game:GetService("TweenService")
local animations = rs:WaitForChild("Animations")
local soundService = game:GetService("SoundService")

-- // Functions // --

local function calculateKnockback(attacker, enemy, power)
	local direction = -(attacker.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Unit -- Calculate the Direction of the knockback
	local kb = direction * power -- Calculate the Direction by the Power for knockback
	return kb -- Return the knockback vector3
end

local cd
game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		cd = Instance.new("BoolValue", ss); cd.Name = "OraPunch"; cd.Value = false -- Add a cooldown to players
	end)
end)

remotes.Moves.OraPunch.OnServerEvent:Connect(function(plr) -- Remote to pickup from the Tool activation
	-- // Locals // --
	
	local chr = plr.Character
	local hum = chr:WaitForChild("Humanoid")
	local humrp = chr:WaitForChild("HumanoidRootPart")
	local starPlatinum = chr.Stand:WaitForChild("StopFlatinum")
	local animator = starPlatinum:WaitForChild("AnimationController"):WaitForChild("Animator")
	
	local attacking = chr:GetAttribute("Attacking")
	local punching = chr:GetAttribute("Punching")
	local blocking = chr:GetAttribute("Blocking")
	local stunned = chr:GetAttribute("Stunned")
	local ragdolled = chr:GetAttribute("Ragdolled")
	
	-- // Main Stuff // --
	
	if not humrp:FindFirstChild("OraPunch") then -- If the cooldown doesnt already exist in the humanoidrootpart
		cd.Parent = humrp
	end
	
	if attacking or punching or blocking or hum.Health <= 0 or stunned or ragdolled or humrp:WaitForChild("OraPunch").Value then return end
	
	-- ^^ If the player is attacking or punching or blocking or dead or stunned or ragdolled or the cooldown then stop executing the bottom code
	
	humrp:WaitForChild("OraPunch").Value = true -- Set the cooldown to true
	chr:SetAttribute("Attacking", true) -- Set attacking true
	chr:SetAttribute("Destroy", true) -- Set the ability to break down stuff to true
	
	-- Play Punch Swing sound effect 2 times while waiting 0.2 seconds between them
	
	task.spawn(function()
		for i = 1, 2 do
			local swingSfx = soundService.Swing:Clone()
			swingSfx.Parent = humrp
			swingSfx.PitchShiftSoundEffect.Octave = math.random(0.1, 1)
			swingSfx:Destroy()
			task.wait(0.2)
		end
	end)
	
	--Load animations
	
	local punchAnim = animator:LoadAnimation(animations.Moves:WaitForChild("OraPunch"))
	local userAnim = hum:LoadAnimation(animations.Moves.AttackPose)
	
	-- Slow the player until the animation is done playing
	
	task.spawn(function()
		repeat
			task.wait()
		until punchAnim.Length > 0
		slow.Slow(hum, punchAnim.Length + 0.14)
	end)
	
	local hitbox = hitbox.new() -- Add a hitbox from the hitbox module
	hitbox.Size = Vector3.new(5, 5, 5) -- Set the size 
	hitbox.CFrame = humrp -- Set it to be at your humanoidrootpart
	hitbox.Offset = CFrame.new(0, -0.5, -5) -- Set offset of the part hitbox from your humanoidrootpart
	hitbox.Visualizer = true -- Transparency on or off
	
	starPlatinum:WaitForChild("Right Arm").Trail.Enabled = true -- Turn on trails
	starPlatinum:WaitForChild("Left Arm").Trail.Enabled = true
	
	-- // Hitbox // --
	
	hitbox.onTouch = function(enemyHum:Part) -- Do stuff when the hitbox part touches something
		if enemyHum ~= hum and (enemyHum.Parent:FindFirstChild("Destroyable") or enemyHum:FindFirstChild("Destroyable")) and (chr:GetAttribute("Combo") == 4 or chr:GetAttribute("Destroy") == true) and not enemyHum:FindFirstChild("Destroyed1") then
			-- For destroying parts
			local clone = enemyHum:Clone() -- Clone the part
			local P = enemyHum.Parent -- Variable to store the parent of the part
			local D = Instance.new("BoolValue", enemyHum) -- Bool value to set the part to already destroyed so it doesnt destroy it again
			D.Name = "Destroyed1"
			enemyHum.Anchored = false -- Set the part anchored to false
			local sound = soundService:WaitForChild("Destruction"):WaitForChild("Break"):Clone() -- Sound for breaking
			if enemyHum.Material == Enum.Material.Glass then
				sound = soundService:WaitForChild("Destruction"):WaitForChild("Glass"):Clone() -- If the material is glass then its glass sound
			end
			sound.Parent = enemyHum -- Sound parent to the part
			sound.PlaybackSpeed = math.random(1, 2) -- Pitch (Ignore this old practice)
			sound:Destroy() -- Destroy the sound
			
			local BV = Instance.new("BodyVelocity") -- Add velocity to the part
			BV.P = math.huge -- Very Aggressive velocity force
			BV.Parent = enemyHum -- Velocity parent is the part
			BV.MaxForce = Vector3.new(100000, 0, 100000) -- The max force of the velocity
			BV.Velocity = -(humrp.Position - enemyHum.Position).Unit * 40 -- Velocity for knockback
			debris:AddItem(BV, 0.2) -- Lifetime of the velocity
			
			local T = 20 -- Duration of the destroyed part
			
			if enemyHum.Material == Enum.Material.Glass then T = 5 end -- If the material is glass then fade away faster
			
			delay(T, function() -- Wait the time so we can fade away the part and destroy it
				TService:Create(enemyHum, TweenInfo.new(1, Enum.EasingStyle.Quad), {Transparency = 1}):Play() -- Tween the transparency of the part
				delay(1, function() -- Wait 1 second and destroy the part
					if enemyHum then enemyHum:Destroy() end
				end)
				delay(10, function() -- Wait 10 seconds and parent the cloned part to the original parent of the destroyed part
					clone.Parent = P
				end)
			end)
			for _, v in pairs(enemyHum:GetDescendants()) do -- Find every part in the destroyed part
				if v:IsA("BasePart") then -- If its a base part then
					v.Anchored = false -- Anchored is false
					delay(T, function() -- Tween transparency of the base part
						TService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad), {Transparency = 1}):Play()
					end)
				end
			end
		end
		-- Check if the hitbox touched a humanoid
		if not enemyHum:IsA("Humanoid") then return end
		if enemyHum ~= hum then -- If the enemy humanoid isnt our humanoid then
			if enemyHum.Parent:GetAttribute("IFrame") == true then return end -- If he has IFrame then no continue
			
			local enemy = enemyHum.Parent -- Get the enemy
			local enemyHumrp = enemy.HumanoidRootPart -- Their humanoidrootpart
			
			local knockback = calculateKnockback(chr, enemy, 30) -- Calculate knockback
			local attackerknockback = nil -- To move with them and combo
			local maxForce = Vector3.new(100000, 20, 100000) -- Max force
			local damage = 10 -- Damage of the hit
			local hitSfx = "4" -- The hit sound
			
			if enemy:GetAttribute("Blocked") == true then -- If he blocked then damage is 0 and return
				damage = 0
				return
			end
			
			local hollow = rs.Effects.Hollow:Clone() -- Effect
			hollow.Parent = workspace.Debris -- Parent it to Debris folder in workspace
			hollow.CFrame = humrp.CFrame * CFrame.new(0,0,-3) * CFrame.Angles(0,0,math.rad(90)) -- CFrame of the effect
			hollow.Size = Vector3.new(3,3,0.3) -- Size of it
			TService:Create(hollow,TweenInfo.new(0.35),{Size = Vector3.new(8,8,0.325); Transparency = 1}):Play() -- Tween their transparency
			debris:AddItem(hollow,0.35) -- Lifetime of part
			
			if enemyHum.Health <= 10 then -- If their health is less or equal to 10 then it activates a finisher move
				local knockback = calculateKnockback(chr, enemy, 100)
				maxForce = Vector3.new(100000, 1000, 100000)
				hitSfx = "Downslam"
				local hollow = rs.Effects.Hollow:Clone()
				hollow.Parent = workspace.Debris
				hollow.CFrame = humrp.CFrame * CFrame.new(0,0,-3) * CFrame.Angles(0,0,math.rad(90))
				hollow.Size = Vector3.new(3,3,0.5)
				TService:Create(hollow,TweenInfo.new(0.35),{Size = Vector3.new(8,8,0.325); Transparency = 1}):Play()
				debris:AddItem(hollow,0.35)
			end
			-- Run the hit module with the given stuff
			hitService.hit(enemyHum, damage, 0.9, knockback, attackerknockback, chr, true, 1.5, maxForce, true, hitSfx, 5, ColorSequence.new(Color3.fromRGB(255, 255, 255)), NumberRange.new(0.125, 0.25))
		end
		task.wait(0.1)
	end
	
	st.Transparency(starPlatinum, 0) -- Make the stand visible
	for _, v in pairs(chr:GetDescendants()) do
		if v.Name == plr:WaitForChild("savedStats"):WaitForChild("Stand").Value and v:IsA("ParticleEmitter") then -- Turn on Stand Aura
			v.Enabled = true
			v.Acceleration = Vector3.new(0, 0, 0)
		end
	end
	
	task.spawn(function() -- Bad practice ignore this it was old, supposed to be marker reached signal
		task.wait(0.4)
		hitbox:Start() -- Activate hitbox
		task.wait(0.2)
		hitbox:Stop() -- Turn it off again
		userAnim:Stop() -- Stop the animation
		starPlatinum:WaitForChild("Right Arm").Trail.Enabled = false -- Turn off the stand trails
		starPlatinum:WaitForChild("Left Arm").Trail.Enabled = false
		
		task.wait(0.12)
		chr:SetAttribute("Attacking", false) -- Set our attacking and ability to destroy parts to false
		chr:SetAttribute("Destroy", false)
		task.wait(0.1)
		st.Transparency(starPlatinum, 1) -- Make stand not visible
		for _, v in pairs(chr:GetDescendants()) do
			if v.Name == plr:WaitForChild("savedStats"):WaitForChild("Stand").Value and v:IsA("ParticleEmitter") then -- Turn off stand aura
				v.Enabled = false
				TService:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {Acceleration = Vector3.new(0, -100, 0)}):Play()
			end
		end
	end)
	
	punchAnim:Play() -- Play stand animation
	userAnim:Play() -- Play attack pose on user
	task.wait(8) -- Wait cooldown
	humrp:WaitForChild("OraPunch").Value = false
end)
