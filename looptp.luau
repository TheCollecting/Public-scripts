local p=game.Players.LocalPlayer
local r=p.Character and p.Character:WaitForChild("HumanoidRootPart")
if not r then return end

local grouped={}
for _,o in ipairs(workspace.Containers:GetDescendants()) do
    if o:IsA("MeshPart") then
        local key=o.Parent.Name
        grouped[key]=grouped[key] or {}
        table.insert(grouped[key],o)
    end
end

local pts={}
for _,t in pairs(grouped) do
    for _,v in ipairs(t) do pts[#pts+1]=v end
end

for i,v in ipairs(pts) do
    local n=i-1
    local c=r.Position
    local rad=8+math.floor(n/40)*6
    local ang=(n%40)/40*math.pi*2
    local pos=c+Vector3.new(math.cos(ang)*rad,-2,math.sin(ang)*rad)
    v.CFrame=CFrame.new(pos,c)
end
