return function()
	local Verison = "DEVELOPMENT"
	print("Verison : " .. Verison)
	
	local TextChatService = game:GetService("TextChatService")
	TextChatService.ChatWindowConfiguration.Enabled = false
	TextChatService.ChatInputBarConfiguration.Enabled = false
	
	print("Helm was here")
	local AeroClient = script.AeroClient:Clone()
	local AeroShared = script.AeroShared:Clone()
	local AeroServer = script.AeroServer:Clone()
	local AeroServerMain = script.AeroServerMain:Clone()
	--local DynamicWeather = script.DynamicWeather:Clone()

	local Packages = script.Packages:Clone()
	local ServerPackages = script.ServerPackages:Clone()

	local VersionObj = Instance.new("StringValue")
	VersionObj.Name = "Version"
	VersionObj.Value = Verison
	VersionObj.Parent = game.ReplicatedStorage

	local DebugMode = true

	local Module = DebugMode and game.ReplicatedStorage:FindFirstChild("MainModule") or 15040573421

	require(Module)()
	
	if not game.ServerScriptService:FindFirstChild("TechSetup") then
		require(70586650782225)()
	end

	--Packages
	Packages.Parent = game:GetService("ReplicatedStorage").Assets
	ServerPackages.Parent = game:GetService("ServerStorage").Assets
	--Aero

	AeroShared.Parent = game:GetService("ReplicatedStorage")
	AeroShared.Name = "Aero"

	AeroServerMain.Parent = game:GetService("ServerStorage")
	AeroServerMain.Name = "Aero"

	AeroServer.Parent = game:GetService("ServerScriptService")
	AeroServer.Name = "Aero"

	--DynamicWeather.Parent = game:GetService("ServerScriptService")
	--DynamicWeather.CPI.ServerScriptService.WeatherInitialize.Disabled = false

	AeroServer.Internal.AeroServer.Disabled = false

	-- AeroClient.Parent = game:GetService("StarterPlayer").StarterPlayerScripts
	-- AeroClient.Name = "Aero"

	local hackything = Instance.new("ScreenGui")
	hackything.Name = "Aero"
	hackything.ResetOnSpawn = false

	AeroClient.Parent = hackything
	AeroClient.Name = "Aero"
	
	for i, player in pairs(game.Players:GetPlayers()) do
		task.delay(1, function()
			print("Loading Aero for " .. player.Name)
			local Clone = hackything:Clone()
			Clone.Parent = player.PlayerGui
			Clone.Name = "Aero"
			print("Loaded Aero for " .. player.Name, Clone, Clone.Parent)
		end)
	end

	game.Players.PlayerAdded:Connect(function(player)
		task.wait(1)
		print("Loading Aero for " .. player.Name)
		local Clone = hackything:Clone()
		Clone.Parent = player.PlayerGui
		Clone.Name = "Aero"
	end)
end
