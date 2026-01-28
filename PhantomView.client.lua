local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ===== สถานะ =====
local invisible = false

-- ===== ฟังก์ชันล่องหนเฉพาะเครื่องเรา =====
local function setInvisible(character)
	for _, v in pairs(character:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("Decal") then
			v.LocalTransparencyModifier = 1
		end
	end
end

local function setVisible(character)
	for _, v in pairs(character:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("Decal") then
			v.LocalTransparencyModifier = 0
		end
	end
end

-- ===== GUI =====
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(230,130)
frame.Position = UDim2.new(0.05,0,0.6,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "INVISIBLE (LOCAL)"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1,0,0,20)
credit.Position = UDim2.new(0,0,0,28)
credit.BackgroundTransparency = 1
credit.Text = "POISJS1235"
credit.TextColor3 = Color3.fromRGB(180,180,180)
credit.Font = Enum.Font.Gotham
credit.TextScaled = true

local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(0.9,0,0,40)
toggleBtn.Position = UDim2.new(0.05,0,0,55)
toggleBtn.Text = "INVISIBLE : OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.TextScaled = true
Instance.new("UICorner", toggleBtn)

local uiBtn = Instance.new("TextButton", frame)
uiBtn.Size = UDim2.new(0.9,0,0,25)
uiBtn.Position = UDim2.new(0.05,0,0,100)
uiBtn.Text = "ปิด UI"
uiBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
uiBtn.TextColor3 = Color3.new(1,1,1)
uiBtn.TextScaled = true
Instance.new("UICorner", uiBtn)

local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.fromOffset(45,45)
openBtn.Position = UDim2.new(0,10,0,200)
openBtn.Text = "●"
openBtn.Visible = false
openBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.TextScaled = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1,0)

-- ===== ปุ่มล่องหน =====
toggleBtn.MouseButton1Click:Connect(function()
	invisible = not invisible
	local char = player.Character
	if char then
		if invisible then
			setInvisible(char)
			toggleBtn.Text = "INVISIBLE : ON"
			toggleBtn.BackgroundColor3 = Color3.fromRGB(40,120,40)
		else
			setVisible(char)
			toggleBtn.Text = "INVISIBLE : OFF"
			toggleBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
		end
	end
end)

-- ===== ปุ่มซ่อน UI =====
uiBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	openBtn.Visible = false
end)

-- รีเซ็ตตอนตาย
player.CharacterAdded:Connect(function(char)
	task.wait(1)
	if invisible then
		setInvisible(char)
	end
end)
