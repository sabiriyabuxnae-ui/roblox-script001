local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- ===== สถานะ =====
local flying = false
local noclip = false
local uiOpen = true

-- ===== GUI =====
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(220,150)
frame.Position = UDim2.new(0.05,0,0.6,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "FLY SYSTEM"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(0.9,0,0,35)
flyBtn.Position = UDim2.new(0.05,0,0,40)
flyBtn.Text = "FLY : OFF"
flyBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.TextScaled = true
Instance.new("UICorner", flyBtn)

local noclipBtn = Instance.new("TextButton", frame)
noclipBtn.Size = UDim2.new(0.9,0,0,35)
noclipBtn.Position = UDim2.new(0.05,0,0,80)
noclipBtn.Text = "NOCLIP : OFF"
noclipBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.TextScaled = true
Instance.new("UICorner", noclipBtn)

local uiBtn = Instance.new("TextButton", frame)
uiBtn.Size = UDim2.new(0.9,0,0,25)
uiBtn.Position = UDim2.new(0.05,0,0,120)
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

-- ===== การบิน =====
local bodyVelocity
local speed = 60

local function startFly()
	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(1,1,1) * 100000
	bodyVelocity.Velocity = Vector3.zero
	bodyVelocity.Parent = root
	humanoid.PlatformStand = true
end

local function stopFly()
	if bodyVelocity then
		bodyVelocity:Destroy()
		bodyVelocity = nil
	end
	humanoid.PlatformStand = false
end

RunService.RenderStepped:Connect(function()
	if flying and bodyVelocity then
		local cam = workspace.CurrentCamera
		local moveDir = Vector3.zero

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			moveDir += cam.CFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			moveDir -= cam.CFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			moveDir -= cam.CFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			moveDir += cam.CFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			moveDir += Vector3.new(0,1,0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			moveDir -= Vector3.new(0,1,0)
		end

		bodyVelocity.Velocity = moveDir.Unit * speed
	end
end)

-- ===== ทะลุกำแพง =====
RunService.Stepped:Connect(function()
	if noclip and character then
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- ===== ปุ่ม =====
flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		startFly()
		flyBtn.Text = "FLY : ON"
		flyBtn.BackgroundColor3 = Color3.fromRGB(40,120,40)
	else
		stopFly()
		flyBtn.Text = "FLY : OFF"
		flyBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
	end
end)

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = noclip and "NOCLIP : ON" or "NOCLIP : OFF"
	noclipBtn.BackgroundColor3 = noclip
		and Color3.fromRGB(40,120,40)
		or Color3.fromRGB(120,40,40)
end)

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
	character = char
	humanoid = char:WaitForChild("Humanoid")
	root = char:WaitForChild("HumanoidRootPart")
end)
