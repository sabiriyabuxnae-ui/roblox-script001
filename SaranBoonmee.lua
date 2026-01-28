local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- เก็บจุดวาร์ป
local points = {}

-- GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

-- เฟรมหลัก
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,300,0,200)
frame.Position = UDim2.new(0.5,-150,0.5,-100)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true

-- ปุ่ม X
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-45,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(0,0,0)
close.TextColor3 = Color3.new(1,1,1)

-- ลูกบอลเปิด UI
local ball = Instance.new("TextButton", gui)
ball.Size = UDim2.new(0,50,0,50)
ball.Position = UDim2.new(0,100,0.7,0)
ball.BackgroundColor3 = Color3.fromRGB(0,0,0)
ball.Text = "●"
ball.TextScaled = true
ball.TextColor3 = Color3.new(1,1,1)
ball.Visible = false
ball.Active = true
ball.Draggable = true

close.MouseButton1Click:Connect(function()
	frame.Visible = false
	ball.Visible = true
end)

ball.MouseButton1Click:Connect(function()
	frame.Visible = true
	ball.Visible = false
end)

-- ช่องใส่ชื่อจุด
local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8,0,0,30)
box.Position = UDim2.new(0.1,0,0,50)
box.PlaceholderText = "ใส่ชื่อจุด"
box.TextScaled = true

-- ฟังก์ชันสร้างปุ่ม
local function makeButton(text, y, color, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.9,0,0,40)
	btn.Position = UDim2.new(0.05,0,0,y)
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Text = text
	btn.MouseButton1Click:Connect(callback)
end

-- 🟢 เพิ่มจุด
makeButton("เพิ่มจุด", 90, Color3.fromRGB(0,255,0), function()
	if box.Text ~= "" and mouse.Hit then
		points[box.Text] = mouse.Hit.Position
	end
end)

-- 🔵 ลบจุด
makeButton("ลบจุด", 135, Color3.fromRGB(0,100,255), function()
	if box.Text ~= "" then
		points[box.Text] = nil
	end
end)

-- 🔴 วาร์ป
makeButton("วาป", 180, Color3.fromRGB(255,0,0), function()
	local char = player.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		local pos = points[box.Text]
		if pos then
			char.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
		end
	end
end)
