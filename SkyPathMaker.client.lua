local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

--------------------------------------------------
-- ตั้งค่า
local pathEnabled = false
local createdParts = {}

--------------------------------------------------
-- 🎨 UI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(220,120)
frame.Position = UDim2.new(0.5,-110,0.7,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local togglePath = Instance.new("TextButton", frame)
togglePath.Size = UDim2.new(0.9,0,0.35,0)
togglePath.Position = UDim2.new(0.05,0,0.1,0)
togglePath.Text = "PATH : OFF"
togglePath.BackgroundColor3 = Color3.fromRGB(120,40,40)
togglePath.TextColor3 = Color3.new(1,1,1)
togglePath.TextScaled = true
Instance.new("UICorner", togglePath)

local hideBtn = Instance.new("TextButton", frame)
hideBtn.Size = UDim2.new(0.9,0,0.3,0)
hideBtn.Position = UDim2.new(0.05,0,0.55,0)
hideBtn.Text = "ซ่อน UI"
hideBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
hideBtn.TextColor3 = Color3.new(1,1,1)
hideBtn.TextScaled = true
Instance.new("UICorner", hideBtn)

local miniBtn = Instance.new("TextButton", gui)
miniBtn.Size = UDim2.fromOffset(45,45)
miniBtn.Position = UDim2.new(1,-60,0,60)
miniBtn.Text = "◉"
miniBtn.TextScaled = true
miniBtn.Visible = false
miniBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
miniBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(1,0)

--------------------------------------------------
-- 🧱 สร้างพื้นใต้เท้า
local function createStep(position)
	local part = Instance.new("Part")
	part.Size = Vector3.new(4,0.5,4)
	part.Anchored = true
	part.CanCollide = true
	part.Position = position - Vector3.new(0,3,0)
	part.Color = Color3.fromRGB(0,170,255)
	part.Material = Enum.Material.Neon
	part.Parent = workspace

	table.insert(createdParts, part)

	-- หายไปเองใน 5 วิ
	task.delay(5, function()
		if part then part:Destroy() end
	end)
end

--------------------------------------------------
-- ตรวจตอนเดิน
RunService.RenderStepped:Connect(function()
	if not pathEnabled then return end
	if not character or not character:FindFirstChild("HumanoidRootPart") then return end
	
	local hrp = character.HumanoidRootPart
	createStep(hrp.Position)
end)

--------------------------------------------------
-- เปิด/ปิดระบบทางเดิน
togglePath.MouseButton1Click:Connect(function()
	pathEnabled = not pathEnabled
	if pathEnabled then
		togglePath.Text = "PATH : ON"
		togglePath.BackgroundColor3 = Color3.fromRGB(40,120,40)
	else
		togglePath.Text = "PATH : OFF"
		togglePath.BackgroundColor3 = Color3.fromRGB(120,40,40)
	end
end)

--------------------------------------------------
-- ซ่อน UI
hideBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	miniBtn.Visible = true
end)

miniBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	miniBtn.Visible = false
end)

--------------------------------------------------
-- อัปเดตตัวละครตอนเกิดใหม่
player.CharacterAdded:Connect(function(char)
	character = char
end)
