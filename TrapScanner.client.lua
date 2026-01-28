local Players = game:GetService("Players")
local player = Players.LocalPlayer

local visionOn = false
local highlights = {}
local laserBoxes = {}

--------------------------------------------------
-- 🎨 สร้าง UI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(220,90)
frame.Position = UDim2.new(0.5,-110,0.75,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(0.9,0,0.6,0)
toggleBtn.Position = UDim2.new(0.05,0,0.2,0)
toggleBtn.Text = "VISION : OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.TextScaled = true
Instance.new("UICorner", toggleBtn)

--------------------------------------------------
-- 👁 ไฮไลต์ผู้เล่น
local function addHighlight(char)
	if highlights[char] then return end
	
	local hl = Instance.new("Highlight")
	hl.FillColor = Color3.fromRGB(0,255,0)
	hl.OutlineColor = Color3.fromRGB(255,255,255)
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = char
	
	highlights[char] = hl
end

local function clearHighlights()
	for char,hl in pairs(highlights) do
		if hl then hl:Destroy() end
	end
	highlights = {}
end

--------------------------------------------------
-- 🔴 ตรวจจับเลเซอร์
local function markLasers()
	for _,obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			local n = obj.Name:lower()
			if n:find("laser") or n:find("beam") or n:find("trap") then
				if not laserBoxes[obj] then
					local box = Instance.new("BoxHandleAdornment")
					box.Adornee = obj
					box.Size = obj.Size + Vector3.new(0.2,0.2,0.2)
					box.Color3 = Color3.fromRGB(255,0,0)
					box.Transparency = 0.4
_attachLater = true
					box.AlwaysOnTop = true
					box.Parent = obj
					
					laserBoxes[obj] = box
				end
			end
		end
	end
end

local function clearLasers()
	for obj,box in pairs(laserBoxes) do
		if box then box:Destroy() end
	end
	laserBoxes = {}
end

--------------------------------------------------
-- 🔄 เปิดโหมด
local function enableVision()
	visionOn = true
	
	for _,plr in ipairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character then
			addHighlight(plr.Character)
		end
	end
	
	markLasers()
	toggleBtn.Text = "VISION : ON"
	toggleBtn.BackgroundColor3 = Color3.fromRGB(40,120,40)
end

-- 🔄 ปิดโหมด
local function disableVision()
	visionOn = false
	clearHighlights()
	clearLasers()
	toggleBtn.Text = "VISION : OFF"
	toggleBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
end

--------------------------------------------------
-- ผู้เล่นเข้าใหม่
Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		if visionOn then
			addHighlight(char)
		end
	end)
end)

--------------------------------------------------
-- ปุ่มเปิดปิด
toggleBtn.MouseButton1Click:Connect(function()
	if visionOn then
		disableVision()
	else
		enableVision()
	end
end)
