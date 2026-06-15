-- Velocity Hub Premium Loader
-- Version 2.0

-- Загрузка Rayfield UI Library
local Rayfield
pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not Rayfield then
    game.Players.LocalPlayer:Kick("Failed to load UI Library")
    return
end

local Window = Rayfield:CreateWindow({
    Name = "Velocity Hub | Premium",
    Icon = "zap",
    LoadingTitle = "Velocity Hub Premium",
    LoadingSubtitle = "Loading Premium Features...",
    Theme = "Serenity",
    DisableRayfieldPrompts = true,
    
    ConfigurationSaving = {
        Enabled = false,
    },
    
    KeySystem = true,
    KeySettings = {
        Title = "Velocity Hub | License",
        Subtitle = "Enter Your License Key",
        Note = "Get key: discord.gg/velocityhub",
        FileName = "VelocityHubKey",
        SaveKey = true,
        Key = {"VELOCITY-2024-PREMIUM-8X9K2"}
    }
})

print("Window created, waiting for key...")

-- Ждём ввод ключа
repeat 
    wait()
    print("Waiting for key verification...")
until Window.KeyVerified == true

print("Key verified! Loading features...")

-- Сервисы
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- Функции
local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

local function getHum()
    local char = getChar()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
    local char = getChar()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- ТАБЫ
local MainTab = Window:CreateTab("🏠 Home", "home")
local ProfileTab = Window:CreateTab("👤 Profile", "user")
local PlayerTab = Window:CreateTab("🎮 Player", "gamepad2")
local BoostTab = Window:CreateTab("🚀 Boost", "zap")
local TeleportTab = Window:CreateTab("📍 Teleports", "map-pin")
local VisualTab = Window:CreateTab("👁️ Visuals", "eye")
local CombatTab = Window:CreateTab("⚔️ Combat", "crosshair")
local MiscTab = Window:CreateTab("🔧 Misc", "settings")

-- HOME TAB
MainTab:CreateSection("Welcome to Velocity Hub")

MainTab:CreateParagraph("Info", {
    "✅ Premium License Active",
    "🔑 Key: VELOCITY-2024-PREMIUM-8X9K2",
    "⏰ 30 Days Remaining",
    "🎮 All Features Unlocked"
})

MainTab:CreateSection("Social Links")

MainTab:CreateButton({
    Name = "💬 Discord Server",
    Callback = function()
        setclipboard("https://discord.gg/velocityhub")
        Rayfield:Notify({Title = "Discord", Content = "Link copied!", Duration = 3})
    end,
})

MainTab:CreateButton({
    Name = "📱 Telegram Channel",
    Callback = function()
        setclipboard("https://t.me/velocityhub")
        Rayfield:Notify({Title = "Telegram", Content = "Link copied!", Duration = 3})
    end,
})

MainTab:CreateButton({
    Name = "🌐 VK Community",
    Callback = function()
        setclipboard("https://vk.com/velocityhub")
        Rayfield:Notify({Title = "VK", Content = "Link copied!", Duration = 3})
    end,
})

-- PROFILE TAB
ProfileTab:CreateSection("Player Info")

local gameName = "Unknown"
pcall(function()
    gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end)

ProfileTab:CreateLabel("👤 Username: " .. player.Name)
ProfileTab:CreateLabel("🎮 Game: " .. gameName)
ProfileTab:CreateLabel("🕐 Time: " .. os.date("%H:%M:%S"))
ProfileTab:CreateLabel("📅 Date: " .. os.date("%d/%m/%Y"))
ProfileTab:CreateLabel("🔑 License: ACTIVE")
ProfileTab:CreateLabel("⏳ Expires: 30 Days")

ProfileTab:CreateParagraph("Status", {
    "✅ Premium Access",
    "🔒 Protected System",
    "🔄 Auto-Updates"
})

-- PLAYER TAB
PlayerTab:CreateSection("Movement")

PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        local hum = getHum()
        if hum then hum.WalkSpeed = v end
    end,
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 500},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(v)
        local hum = getHum()
        if hum then hum.JumpPower = v end
    end,
})

PlayerTab:CreateSection("Abilities")

-- Fly
local flyEnabled = false
local flyBodyGyro, flyBodyVelocity, flyConnection

