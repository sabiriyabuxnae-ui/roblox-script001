--// SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

--// ตัวแปร
local placingMode = false
local markerPart = nil

--// สร้าง UI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(220,100)
frame.Position = UDim2.new(0.5,-110,0.75,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

-- ปุ่มวางจุด
local placeBtn = Instance.new("TextButton", frame)
placeBtn.Size = UDim2.new(0.9,0,0.4,0)
placeBtn.Position = UDim2.new(0.05,0,0.1,0)
placeBtn.Text = "โหมดวางจุด : ปิด"
placeBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
placeBtn.TextColor3 = Color3.new(1,1,1)
placeBtn.TextScaled = true
Instance.new("UICorner", placeBtn)

-- ปุ่มวาร์ป
local tpBtn = Instance.new("TextButton", frame)
tpBtn.Size = UDim2.new(0.9,0,0.4,0)
tpBtn.Position = UDim2.new(0.05,0,0.55,0)
tpBtn.Text = "วาร์ปไปจุดแดง"
tpBtn.BackgroundColor3 = Color3.fromRGB(40,40,120)
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.TextScaled = true
Instance.new("UICorner", tpBtn)

--------------------------------------------------
-- 🎯 กดปุ่มเปิดโหมดวางจุด
placeBtn.MouseButton1Click:Connect(function()
	placingMode = not placingMode
	
	if placingMode then
		placeBtn.Text = "โหมดวางจุด : เปิด"
		placeBtn.BackgroundColor3 = Color3.fromRGB(40,120,40)
	else
		placeBtn.Text = "โหมดวางจุด : ปิด"
		placeBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
	end
end)

--------------------------------------------------
-- 🖱️ คลิกในโลกเพื่อวางปุ่มแดง
mouse.Button1Down:Connect(function()
	if not placingMode then return end
	
	local targetPos = mouse.Hit.Position
	
	-- ลบอันเก่า (ถ้ามี)
	if markerPart then
		markerPart:Destroy()
	end
	
	-- สร้างจุดแดง
	markerPart = Instance.new("Part")
	markerPart.Size = Vector3.new(2,0.5,2)
	markerPart.Position = targetPos + Vector3.new(0,0.25,0)
	markerPart.Anchored = true
	markerPart.CanCollide = false
	markerPart.Color = Color3.fromRGB(255,0,0)
	markerPart.Name = "TeleportMarker"
	markerPart.Parent = workspace
	
	placingMode = false
	placeBtn.Text = "โหมดวางจุด : ปิด"
	placeBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
end)

--------------------------------------------------
-- 🚀 กดปุ่มวาร์ป
tpBtn.MouseButton1Click:Connect(function()
	if markerPart and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = CFrame.new(markerPart.Position + Vector3.new(0,3,0))
	end
end)
