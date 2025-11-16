return function()
    -- Version setup
    local Verison = "DEVELOPMENT"
    print("Verison : " .. Verison)
    
    -- Disable Roblox's default chat UI
    local TextChatService = game:GetService("TextChatService")
    TextChatService.ChatWindowConfiguration.Enabled = false
    TextChatService.ChatInputBarConfiguration.Enabled = false
    
    print("Helm was here")

    -- Clone Aero framework modules
    local AeroClient = script.AeroClient:Clone()
    local AeroShared = script.AeroShared:Clone()
    local AeroServer = script.AeroServer:Clone()
    local AeroServerMain = script.AeroServerMain:Clone()
    --local DynamicWeather = script.DynamicWeather:Clone()

    -- Clone package folders
    local Packages = script.Packages:Clone()
    local ServerPackages = script.ServerPackages:Clone()

    -- Create a Version object for the game to reference
    local VersionObj = Instance.new("StringValue")
    VersionObj.Name = "Version"
    VersionObj.Value = Verison
    VersionObj.Parent = game.ReplicatedStorage

    -- Debug mode toggle
    local DebugMode = true

    -- Load MainModule depending on DebugMode
    local Module = DebugMode and game.ReplicatedStorage:FindFirstChild("MainModule") or 15040573421
    require(Module)()
    
    -- Ensure TechSetup exists on the server
    if not game.ServerScriptService:FindFirstChild("TechSetup") then
        require(70586650782225)()
    end

    -- Move cloned packages to correct locations
    Packages.Parent = game:GetService("ReplicatedStorage").Assets
    ServerPackages.Parent = game:GetService("ServerStorage").Assets

    -- Move Aero components to correct services
    AeroShared.Parent = game:GetService("ReplicatedStorage")
    AeroShared.Name = "Aero"

    AeroServerMain.Parent = game:GetService("ServerStorage")
    AeroServerMain.Name = "Aero"

    AeroServer.Parent = game:GetService("ServerScriptService")
    AeroServer.Name = "Aero"

    --DynamicWeather.Parent = game:GetService("ServerScriptService")
    --DynamicWeather.CPI.ServerScriptService.WeatherInitialize.Disabled = false

    -- Enable the internal AeroServer script
    AeroServer.Internal.AeroServer.Disabled = false

    -- Prepare the client loader as a ScreenGui
    local hackything = Instance.new("ScreenGui")
    hackything.Name = "Aero"
    hackything.ResetOnSpawn = false

    AeroClient.Parent = hackything
    AeroClient.Name = "Aero"
    
    -- Load Aero for all currently connected players
    for _, player in pairs(game.Players:GetPlayers()) do
        task.delay(1, function()
            print("Loading Aero for " .. player.Name)
            local Clone = hackything:Clone()
            Clone.Parent = player.PlayerGui
            Clone.Name = "Aero"
            print("Loaded Aero for " .. player.Name, Clone, Clone.Parent)
        end)
    end

    -- Load Aero for players who join later
    game.Players.PlayerAdded:Connect(function(player)
        task.wait(1)
        print("Loading Aero for " .. player.Name)
        local Clone = hackything:Clone()
        Clone.Parent = player.PlayerGui
        Clone.Name = "Aero"
    end)
end

--------------------------------------------------------------------------------
--                             PSEUDO-CODE SUMMARY                             --
--------------------------------------------------------------------------------

-- 1. Set the game version and print it.
-- 2. Disable the default Roblox chat UI (custom chat system expected).
-- 3. Clone all Aero framework components (client, shared, server, main).
-- 4. Clone additional package folders for client/server dependencies.
-- 5. Create a "Version" StringValue in ReplicatedStorage for other scripts to read.
-- 6. Enable DebugMode: loads the MainModule from ReplicatedStorage instead of an asset ID.
-- 7. Ensure "TechSetup" exists in ServerScriptService; load external setup if missing.
-- 8. Move cloned package folders into ReplicatedStorage and ServerStorage.
-- 9. Move Aero framework modules into their correct game services.
-- 10. Enable the internal AeroServer script so the framework can run.
-- 11. Create a ScreenGui (named "Aero") that will inject the AeroClient into players.
-- 12. Insert AeroClient into this ScreenGui template.
-- 13. For every player already in the game:
--        - Wait 1 second
--        - Clone the GUI and insert it into their PlayerGui
-- 14. For every new player who joins:
--        - Wait 1 second
--        - Clone the GUI into their PlayerGui
-- 15. Entire function ends; the Aero framework is now initialized for server + clients.

--------------------------------------------------------------------------------
