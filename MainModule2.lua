return function()
	local Compass = script.CompassClient:Clone()
	local AssetsShared = script.AssetsShared:Clone()
	local AssetsServer = script.AssetsServer:Clone()
	--local BetterChatV3 = script["BetterChat V3"]:Clone()
	local R6Ragdoll = script.R6Ragdoll:Clone()
	local animate = script.Animate:Clone()
	
	local RbxCharacterSounds = script.RbxCharacterSounds:Clone()
	
	RbxCharacterSounds.Parent = game:GetService("StarterPlayer").StarterCharacterScripts
	RbxCharacterSounds.Enabled = true

	--local SocialChat = script.SocialChat:Clone()
	
	local AdonisLoader = script.Adonis_Loader:Clone()
	AdonisLoader.Parent = game:GetService("ServerScriptService")
	AdonisLoader.Script1.Enabled = true
	
	animate.Parent = game:GetService("StarterPlayer").StarterCharacterScripts
	animate.Disabled = false
	
	AssetsServer.Parent = game:GetService("ServerStorage")
	AssetsServer.Name = "Assets"

	AssetsShared.Parent = game:GetService("ReplicatedStorage")
	AssetsShared.Name = "Assets"
	
	Compass.Parent = game:GetService("StarterPlayer").StarterCharacterScripts
	Compass.Disabled = false
	
	R6Ragdoll.Parent = game.ServerScriptService
	R6Ragdoll.Disabled = false
	
	
	
	--[[
	if game:GetService("Chat").LoadDefaultChat == false then
		BetterChatV3.Parent =  game:GetService("ServerScriptService")
		BetterChatV3.Config.Loader.Enabled = true
		--SocialChat.Parent = game:GetService("ServerScriptService")
		--SocialChat.Loader.Enabled = true
	end
	--]]
	
	task.defer(function()
		local PlayersFolder = workspace:WaitForChild("Players")
		
		for i,v in pairs(PlayersFolder:GetChildren()) do
			if not v:FindFirstChild("RbxCharacterSounds") then
				local newRbxCharacterSounds = RbxCharacterSounds:Clone()
				newRbxCharacterSounds.Parent = v
				newRbxCharacterSounds.Enabled = true
			end
			
			if not v:FindFirstChild("CompassClient") then
				local newCompass = Compass:Clone()
				newCompass.Parent = v
				newCompass.Disabled = false
			end
			
			if v:FindFirstChild("Animate") then
				v.Animate:Destroy()
			end
			local newAnimate = animate:Clone()
			newAnimate.Parent = v
			newAnimate.Disabled = false
		end
	end)
end
