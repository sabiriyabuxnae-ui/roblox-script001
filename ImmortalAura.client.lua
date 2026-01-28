local player = game.Players.LocalPlayer

-- สร้าง GUI
local gui = Instance.new("ScreenGui")
gui.Name = "RainbowMessage"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ข้อความ
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,0,0,60)
label.Position = UDim2.new(0,0,0.85,0)
label.BackgroundTransparency = 1
label.Text = "สคลิปอมตะ สร้างโดย ต้นไม้"
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Parent = gui

-- เอฟเฟกต์สีรุ้ง
local RunService = game:GetService("RunService")
local hue = 0

local connection
connection = RunService.RenderStepped:Connect(function(dt)
	hue = (hue + dt * 0.5) % 1
	label.TextColor3 = Color3.fromHSV(hue, 1, 1)
end)

-- แสดง 3 วิแล้วหาย
task.wait(3)
connection:Disconnect()
gui:Destroy()
