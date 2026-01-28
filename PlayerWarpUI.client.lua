local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ===== GUI =====
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(260,220)
frame.Position = UDim2.new(0.5,-130,0.5,-110)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

-- ปุ่มเปิด UI (ตอนปิดอยู่)
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.fromOffset(45,45)
openBtn.Position = UDim2.new(0,10,0,200)
openBtn.Text = "◉"
openBtn.Visible = false
openBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.TextScaled = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1,0)

-- ปุ่ม X ปิด UI
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.fromOffset(30,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
Instance.new("UICorner", closeBtn)

-- ชื่อด้านบน
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "สร้างโดย POISJS1235"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- รายชื่อผู้เล่น (สีน้ำเงิน)
local playerList = Instance.new("ScrollingFrame", frame)
playerList.Size = UDim2.new(0.9,0,0,100)
playerList.Position = UDim2.new(0.05,0,0,40)
playerList.CanvasSize = UDim2.new(0,0,0,0)
playerList.ScrollBarThickness = 6
playerList.BackgroundColor3 = Color3.fromRGB(35,35,35)
Instance.new("UICorner", playerList)

local layout = Instance.new("UIListLayout", playerList)
layout.Padding = UDim.new(0,5)

local selectedPlayer = nil

local function refreshPlayerList()
	for _, child in pairs(playerList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1,-5,0,30)
			btn.Text = plr.Name
			btn.BackgroundColor3 = Color3.fromRGB(40,80,160) -- น้ำเงิน
			btn.TextColor3 = Color3.new(1,1,1)
			btn.TextScaled = true
			btn.Parent = playerList
			Instance.new("UICorner", btn)

			btn.MouseButton1Click:Connect(function()
				selectedPlayer = plr
				for _, b in pairs(playerList:GetChildren()) do
					if b:IsA("TextButton") then
						b.BackgroundColor3 = Color3.fromRGB(40,80,160)
					end
				end
				btn.BackgroundColor3 = Color3.fromRGB(80,160,255)
			end)
		end
	end

	task.wait()
	playerList.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 5)
end

refreshPlayerList()
Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)

-- ปุ่มวาร์ป (สีเขียว)
local warpBtn = Instance.new("TextButton", frame)
warpBtn.Size = UDim2.new(0.9,0,0,40)
warpBtn.Position = UDim2.new(0.05,0,1,-50)
warpBtn.Text = "วาป"
warpBtn.BackgroundColor3 = Color3.fromRGB(40,140,40)
warpBtn.TextColor3 = Color3.new(1,1,1)
warpBtn.TextScaled = true
Instance.new("UICorner", warpBtn)

warpBtn.MouseButton1Click:Connect(function()
	if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local targetRoot = selectedPlayer.Character.HumanoidRootPart
		local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if myRoot then
			myRoot.CFrame = targetRoot.CFrame * CFrame.new(0,0,-3)
		end
	end
end)

-- ปิด / เปิด UI
closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	openBtn.Visible = false
end)