PlayerTab:CreateToggle({
    Name = "Fly Mode",
    CurrentValue = false,
    Callback = function(v)
        flyEnabled = v
        local root = getRoot()
        if not root then return end
        
        if v then
            flyBodyGyro = Instance.new("BodyGyro")
            flyBodyGyro.P = 9e4
            flyBodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            flyBodyGyro.cframe = root.CFrame
            flyBodyGyro.Parent = root
            
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.velocity = Vector3.new(0, 0, 0)
            flyBodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
            flyBodyVelocity.Parent = root
            
            local speed = 50
            flyConnection = RS.Heartbeat:Connect(function()
                if not flyEnabled or not root or not root.Parent then
                    if flyBodyGyro then flyBodyGyro:Destroy() end
                    if flyBodyVelocity then flyBodyVelocity:Destroy() end
                    if flyConnection then flyConnection:Disconnect() end
                    return
                end
                
                if UIS:IsKeyDown(Enum.KeyCode.W) then
                    flyBodyVelocity.velocity = root.CFrame.LookVector * speed
                elseif UIS:IsKeyDown(Enum.KeyCode.S) then
                    flyBodyVelocity.velocity = -root.CFrame.LookVector * speed
                elseif UIS:IsKeyDown(Enum.KeyCode.Space) then
                    flyBodyVelocity.velocity = Vector3.new(0, speed, 0)
                elseif UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                    flyBodyVelocity.velocity = Vector3.new(0, -speed, 0)
                else
                    flyBodyVelocity.velocity = Vector3.new(0, 0, 0)
                end
            end)
        else
            if flyBodyGyro then flyBodyGyro:Destroy() end
            if flyBodyVelocity then flyBodyVelocity:Destroy() end
            if flyConnection then flyConnection:Disconnect() end
        end
    end,
})

-- Noclip
local noclipConnection

PlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(v)
        if v then
            noclipConnection = RS.Stepped:Connect(function()
                local char = getChar()
                if char then
                    for _, p in pairs(char:GetDescendants()) do
                        if p:IsA("BasePart") then
                            p.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConnection then 
                noclipConnection:Disconnect() 
                noclipConnection = nil
            end
        end
    end,
})

PlayerTab:CreateSection("Character")

PlayerTab:CreateButton({
    Name = "🛡️ God Mode",
    Callback = function()
        local hum = getHum()
        if hum then
            hum.MaxHealth = math.huge
            hum.Health = math.huge
        end
    end,
})

PlayerTab:CreateButton({
    Name = "🧹 Clean Character",
    Callback = function()
        local char = getChar()
        for _, v in pairs(char:GetChildren()) do
            if not v:IsA("Humanoid") and not v:IsA("BasePart") then
                v:Destroy()
            end
        end
    end,
})

PlayerTab:CreateButton({
    Name = "💀 Respawn",
    Callback = function()
        local hum = getHum()
        if hum then
            hum.Health = 0
        end
    end,
})

-- BOOST TAB
BoostTab:CreateSection("Vehicle Boost")

BoostTab:CreateSlider({
    Name = "Speed Multiplier",
    Range = {1, 50},
    Increment = 1,
    CurrentValue = 1,
    Callback = function(v)
        local char = getChar()
        local hum = getHum()
        if hum and hum.SeatPart then
            local vehicle = hum.SeatPart.Parent
            if vehicle and vehicle:IsA("Model") then
                local seat = vehicle:FindFirstChildOfClass("VehicleSeat")
                if seat then
                    seat.MaxSpeed = v * 50
                end
            end
        end
    end,
})

