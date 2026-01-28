local Players = game:GetService("Players")

local function makeImmortal(character)
	local humanoid = character:WaitForChild("Humanoid")

	-- เลือดเต็มตลอด
	humanoid.Health = humanoid.MaxHealth

	-- ถ้าเลือดลด ให้เด้งกลับเต็มทันที
	humanoid:GetPropertyChangedSignal("Health"):Connect(function()
		if humanoid.Health < humanoid.MaxHealth then
			humanoid.Health = humanoid.MaxHealth
		end
	end)

	-- กันสถานะตาย
	humanoid.BreakJointsOnDeath = false
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		makeImmortal(character)
	end)
end)
