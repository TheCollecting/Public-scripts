local p=game.Players.LocalPlayer
local r=p.Character and p.Character:WaitForChild("HumanoidRootPart")
if not r then return end
local grouped = {}
for _, name in pairs({"Containers", "QuestItems", "DroppedItems"}) do
	local f = Workspace:FindFirstChild(name)
	if f then
		for _, o in ipairs(f:GetDescendants()) do
			if o:IsA("MeshPart") then
				local key = o.Parent.Name
				grouped[key] = grouped[key] or {}
				table.insert(grouped[key], o)
			end
		end
	end
end

local pts = {}
for _, t in pairs(grouped) do
	for _, v in ipairs(t) do pts[#pts+1] = v end
end

local c = r.Position
local rad = 12
local count = 0
local max = 20
for i, v in ipairs(pts) do
	if count >= max then
		rad = rad + 4
		max = math.floor(20 * (rad / 12))
		count = 0
	end
	local ang = (count / max) * math.pi * 2
	local pos = c + Vector3.new(math.cos(ang) * rad, -2, math.sin(ang) * rad)
	v.CFrame = CFrame.new(pos, c)
	count = count + 1
end