local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- สร้าง RemoteEvent ถ้ายังไม่มี
local remote = ReplicatedStorage:FindFirstChild("GlobalHeadChatEvent")
if not remote then
	remote = Instance.new("RemoteEvent")
	remote.Name = "GlobalHeadChatEvent"
	remote.Parent = ReplicatedStorage
end

----------------------------------------------------------------
-- 🖥️ สร้าง LocalScript ฝั่งผู้เล่นอัตโนมัติ
----------------------------------------------------------------
local localScriptSource = [[
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Remote = ReplicatedStorage:WaitForChild("GlobalHeadChatEvent")

local gui = Instance.new("ScreenGui")
gui.Name = "HeadChatGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,300,0,120)
frame.Position = UDim2.new(0.5,-150,0.7,0)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
frame.Active = true
frame.Draggable = true

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0,30,0,30)
toggle.Position = UDim2.new(1,-35,0,5)
toggle.Text = "X"
toggle.BackgroundColor3 = Color3.fromRGB(0,170,255)
toggle.TextColor3 = Color3.new(1,1,1)

local ball = Instance.new("TextButton", gui)
ball.Size = UDim2.new(0,45,0,45)
ball.Position = UDim2.new(0,100,0.75,0)
ball.Text = "💬"
ball.Visible = false
ball.BackgroundColor3 = Color3.fromRGB(0,170,255)
ball.TextScaled = true
ball.Active = true
ball.Draggable = true

toggle.MouseButton1Click:Connect(function()
	frame.Visible = false
	ball.Visible = true
end)

ball.MouseButton1Click:Connect(function()
	frame.Visible = true
	ball.Visible = false
end)

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.65,0,0,40)
box.Position = UDim2.new(0.05,0,0.5,-20)
box.PlaceholderText = "พิมพ์ข้อความ..."
box.TextScaled = true
box.BackgroundColor3 = Color3.fromRGB(255,255,255)
box.TextColor3 = Color3.new(0,0,0)

local send = Instance.new("TextButton", frame)
send.Size = UDim2.new(0.25,0,0,40)
send.Position = UDim2.new(0.72,0,0.5,-20)
send.Text = "ส่ง"
send.TextScaled = true
send.BackgroundColor3 = Color3.fromRGB(0,255,0)
send.TextColor3 = Color3.new(0,0,0)

send.MouseButton1Click:Connect(function()
	if box.Text ~= "" then
		Remote:FireServer(box.Text)
		box.Text = ""
	end
end)
]]

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Wait()
	local starterPlayerScripts = player:WaitForChild("PlayerScripts")

	if not starterPlayerScripts:FindFirstChild("HeadChatClient") then
		local localScript = Instance.new("LocalScript")
		localScript.Name = "HeadChatClient"
		localScript.Source = localScriptSource
		localScript.Parent = starterPlayerScripts
	end
end)

----------------------------------------------------------------
-- 🌍 ระบบข้อความลอยหัว (ทุกคนเห็น)
----------------------------------------------------------------
remote.OnServerEvent:Connect(function(player, message)
	if typeof(message) ~= "string" or message == "" then return end

	local char = player.Character
	if not char then return end

	local head = char:FindFirstChild("Head")
	if not head then return end

	if head:FindFirstChild("ChatBubble") then
		head.ChatBubble:Destroy()
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ChatBubble"
	billboard.Adornee = head
	billboard.Size = UDim2.new(0,200,0,50)
	billboard.StudsOffset = Vector3.new(0,2.5,0)
	billboard.AlwaysOnTop = true
	billboard.Parent = head

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1,0,1,0)
	textLabel.BackgroundTransparency = 0.3
	textLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	textLabel.TextColor3 = Color3.new(1,1,1)
	textLabel.TextScaled = true
	textLabel.TextWrapped = true
	textLabel.Text = message
	textLabel.Parent = billboard

	task.delay(8, function()
		if billboard then
			billboard:Destroy()
		end
	end)
end)
