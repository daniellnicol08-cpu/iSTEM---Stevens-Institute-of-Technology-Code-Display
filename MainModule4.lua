return function() 
    -- Clone all important scripts and tools from this script
    local AeroClient = script.AeroClient:Clone()
    local AeroShared = script.AeroShared:Clone()
    local AeroServer = script.AeroServer:Clone()
    local AeroServerMain = script.AeroServerMain:Clone()
    local Compass = script.CompassClient:Clone()
    local AssetsShared = script.AssetsShared:Clone()
    local AssetsServer = script.AssetsServer:Clone()
    -- local DynamicWeather = script.DynamicWeather:Clone() -- optional weather system

    local GameAnalyticsServerInit = script.GameAnalyticsServerInit:Clone()
    local GameAnalyticsClient = script.GameAnalyticsClient:Clone()
    local GameAnalytics = script.GameAnalytics:Clone()
    local Postie = script.Postie:Clone()

    -- =======================
    -- Game Analytics Setup
    -- =======================
    -- Put server-side analytics in the ServerScriptService
    GameAnalyticsServerInit.Parent = game:GetService("ServerScriptService")
    -- Put shared analytics in ServerStorage
    GameAnalytics.Parent = game:GetService("ServerStorage")
    -- Put Postie (messaging system) in ReplicatedStorage
    Postie.Parent = game:GetService("ReplicatedStorage")
    -- Enable server-side analytics
    GameAnalyticsServerInit.Disabled = false
    -- Put client-side analytics in StarterPlayerScripts
    GameAnalyticsClient.Parent = game:GetService("StarterPlayer").StarterPlayerScripts

    -- =======================
    -- Aero System Setup
    -- =======================
    -- Put shared Aero scripts in ReplicatedStorage so everyone can access them
    AeroShared.Parent = game:GetService("ReplicatedStorage")
    AeroShared.Name = "Aero"
    
    -- Put server-side Aero scripts in ServerStorage
    AeroServerMain.Parent = game:GetService("ServerStorage")
    AeroServerMain.Name = "Aero"
    
    -- Set up server and shared game assets
    AssetsServer.Parent = game:GetService("ServerStorage")
    AssetsServer.Name = "Assets"
    AssetsShared.Parent = game:GetService("ReplicatedStorage")
    AssetsShared.Name = "Assets"
    
    -- Put Aero server logic in ServerScriptService and enable it
    AeroServer.Parent = game:GetService("ServerScriptService")
    AeroServer.Name = "Aero"
    AeroServer.Internal.AeroServer.Disabled = false
    
    -- Put Aero client scripts in StarterPlayerScripts so players get them when they join
    AeroClient.Parent = game:GetService("StarterPlayer").StarterPlayerScripts
    AeroClient.Name = "Aero"

    -- Set up Compass for player characters and enable it
    Compass.Parent = game:GetService("StarterPlayer").StarterCharacterScripts
    Compass.Disabled = false

    -- =======================
    -- Set up scripts for players already in the game
    -- =======================
    for i,v in pairs(game.Players:GetPlayers()) do
        if v:FindFirstChild("PlayerScripts") then
            -- Add Aero client to player if missing
            if not v.PlayerScripts:FindFirstChild("Aero") then
                local Clone = script.AeroClient:Clone()
                Clone.Parent = v.PlayerScripts
            end
            -- Add Game Analytics client to player if missing
            if not v.PlayerScripts:FindFirstChild("GameAnalyticsClient") then
                local Clone = script.GameAnalyticsClient:Clone()
                Clone.Parent = v.PlayerScripts
            end
            -- Add Compass to characters if missing
            if v.Character and not v:FindFirstChild("CompassClient") then
                local eCompass = script.CompassClient:Clone()
                eCompass.Parent = game:GetService("StarterPlayer").StarterCharacterScripts
                eCompass.Disabled = false
            end
        end
    end
end
