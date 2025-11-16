return function()
    -- Clone essential modules
    local Compass = script.CompassClient:Clone()
    local AssetsShared = script.AssetsShared:Clone()
    local AssetsServer = script.AssetsServer:Clone()
    --local BetterChatV3 = script["BetterChat V3"]:Clone()
    local R6Ragdoll = script.R6Ragdoll:Clone()
    local animate = script.Animate:Clone()
    
    local RbxCharacterSounds = script.RbxCharacterSounds:Clone()
    
    -- Add character sounds to all player characters
    RbxCharacterSounds.Parent = game:GetService("StarterPlayer").StarterCharacterScripts
    RbxCharacterSounds.Enabled = true

    -- Clone and load Adonis admin loader
    local AdonisLoader = script.Adonis_Loader:Clone()
    AdonisLoader.Parent = game:GetService("ServerScriptService")
    AdonisLoader.Script1.Enabled = true
    
    -- Enable custom animation system
    animate.Parent = game:GetService("StarterPlayer").StarterCharacterScripts
    animate.Disabled = false
    
    -- Place asset folders in proper services
    AssetsServer.Parent = game:GetService("ServerStorage")
    AssetsServer.Name = "Assets"

    AssetsShared.Parent = game:GetService("ReplicatedStorage")
    AssetsShared.Name = "Assets"
    
    -- Add compass to player characters
    Compass.Parent = game:GetService("StarterPlayer").StarterCharacterScripts
    Compass.Disabled = false
    
    -- Enable ragdoll system
    R6Ragdoll.Parent = game.ServerScriptService
    R6Ragdoll.Disabled = false
    
    --[[ Optional Chat Replacement System
    if game:GetService("Chat").LoadDefaultChat == false then
        BetterChatV3.Parent = game:GetService("ServerScriptService")
        BetterChatV3.Config.Loader.Enabled = true
        --SocialChat.Parent = game:GetService("ServerScriptService")
        --SocialChat.Loader.Enabled = true
    end
    --]]

    -- Deferred setup for live player characters in workspace
    task.defer(function()
        local PlayersFolder = workspace:WaitForChild("Players")
        
        for _, v in pairs(PlayersFolder:GetChildren()) do
            
            -- Ensure character sounds exist
            if not v:FindFirstChild("RbxCharacterSounds") then
                local newRbxCharacterSounds = RbxCharacterSounds:Clone()
                newRbxCharacterSounds.Parent = v
                newRbxCharacterSounds.Enabled = true
            end
            
            -- Ensure compass exists
            if not v:FindFirstChild("CompassClient") then
                local newCompass = Compass:Clone()
                newCompass.Parent = v
                newCompass.Disabled = false
            end
            
            -- Replace default animation script with custom one
            if v:FindFirstChild("Animate") then
                v.Animate:Destroy()
            end
            local newAnimate = animate:Clone()
            newAnimate.Parent = v
            newAnimate.Disabled = false
        end
    end)
end

--------------------------------------------------------------------------------
--                             PSEUDO-CODE SUMMARY                             --
--------------------------------------------------------------------------------

-- 1. Clone all needed modules (Compass, Assets, Ragdoll, Sounds, Animation).
-- 2. Insert character sound effects into every player character by default.
-- 3. Install and enable the Adonis admin system for server administration.
-- 4. Place asset folders into ServerStorage and ReplicatedStorage so the server
--    and clients have access to shared resources.
-- 5. Add the compass UI and custom animation controller to all player characters.
-- 6. Enable the ragdoll system on the server.
-- 7. (Optional) Load custom chat modules if the default Roblox chat is disabled.
-- 8. After a short delay, loop through every active character in workspace:
--       a. Ensure they have the character sound module
--       b. Ensure they have the compass module
--       c. Remove Roblox’s default animation script
--       d. Insert the custom animation script
-- 9. End function — character systems, assets, animations, UI, and admin tools
--    are now fully initialized and ready in-game.

--------------------------------------------------------------------------------
