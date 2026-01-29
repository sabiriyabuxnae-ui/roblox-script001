--// สร้าง UI
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AI_UI"

-- เฟรมหลัก
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 420, 0, 250)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(60,40,40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,20)

-- ช่องพิมพ์คำถาม
local questionBox = Instance.new("TextBox", mainFrame)
questionBox.Size = UDim2.new(0.9,0,0,50)
questionBox.Position = UDim2.new(0.05,0,0.1,0)
questionBox.PlaceholderText = "พิมข้อความถาม AI"
questionBox.TextScaled = true
questionBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
questionBox.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", questionBox).CornerRadius = UDim.new(0,15)

-- ช่องคำตอบ AI
local answerBox = Instance.new("TextLabel", mainFrame)
answerBox.Size = UDim2.new(0.9,0,0,70)
answerBox.Position = UDim2.new(0.05,0,0.38,0)
answerBox.Text = "ข้อความตอบกลับโดย AI จะแสดงที่นี่"
answerBox.TextWrapped = true
answerBox.TextScaled = true
answerBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
answerBox.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", answerBox).CornerRadius = UDim.new(0,15)

-- ปุ่มส่งข้อความ
local sendButton = Instance.new("TextButton", mainFrame)
sendButton.Size = UDim2.new(0.9,0,0,55)
sendButton.Position = UDim2.new(0.05,0,0.7,0)
sendButton.Text = "ส่งข้อความ"
sendButton.TextScaled = true
sendButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
sendButton.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", sendButton).CornerRadius = UDim.new(0,20)

-- ปุ่มเปิด/ปิด UI
local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0,50,0,50)
toggleButton.Position = UDim2.new(0,20,0,20)
toggleButton.Text = "UI"
toggleButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
toggleButton.TextScaled = true
toggleButton.Active = true
toggleButton.Draggable = true
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1,0)

local uiOpen = true

toggleButton.MouseButton1Click:Connect(function()
	uiOpen = not uiOpen
	mainFrame.Visible = uiOpen
	
	if uiOpen then
		toggleButton.Text = "UI"
	else
		toggleButton.Text = "◉" -- ตอนย่อเป็นลูกบอล
	end
end)

-- ฟังก์ชัน AI ตอบ (ตัวอย่าง)
local function getAIResponse(text)
	text = string.lower(text)

	if text == "" then
		return "คุณยังไม่ได้พิมพ์คำถาม"
	elseif string.find(text,"ชื่อ") then
		return "ฉันคือ AI ผู้ช่วยของคุณ 🤖"
	elseif string.find(text,"เวลา") then
		return "ตอนนี้เวลาในเครื่องคุณคือ "..os.date("%X")
	elseif string.find(text,"roblox") then
		return "Roblox คือแพลตฟอร์มสร้างเกมที่ผู้เล่นสร้างเกมเองได้"
	else
		return "ฉันได้รับข้อความว่า: "..text
	end
end

-- กดปุ่มส่ง
sendButton.MouseButton1Click:Connect(function()
	local question = questionBox.Text
	answerBox.Text = "AI กำลังคิด..."
	wait(0.5)
	answerBox.Text = getAIResponse(question)
end)
