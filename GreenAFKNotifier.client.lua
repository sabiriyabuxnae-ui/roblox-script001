local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local label = Instance.new("TextLabel")
label.Parent = gui
label.Size = UDim2.new(1,0,0,40)
label.Position = UDim2.new(0,0,1,-45)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(0,255,0)
label.Text = "ยินดีด้วยตอนนี้คุณได้รันสคลิปAFKแล้ว สคลิปนี้สร้างโดย ต้นไม้ หรือ อีกชื่อหนึ่ง POISJS1235"