BoostTab:CreateButton({
    Name = "🚗 Vehicle God Mode",
    Callback = function()
        local hum = getHum()
        if hum and hum.SeatPart then
            local vehicle = hum.SeatPart.Parent
            if vehicle:IsA("Model") then
                for _, p in pairs(vehicle:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = false
                    end
                end
            end
        end
    end,
})

BoostTab:CreateButton({
    Name = "🔧 Repair Vehicle",
    Callback = function()
        local hum = getHum()
        if hum and hum.SeatPart then
            local vehicle = hum.SeatPart.Parent
            if vehicle:IsA("Model") then
                for _, p in pairs(vehicle:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end
    end,
})

-- TELEPORT TAB
TeleportTab:CreateSection("Quick Teleports")

TeleportTab:CreateButton({
    Name = "📌 Save Position",
    Callback = function()
        local root = getRoot()
        if root then
            _G.SavedPos = root.CFrame
        end
    end,
})

TeleportTab:CreateButton({
    Name = "📍 TP to Saved",
    Callback = function()
        local root = getRoot()
        if root and _G.SavedPos then
            root.CFrame = _G.SavedPos
        end
    end,
})

TeleportTab:CreateButton({
    Name = "👤 TP to Random Player",
    Callback = function()
        local others = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                table.insert(others, p)
            end
        end
        if #others > 0 then
            local target = others[math.random(1, #others)]
            local root = getRoot()
            if root and target.Character:FindFirstChild("HumanoidRootPart") then
                root.CFrame = target.Character.HumanoidRootPart.CFrame
            end
        end
    end,
})

-- VISUALS TAB
VisualTab:CreateSection("ESP")

local espObjects = {}

VisualTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Callback = function(v)
        if not v then
            for _, obj in pairs(espObjects) do
                pcall(function() obj:Remove() end)
            end
            espObjects = {}
            return
        end
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Parent = p.Character
                table.insert(espObjects, highlight)
            end
        end
        
        Players.PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function()
                if v and p.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.Parent = p.Character
                    table.insert(espObjects, highlight)
                end
            end)
        end)
    end,
})

VisualTab:CreateSection("World")

VisualTab:CreateSlider({
    Name = "Brightness",
    Range = {0, 10},
    Increment = 1,
    CurrentValue = 3,
    Callback = function(v)
        Lighting.Brightness = v
    end,
})

VisualTab:CreateSlider({
    Name = "FOV",
    Range = {30, 120},
    Increment = 1,
    CurrentValue = 70,
    Callback = function(v)
        WS.CurrentCamera.FieldOfView = v
    end,
})

-- COMBAT TAB
CombatTab:CreateSection("Aimbot")

local aimbotTarget = nil

CombatTab:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = false,
    Callback = function(v)
        if not v then
            aimbotTarget = nil
        end
    end,
})

CombatTab:CreateButton({
    Name = "🎯 Lock Nearest Player",
    Callback = function()
        local nearest = nil
        local nearestDist = math.huge
        local root = getRoot()
        if not root then return end
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local targetRoot = p.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    local dist = (root.Position - targetRoot.Position).Magnitude
                    if dist < nearestDist then
                        nearestDist = dist
                        nearest = p
                    end
                end
            end
        end
        
        aimbotTarget = nearest
    end,
})

-- MISC TAB
MiscTab:CreateSection("Game")

MiscTab:CreateButton({
    Name = "🔪 Kill All (R6)",
    Callback = function()
        local char = getChar()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.Health = 0
                end
            end
        end
    end,
})

MiscTab:CreateButton({
    Name = "🌀 SpinBot",
    Callback = function()
        local root = getRoot()
        if not root then return end
        local spin = RS.Heartbeat:Connect(function()
            root.CFrame = root.CFrame * CFrame.Angles(0, 0.5, 0)
        end)
        task.wait(5)
        spin:Disconnect()
    end,
})

MiscTab:CreateSection("Script")

MiscTab:CreateButton({
    Name = "🔄 Rejoin Server",
    Callback = function()
        local ts = game:GetService("TeleportService")
        ts:Teleport(game.PlaceId, player)
    end,
})

MiscTab:CreateButton({
    Name = "❌ Server Hop",
    Callback = function()
        local Http = game:GetService("HttpService")
        local ts = game:GetService("TeleportService")
        local servers = {}
        pcall(function()
            local cursor = ""
            repeat
                local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" .. (cursor ~= "" and "&cursor=" .. cursor or "")
                local data = game:HttpGet(url)
                local json = Http:JSONDecode(data)
                for _, server in pairs(json.data) do
                    if server.playing < server.maxPlayers then
                        table.insert(servers, server.id)
                    end
                end
                cursor = json.nextPageCursor or ""
            until cursor == "" or #servers > 0
            
            if #servers > 0 then
                ts:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], player)
            end
        end)
    end,
})

-- Уведомление об успешной загрузке
Rayfield:Notify({
    Title = "Velocity Hub",
    Content = "Successfully loaded!",
    Duration = 5,
    Image = "check-circle",
})

print("Velocity Hub loaded successfully!")
