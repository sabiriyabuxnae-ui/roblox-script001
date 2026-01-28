-- Marker Viewer UI (Safe Version)
-- สร้างโดย ต้นไม้

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

local markers = {}
local currentIndex = 0
local MAX_MARKERS = 10

-- ===== UI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(260,150)
frame.Position = UDim2.new(0.5,-130,0.65,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,-30,0,30)
title.Position = UDim2.new(0,5,0,0)
title.BackgroundTransparency = 1
title.Text = "MARKER VIEWER"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- ปุ่ม X (ย่อ UI)
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.fromOffset(28,28)
closeBtn.Position = UDim2.new(1,-30,0,2)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
closeBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", closeBtn)

-- ปุ่มวางจุด
local placeBtn = Instance.new("TextButton", frame)
placeBtn.Size = UDim2.new(0.9,0,0,40)
placeBtn.Position = UDim2.new(0.05,0,0,40)
placeBtn.Text = "วางจุดสีแดง"
placeBtn.BackgroundColor3 = Color3.fromRGB(40,120,40)
placeBtn.TextColor3 = Color3.new(1,1,1)
placeBtn.Font = Enum.Font.GothamBold
placeBtn.TextScaled = true
Instance.new("UICorner", placeBtn)

-- ปุ่มดูกล้อง
local viewBtn = Instance.new("TextButton", frame)
viewBtn.Size = UDim2.new(0.9,0,0,40)
viewBtn.Position = UDim2.new(0.05,0,0,90)
viewBtn.Text = "ไปดูจุดถัดไป"
viewBtn.BackgroundColor3 = Color3.fromRGB(40,90,140)
viewBtn.TextColor3 = Color3.new(1,1,1)
viewBtn.Font = Enum.Font.GothamBold
viewBtn.TextScaled = true
Instance.new("UICorner", viewBtn)

-- ===== ลูกบอลตอนย่อ =====
local ball = Instance.new("TextButton", gui)
ball.Size = UDim2.fromOffset(45,45)
ball.Position = UDim2.new(1,-60,0,80)
ball.Text = "●"
ball.Visible = false
ball.BackgroundColor3 = Color3.fromRGB(30,30,30)
ball.TextColor3 = Color3.new(1,1,1)
ball.TextScaled = true
ball.Active = true
ball.Draggable = true
Instance.new("UICorner", ball).CornerRadius = UDim.new(1,0)

closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	ball.Visible = true
end)

ball.MouseButton1Click:Connect(function()
	frame.Visible = true
	ball.Visible = false
end)

-- ===== สร้างจุด =====
local function createMarker(pos, index)
	local part = Instance.new("Part")
	part.Shape = Enum.PartType.Ball
	part.Size = Vector3.new(1.2,1.2,1.2)
	part.Material = Enum.Material.Neon
	part.Color = Color3.fromRGB(255,0,0)
	part.Anchored = true
	part.CanCollide = false
	part.Position = pos + Vector3.new(0,1,0)
	part.Name = "Marker_"..index
	part.Parent = workspace

	local bill = Instance.new("BillboardGui", part)
	bill.Size = UDim2.new(0,40,0,40)
	bill.AlwaysOnTop = true

	local txt = Instance.new("TextLabel", bill)
	txt.Size = UDim2.new(1,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text = tostring(index)
	txt.TextColor3 = Color3.new(1,1,1)
	txt.TextScaled = true
	txt.Font = Enum.Font.GothamBold

	return part
end

placeBtn.MouseButton1Click:Connect(function()
	if #markers >= MAX_MARKERS then return end
	if mouse.Hit then
		local pos = mouse.Hit.Position
		local marker = createMarker(pos, #markers+1)
		table.insert(markers, marker)
	end
end)

-- ===== เลื่อนกล้องไปดูจุด (ไม่วาป) =====
viewBtn.MouseButton1Click:Connect(function()
	if #markers == 0 then return end
	currentIndex = currentIndex % #markers + 1
	local target = markers[currentIndex]

	local newCF = CFrame.new(
		target.Position + Vector3.new(0,5,10),
		target.Position
	)

	TweenService:Create(camera, TweenInfo.new(1), {CFrame = newCF}):Play()
end)

-- ===== ข้อความสีรุ้งตอนเริ่ม =====
local rainbow = Instance.new("TextLabel", gui)
rainbow.Size = UDim2.new(1,0,0,40)
rainbow.Position = UDim2.new(0,0,1,-45)
rainbow.BackgroundTransparency = 1
rainbow.Text = "สร้างโดย ต้นไม้"
rainbow.Font = Enum.Font.GothamBold
rainbow.TextScaled = true

task.spawn(function()
	for i=1,180 do
		rainbow.TextColor3 = Color3.fromHSV(i/180,1,1)
		task.wait(0.01)
	end
	rainbow:Destroy()
end)
