for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
    v:Disable()
end

local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/kodabkr/hubLoad/main/main.lua"))()
local Koko = library.new("Koko Hub | Current Game: " .. gameName .. " |", 5013109572)

local FarmSection = Koko:addPage("Farming", 5012544693)
local farmMain = FarmSection:addSection("Main")

local selectedZone = nil
local selectedMobNumber = nil
local selectedEgg = nil

local codes = {
    "100LIKES",
    "1KLIKES",
    "150K",
    "4KLIKES",
    "6KLIKES",
    "10KLIKES"
}

local eggTranslation = {
    ["Forest Egg"] = 1,
    ["Forest Egg 2"] = "Forest2",
    ["Desert Egg"] = 2,
    ["Cave Egg"] = 3,
    ["Ocean Egg"] = 4,
    ["Candy Egg"] = 5,
    ["Snow Egg"] = 6,
    ["Toy Egg"] = 7,
    ["Farm Egg"] = 8,
    ["Samurai Egg"] = 9,
    ["Space Egg"] = 10,
    ["Magical Egg"] = 11
}

local zoneTranslation = {
    ["Forest"] = 1,
    ["Desert"] = 2,
    ["Cave"] = 3,
    ["Ocean"] = 4,
    ["Candy"] = 5,
    ["Snow"] = 6,
    ["Toy Zone"] = 7,
    ["Farm"] = 8,
    ["Samurai"] = 9,
    ["Space"] = 10,
    ["Magical Forest"] = 11,
}

farmMain:addToggle("Auto Swing", nil, function(state)
	auto1 = state
	if auto1 then
		coroutine.wrap(function()
			while auto1 and task.wait() do
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DamageIncreaseOnClickEvent"):FireServer()
			end
		end)()
	end
end)

farmMain:addDropdown("Select Egg", {"Forest Egg", "Forest Egg 2", "Desert Egg", "Cave Egg", "Ocean Egg", "Candy Egg", "Snow Egg", "Toy Egg", "Farm Egg", "Samurai Egg", "Space Egg", "Magical Egg"}, function(passThrough)
    selectedEgg = eggTranslation[passThrough]
end)

farmMain:addToggle("Auto Purchase Selected Egg", nil, function(state)
	auto2 = state
	if auto2 then
		coroutine.wrap(function()
			while auto2 and task.wait() do
                local args = {
                    [1] = tostring(selectedEgg)
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerPressedKeyOnEgg"):FireServer(unpack(args))                
			end
		end)()
	end
end)

farmMain:addToggle("Auto Equip Best Pet", nil, function(state)
	auto3 = state
	if auto3 then
		coroutine.wrap(function()
			while auto3 and task.wait(3) do
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("EquipBest"):InvokeServer()
			end
		end)()
	end
end)

farmMain:addButton("Claim all codes", function()
    for _,v in pairs(codes:GetChildren()) do
        local args = {
            [1] = "Claim",
            [2] = v
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("CodeEvent"):InvokeServer(unpack(args))
    end
end)

farmMain:addButton("Remove Egg Open Animation", function()
    game:GetService("ReplicatedStorage").EggOpenMap:Destroy()
end)


--// Code below doesn't work well.

-- farmMain:addDropdown("Select Zone", {"Forest", "Desert", "Cave", "Ocean", "Candy", "Snow", "Toy", "Farm", "Samurai", "Space", "Magical Forest"}, function(passThrough)
--     selectedZone = zoneTranslation[passThrough]
-- end)

-- farmMain:addDropdown("Select Mob #", {"1", "2", "3", "4"}, function(passThrough)
--     selectedMobNumber = passThrough
-- end)


-- farmMain:addToggle("Auto Fight Selected (above settings)", nil, function(state)
-- 	auto4 = state
-- 	if auto4 then
-- 		coroutine.wrap(function()
-- 			while auto4 and task.wait(1) do
--                 local args = {
--                     [1] = "Fight",
--                     [2] = tonumber(selectedZone),
--                     [3] = tonumber(selectedMobNumber)
--                 }
--                 game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("AutoFight"):FireServer(unpack(args))            
-- 			end
-- 		end)()
-- 	end
-- end)

-- farmMain:addButton("Make sure to be in the zone that they're in.", function()
--     print('it lags otherwise..')
-- end)