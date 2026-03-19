local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
if not ReplicatedStorage.Players[Players.LocalPlayer.Name].Status.GameplayVariables:GetAttribute("Spawned") == true then
	ReplicatedStorage.Remotes.SpawnCharacter:InvokeServer("West")
    print("spawning")
	task.wait(3)
end
-- ok bro
while true do
    local Character = workspace:WaitForChild(Players.LocalPlayer.Name, 10)
    if not Character then
        ReplicatedStorage.Remotes.SpawnCharacter:InvokeServer("West")
        print("spawning2")
        task.wait(5)
        Character = workspace:WaitForChild(Players.LocalPlayer.Name, 10)
        if not Character then
            print("uh oh")
            task.wait(1)
            continue
        end
    end
	for _ = 1, 20 do
		workspace[Players.LocalPlayer.Name].Health.Drowning:FireServer(5)
		task.wait(0.01)
	end
	ReplicatedStorage.Remotes.ResetCharacter:FireServer()
    task.wait(6.7) -- p100 method
    task.wait(tonumber(Players.LocalPlayer.PlayerGui.RespawnMenu.MainFrame.Transitions.RespawnScreen.RespawnOptions.WestSpawnButton.Timer.Text:match("%d+")) + 2)
    ReplicatedStorage.Remotes.SpawnCharacter:InvokeServer("West")
    print("total deaths:" .. ReplicatedStorage.Players[Players.LocalPlayer.Name].Status.Journey.Statistics:GetAttribute("Deaths"))
end
