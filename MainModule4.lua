return function()
	local AeroClient = script.AeroClient:Clone()
	local AeroShared = script.AeroShared:Clone()
	local AeroServer = script.AeroServer:Clone()
	local AeroServerMain = script.AeroServerMain:Clone()
	local Compass = script.CompassClient:Clone()
	local AssetsShared = script.AssetsShared:Clone()
	local AssetsServer = script.AssetsServer:Clone()
	--local DynamicWeather = script.DynamicWeather:Clone()
	
	local GameAnalyticsServerInit = script.GameAnalyticsServerInit:Clone()
	local GameAnalyticsClient = script.GameAnalyticsClient:Clone()
	local GameAnalytics = script.GameAnalytics:Clone()
	local Postie = script.Postie:Clone()
	
	-- Game Analytics
	
	GameAnalyticsServerInit.Parent = game:GetService("ServerScriptService")
	GameAnalytics.Parent = game:GetService("ServerStorage")
	Postie.Parent = game:GetService("ReplicatedStorage")
	GameAnalyticsServerInit.Disabled = false
	GameAnalyticsClient.Parent = game:GetService("StarterPlayer").StarterPlayerScripts
	
	--Aero
	
	AeroShared.Parent = game:GetService("ReplicatedStorage")
	AeroShared.Name = "Aero"
	
	AeroServerMain.Parent = game:GetService("ServerStorage")
	AeroServerMain.Name = "Aero"
	
	AssetsServer.Parent = game:GetService("ServerStorage")
	AssetsServer.Name = "Assets"
	
	AssetsShared.Parent = game:GetService("ReplicatedStorage")
	AssetsShared.Name = "Assets"
	
	AeroServer.Parent = game:GetService("ServerScriptService")
	AeroServer.Name = "Aero"
	
	--DynamicWeather.Parent = game:GetService("ServerScriptService")
	--DynamicWeather.CPI.ServerScriptService.WeatherInitialize.Disabled = false
	
	AeroServer.Internal.AeroServer.Disabled = false
	
	AeroClient.Parent = game:GetService("StarterPlayer").StarterPlayerScripts
	AeroClient.Name = "Aero"
	
	Compass.Parent = game:GetService("StarterPlayer").StarterCharacterScripts
	Compass.Disabled = false
	
	for i,v in pairs(game.Players:GetPlayers()) do
		if v:FindFirstChild("PlayerScripts") then
			if not v.PlayerScripts:FindFirstChild("Aero") then
				local Clone = script.AeroClient:Clone()
				Clone.Parent = v.PlayerScripts
			end
			if not v.PlayerScripts:FindFirstChild("GameAnalyticsClient") then
				local Clone = script.GameAnalyticsClient:Clone()
				Clone.Parent = v.PlayerScripts
			end
			if v.Character and not v:FindFirstChild("CompassClient") then
				local eCompass = script.CompassClient:Clone()
				eCompass.Parent = game:GetService("StarterPlayer").StarterCharacterScripts
				eCompass.Disabled = false
			end
		end
	end
end
