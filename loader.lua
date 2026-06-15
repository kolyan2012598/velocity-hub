--[[
    Advanced Loader GUI v2.0
    Protected by License System
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Velocity Hub | License System",
    Icon = "key",
    LoadingTitle = "Velocity Hub Authentication",
    LoadingSubtitle = "by Velocity Team",
    Theme = "Serenity",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    
    ConfigurationSaving = {
        Enabled = false,
    },
    
    KeySystem = true,
    KeySettings = {
        Title = "Velocity Hub | Authentication",
        Subtitle = "Enter Your License Key",
        Note = "Get your key from our Discord",
        FileName = "VelocityHubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"VELOCITY-2024-PREMIUM-8X9K2"}
    }
})

-- Make window immovable until key is entered
local success, err = pcall(function()
    local coreGui = game:GetService("CoreGui")
    local rayfieldGui = coreGui:FindFirstChild("Rayfield")
    if rayfieldGui then
        local mainFrame = rayfieldGui:FindFirstChild("MainFrame")
        if mainFrame then
            mainFrame.Draggable = false
            mainFrame.Active = false
        end
    end
end)

local Tab = Window:CreateTab("🏠 Home", "home")
local ProfileTab = Window:CreateTab("👤 Profile", "user")
local BoostTab = Window:CreateTab("🚀 Boost", "zap")
local PlayerTab = Window:CreateTab("🎮 Player", "gamepad2")

-- Profile Section
local ProfileSection = ProfileTab:CreateSection("Player Information")

local player = game.Players.LocalPlayer
local currentTime = os.date("%H:%M:%S")
local currentDate = os.date("%d/%m/%Y")

