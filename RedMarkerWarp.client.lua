--// SETTINGS
local MAX_POINTS = 10
local FILE_NAME = "TeleportPoints_Tonmai.json"

--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

--// VARIABLES
local points = {}
local currentTeleportIndex = 1
local currentDeleteIndex = 1
local placingMode = false

--// LOAD SAVED POINTS (กันหายตอนเข้าใหม่)
pcall(function()
	if readfile and isfile and isfile(FILE_NAME) then
		local data = HttpService:JSONDecode(readfile(FILE_NAME))
		points = data
	end
end)

local function savePoints()
	if writefile then
		writefile(FILE_NAME, HttpService:JSONEncode(points))
	end
end

--// CREATE UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TeleportGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 230)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0,20)

-- CLOSE BUTTON
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-45,0,5)
close.Text = "X"
close.TextScaled = true
close.BackgroundColor3 = Color3.fromRGB(0,0,0)
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

close.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- BUTTON CREATOR FUNCTION
local function makeButton(text, color, yPos)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.9,0,0,55)
	btn.Position = UDim2.new(0.05,0,0,yPos)
	btn.Text = text
	btn.TextScaled = true
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.new(0,0,0)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)
	return btn
end

-- RED BUTTON (WARP)
local warpBtn = makeButton("วาปไปยังจุดสีแดง", Color3.fromRGB(255,0,0), 20)

-- GREEN BUTTON (CREATE POINT)
local addBtn = makeButton("สร้างจุดสีแดง", Color3.fromRGB(0,255,0), 90)

-- BLUE BUTTON (DELETE POINT)
local delBtn = makeButton("ลบจุดสีแดง", Color3.fromRGB(0,120,255), 160)

--// CREATE POINT PART
local function createPoint(pos, index)
	local part = Instance.new("Part")
	part.Shape = Enum.PartType.Ball
	part.Size = Vector3.new(1,1,1)
	part.Color = Color3.fromRGB(255,0,0)
	part.Material = Enum.Material.Neon
	part.Anchored = true
	part.CanCollide = false
	part.Position = pos
	part.Name = "TeleportPoint_"..index
	part.Parent = workspace

	local bill = Instance.new("BillboardGui", part)
	bill.Size = UDim2.new(0,50,0,50)
	bill.AlwaysOnTop = true

	local txt = Instance.new("TextLabel", bill)
	txt.Size = UDim2.new(1,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text = tostring(index)
	txt.TextScaled = true
	txt.TextColor3 = Color3.new(1,1,1)
	txt.TextStrokeTransparency = 0

	return part
end

--// LOAD EXISTING POINTS INTO MAP
for i,pos in ipairs(points) do
	createPoint(Vector3.new(pos.x,pos.y,pos.z), i)
end

--// ADD POINT MODE
addBtn.MouseButton1Click:Connect(function()
	if #points >= MAX_POINTS then return end
	placingMode = true
end)

mouse.Button1Down:Connect(function()
	if not placingMode then return end
	placingMode = false
	
	local hit = mouse.Hit.Position
	table.insert(points, {x=hit.X,y=hit.Y,z=hit.Z})
	createPoint(hit, #points)
	savePoints()
end)

--// TELEPORT BUTTON
warpBtn.MouseButton1Click:Connect(function()
	if #points == 0 then return end
	
	if currentTeleportIndex > #points then
		currentTeleportIndex = 1
	end
	
	local pos = points[currentTeleportIndex]
	player.Character:PivotTo(CFrame.new(pos.x, pos.y+3, pos.z))
	
	currentTeleportIndex += 1
end)

--// DELETE BUTTON
delBtn.MouseButton1Click:Connect(function()
	if #points == 0 then return end
	
	local part = workspace:FindFirstChild("TeleportPoint_"..currentDeleteIndex)
	if part then part:Destroy() end
	
	table.remove(points, currentDeleteIndex)
	savePoints()
	
	-- รีเลขใหม่
	for i,v in pairs(workspace:GetChildren()) do
		if v.Name:find("TeleportPoint_") then
			v:Destroy()
		end
	end
	for i,pos in ipairs(points) do
		createPoint(Vector3.new(pos.x,pos.y,pos.z), i)
	end
	
	if currentDeleteIndex > #points then
		currentDeleteIndex = 1
	end
end)

--// RAINBOW CREDIT TEXT
local credit = Instance.new("TextLabel", gui)
credit.Size = UDim2.new(1,0,0,60)
credit.Position = UDim2.new(0,0,0.1,0)
credit.BackgroundTransparency = 1
credit.Text = "สร้างโดย ต้นไม้"
credit.TextScaled = true

spawn(function()
	for i=1,180 do
		credit.TextColor3 = Color3.fromHSV((i%60)/60,1,1)
		task.wait(0.016)
	end
	credit:Destroy()
end)
