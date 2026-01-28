local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local visionEnabled = false
local highlights = {}
local laserBoxes = {}

--------------------------------------------------
-- 👁 ทำไฮไลต์ผู้เล่น
local function addHighlight(char)
	if highlights[char] then return end
	
	local hl = Instance.new("Highlight")
	hl.FillColor = Color3.fromRGB(0,255,0)
	hl.OutlineColor = Color3.fromRGB(255,255,255)
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = char
	
	highlights[char] = hl
end

local function removeHighlights()
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
			local name = obj.Name:lower()
			if name:find("laser") or name:find("beam") or name:find("trap") then
				if not laserBoxes[obj] then
					local box = Instance.new("BoxHandleAdornment")
					box.Adornee = obj
					box.Size = obj.Size + Vector3.new(0.2,0.2,0.2)
					box.Color3 = Color3.fromRGB(255,0,0)
					box.Transparency = 0.5
					box.AlwaysOnTop = true
					box.ZIndex = 5
					box.Parent = obj
					
					laserBoxes[obj] = box
				end
			end
		end
	end
end

local function removeLasers()
	for obj,box in pairs(laserBoxes) do
		if box then box:Destroy() end
	end
	laserBoxes = {}
end

--------------------------------------------------
-- 🔄 เปิด / ปิด โหมด
local function enableVision()
	visionEnabled = true
	
	for _,plr in ipairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character then
			addHighlight(plr.Character)
		end
	end
	
	markLasers()
end

local function disableVision()
	visionEnabled = false
	removeHighlights()
	removeLasers()
end

--------------------------------------------------
-- ผู้เล่นเข้าใหม่
Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		if visionEnabled then
			addHighlight(char)
		end
	end)
end)

--------------------------------------------------
-- กดปุ่ม V เปิด/ปิด
UserInputService.InputBegan:Connect(function(input,gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.V then
		if visionEnabled then
			disableVision()
		else
			enableVision()
		end
	end
end)
