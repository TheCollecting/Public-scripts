local possibles = getgenv().possibles
if not possibles then return end

print("started inv checker")

-- actual stuff
local players, replicatedstorage = game:GetService('Players'), game:GetService('ReplicatedStorage')
local localplayer = players.LocalPlayer

-- checks to make sure you spelled everything right, if you didnt it skips the item
local validatedList = {}
for _,i in pairs(getgenv().possibles) do
    for _,l in pairs(replicatedstorage.ItemsList:GetChildren()) do
        if i == l.Name:lower() then
            table.insert(validatedList, l)
        end
    end
end
getgenv().possibles = validatedList

-- actual stuff
local listEntry = {}
for _, player in next, players:GetPlayers() do
    if player ~= localplayer then
        local repinstance = replicatedstorage.Players:FindFirstChild(player.Name)
        if not repinstance then print("debug - repinst not found on player", player.Name) continue end
        local inv = repinstance.Inventory
        local itemlist = {}
        for _,v in pairs(inv:GetDescendants()) do
            for i = 1, #possibles do
                if tostring(possibles[i]):lower() == v.Name:lower() then

                    table.insert(itemlist, v.Name)
                end
            end
        end
        listEntry[player] = itemlist
    end
end

-- this is why i hate lua it wont just let me to do #listEntry kys NOW
local count = 0
for i,v in pairs(listEntry) do
	local inside = 0
	for o,p in pairs(v) do
		inside+=1
	end
	if inside ~= 0 then
		count+=1
	end
end
if count ~= 0 then
	print("players with items:",count)
else
	print("no items found :(")
end

-- final print with all the item lists compiled
for i,v in pairs(listEntry) do
    local printList = ""
    for k,l in pairs(v) do
        printList = printList .. l
        if k < #v then printList = printList .. ", " end
    end
	if printList == "" then continue end
    print(i.Name, "has: " .. printList)
end

print('ended inv checker')