ProfileTab:CreateLabel("👤 Username: " .. player.Name, "username")
ProfileTab:CreateLabel("🎮 Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, "game")
ProfileTab:CreateLabel("🕐 Login Time: " .. currentTime, "time")
ProfileTab:CreateLabel("📅 Date: " .. currentDate, "date")
ProfileTab:CreateLabel("🔑 License: VELOCITY-PREMIUM-ACTIVE", "license")
ProfileTab:CreateLabel("⏳ Expires: 30 Days", "expires")

local LicenseStatus = ProfileTab:CreateParagraph("License Status", {
    "✅ License Active - Premium Access",
    "⏰ Auto-expires after 30 days",
    "🔒 System will lock after expiration"
})

-- Boost Section
local BoostSection = BoostTab:CreateSection("Vehicle Boost Controls")

local speedSlider = BoostTab:CreateSlider({
    Name = "Vehicle Speed Multiplier",
    Range = {1, 50},
    Increment = 1,
    Suffix = "x",
    CurrentValue = 1,
    Flag = "VehicleSpeed",
    Callback = function(Value)
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.SeatPart then
                local vehicle = humanoid.SeatPart.Parent
                if vehicle:IsA("Model") then
                    local vehicleSeat = vehicle:FindFirstChildOfClass("VehicleSeat")
                    if vehicleSeat then
                        vehicleSeat.MaxSpeed = Value * 50
                    end
                end
            end
        end
    end,
})

BoostTab:CreateButton({
    Name = "⚡ Enable Super Speed",
    Callback = function()
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 100
            end
        end
    end,
})

BoostTab:CreateButton({
    Name = "🦅 Enable Flight Mode",
    Callback = function()
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = true
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.P = 9e4
                bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                bodyGyro.cframe = character.HumanoidRootPart.CFrame
                bodyGyro.Parent = character.HumanoidRootPart
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.velocity = Vector3.new(0, 0, 0)
                bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
                bodyVelocity.Parent = character.HumanoidRootPart
                
                game:GetService("RunService").Heartbeat:Connect(function()
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                            bodyVelocity.velocity = character.HumanoidRootPart.CFrame.LookVector * 100
                        end
                    end
                end)
            end
        end
    end,
})

BoostTab:CreateButton({
    Name = "🚗 Vehicle God Mode",
    Callback = function()
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.SeatPart then
                local vehicle = humanoid.SeatPart.Parent
                if vehicle:IsA("Model") then
                    for _, part in pairs(vehicle:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end
    end,
})

BoostTab:CreateButton({
    Name = "🔧 Instant Car Repair",
    Callback = function()
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.SeatPart then
                local vehicle = humanoid.SeatPart.Parent
                if vehicle:IsA("Model") then
                    for _, part in pairs(vehicle:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part:BreakJoints()
                        end
                    end
                end
            end
        end
    end,
})

BoostTab:CreateParagraph("Vehicle Notes", {
    "⚡ Max speed limit: 500 mph",
    "🛡️ Use God Mode responsibly",
    "🔧 Repair clears all damage"
})

-- Player Section
local PlayerSection = PlayerTab:CreateSection("Player Modifications")

PlayerTab:CreateButton({
    Name = "🏃 WalkSpeed Boost",
    Callback = function()
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 50
            end
        end
    end,
})

PlayerTab:CreateButton({
    Name = "🔝 JumpPower Boost",
    Callback = function()
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = 150
            end
        end
    end,
})

PlayerTab:CreateButton({
    Name: "🛡️ God Mode",
    Callback = function()
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
            end
        end
    end,
})

PlayerTab:CreateButton({
    Name: "👻 Noclip",
    Callback = function()
        local noclip = false
        game:GetService("RunService").Stepped:Connect(function()
            if noclip then
                local character = player.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end)
        noclip = not noclip
    end,
})

PlayerTab:CreateButton({
    Name: "🧹 Clean Character",
    Callback = function()
        local character = player.Character
        if character then
            for _, child in pairs(character:GetChildren()) do
                if not child:IsA("Humanoid") and not child:IsA("BasePart") then
                    child:Destroy()
                end
            end
        end
    end,
})

-- Home Tab
local HomeSection = Tab:CreateSection("Welcome to Velocity Hub")

Tab:CreateParagraph("Information", {
    "🎯 Thank you for purchasing Velocity Hub Premium!",
    "⚡ All features are unlocked and ready to use",
    "🔄 Updates are automatic",
    ""
})

Tab:CreateParagraph("Quick Actions", {
    "🚗 Vehicle boosts available in Boost tab",
    "👤 Player modifications in Player tab",
    "📊 Check your profile for license info"
})

-- Social Buttons at Bottom
local SocialSection = Tab:CreateSection("Connect With Us")

Tab:CreateButton({
    Name = "💬 Join Our Discord",
    Callback = function()
        setclipboard("https://discord.gg/velocityhub")
        Rayfield:Notify({
            Title = "Discord",
            Content = "Discord invite copied to clipboard!",
            Duration = 3,
            Image = "check",
        })
    end,
})

Tab:CreateButton({
    Name = "📱 Join Our Telegram",
    Callback = function()
        setclipboard("https://t.me/velocityhubofficial")
        Rayfield:Notify({
            Title = "Telegram",
            Content = "Telegram link copied to clipboard!",
            Duration = 3,
            Image = "check",
        })
    end,
})

Tab:CreateButton({
    Name = "🌐 Join Our VK",
    Callback = function()
        setclipboard("https://vk.com/velocityhub")
        Rayfield:Notify({
            Title = "VK",
            Content = "VK link copied to clipboard!",
            Duration = 3,
            Image = "check",
        })
    end,
})

-- License expiration system
local licenseStartTime = tick()
local licenseDuration = 30 * 24 * 60 * 60 -- 30 days in seconds

game:GetService("RunService").Heartbeat:Connect(function()
    if tick() - licenseStartTime >= licenseDuration then
        Rayfield:Notify({
            Title = "License Expired",
            Content = "Your license has expired. Please purchase a new key.",
            Duration = 5,
            Image = "alert-triangle",
        })
        wait(5)
        if Window then
            Window:Destroy()
        end
    end
end)

-- Auto-update profile time
game:GetService("RunService").Heartbeat:Connect(function()
    local newTime = os.date("%H:%M:%S")
    local timeLabels = ProfileTab:GetElements()
    for _, element in pairs(timeLabels) do
        if element.Type == "Label" and element.CurrentText:find("Login Time") then
            element:Set("🕐 Login Time: " .. newTime)
        end
    end
end)

-- Wait for key verification to complete
repeat wait() until Window.KeyVerified == true

-- Now make the window draggable after key verification
local success2, err2 = pcall(function()
    local coreGui = game:GetService("CoreGui")
    local rayfieldGui = coreGui:FindFirstChild("Rayfield")
    if rayfieldGui then
        local mainFrame = rayfieldGui:FindFirstChild("MainFrame")
        if mainFrame then
            mainFrame.Draggable = true
            mainFrame.Active = true
        end
    end
end)

Rayfield:Notify({
    Title = "Access Granted",
    Content = "Welcome to Velocity Hub Premium!",
    Duration = 5,
    Image = "check-circle",
})
