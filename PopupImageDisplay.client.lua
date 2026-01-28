local Players = game:GetService("Players")
local player = Players.LocalPlayer

--------------------------------------------------
-- 🔧 ใส่ลิงก์ตรงนี้
local IMAGE_ID = "rbxassetid://14884731905"
local SOUND_ID = "" -- ถ้าไม่ใช้เสียง ให้ใส่ ""

--------------------------------------------------
-- 🎨 สร้าง GUI แสดงรูป
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local imageLabel = Instance.new("ImageLabel")
imageLabel.Parent = gui
imageLabel.Size = UDim2.fromScale(0.4, 0.4)
imageLabel.Position = UDim2.fromScale(0.3, 0.3)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = IMAGE_ID

--------------------------------------------------
-- 🔊 เล่นเสียง (ถ้ามี)
local sound
if SOUND_ID ~= "" then
	sound = Instance.new("Sound")
	sound.SoundId = SOUND_ID
	sound.Volume = 1
	sound.Parent = gui
	sound:Play()
end

--------------------------------------------------
-- ⏳ แสดง 5 วินาทีแล้วหาย
task.wait(5)

gui:Destroy()
