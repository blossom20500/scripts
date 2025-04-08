-- Script 1 (GUI and functionality)
local KeyboardguiWarriorRoberrVersion = Instance.new("ScreenGui")
local Drag = Instance.new("Frame")
local Close = Instance.new("TextButton")
local RButtonBackground = Instance.new("Frame") -- Transparent black outline for RButton
local RButton = Instance.new("TextButton")

-- GUI properties
KeyboardguiWarriorRoberrVersion.Name = "Keyboard gui WarriorRoberr Version"
KeyboardguiWarriorRoberrVersion.Parent = game.CoreGui
KeyboardguiWarriorRoberrVersion.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Transparent Drag frame acting as an outline
Drag.Name = "Drag"
Drag.Parent = KeyboardguiWarriorRoberrVersion
Drag.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Drag.BorderSizePixel = 0
Drag.Position = UDim2.new(0.147916675, 0, 0.0593749993, 0)
Drag.Size = UDim2.new(0, 75, 0, 90)  -- 3x bigger (originally 25x30)
Drag.Active = true
Drag.Draggable = true
Drag.BackgroundTransparency = 1  -- Make the drag part fully transparent

-- Smaller Close button, positioned to avoid accidental clicks
Close.Name = "Close"
Close.Parent = Drag
Close.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.95, 0, -0.00729167089, 0)  -- Moved the "X" button closer
Close.Size = UDim2.new(0, 9, 0, 9)  -- 3x bigger (originally 3x3)
Close.Font = Enum.Font.SourceSans
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 9  -- Larger text for "X"
Close.MouseButton1Click:Connect(function()
    KeyboardguiWarriorRoberrVersion:Destroy()
end)

-- RButton background (black outline) - Transparent black outline around R button
RButtonBackground.Name = "RButtonBackground"
RButtonBackground.Parent = Drag
RButtonBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Black color for the outline
RButtonBackground.BorderSizePixel = 0
RButtonBackground.Position = UDim2.new(0.5, -15, 0, 0)  -- Position around the R button
RButtonBackground.Size = UDim2.new(0, 42, 0, 42)  -- 3x bigger (originally 14x14)

-- RButton (Red button with letter "R") - Make the R button bigger
RButton.Name = "RButton"
RButton.Parent = Drag
RButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red color for the button
RButton.BorderSizePixel = 0
RButton.Position = UDim2.new(0.5, -15, 0, 0)  -- Position it near the center
RButton.Size = UDim2.new(0, 42, 0, 42)  -- 3x bigger (originally 14x14)
RButton.Font = Enum.Font.SourceSans
RButton.Text = "R"
RButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RButton.TextSize = 24  -- Larger text for "R"
RButton.MouseButton1Click:Connect(function()
    -- Trigger the "R" key press functionality
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.R, false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)

-- Script 2 (loadstring to fetch and execute external script)
wait(1) -- Add a delay before running script 2
loadstring(game:HttpGet('https://raw.githubusercontent.com/blossom20500/scripts/refs/heads/main/script1.lua'))()

-- Send Roblox notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Green Light :P",
    Text = "By Blossom",
    Duration = 5
})
