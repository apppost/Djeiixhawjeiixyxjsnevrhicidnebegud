local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CommandTerminal"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 1000
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, -0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.BackgroundTransparency = 1
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 10, 10)
shadow.Parent = mainFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ COMMAND TERMINAL"
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 8)
closeBtnCorner.Parent = closeBtn

local infoText = Instance.new("TextLabel")
infoText.Name = "InfoText"
infoText.Size = UDim2.new(1, -40, 0, 180)
infoText.Position = UDim2.new(0, 20, 0, 60)
infoText.BackgroundTransparency = 1
infoText.Text = [[📌 AVAILABLE COMMANDS:

*Rank - Open Leaderboard
*Console - Open Console (F9)
*Reset - Disable Reset Button
*Unreset - Enable Reset Button
*Self - Load Self Chat Script
*H - Respawn Character
*Term - Toggle Terminal

💡 Type commands in chat to execute!]]
infoText.TextColor3 = Color3.fromRGB(200, 200, 200)
infoText.TextSize = 16
infoText.Font = Enum.Font.Gotham
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, -40, 0, 40)
statusLabel.Position = UDim2.new(0, 20, 1, -50)
statusLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
statusLabel.Text = "⏺ Listening for commands..."
statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Parent = mainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusLabel

local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local slideIn = TweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -250, 0.5, -150)})
slideIn:Play()

local function slideOut()
    local tweenOut = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -250, -0.5, 0)})
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        mainFrame.Visible = false
    end)
end

closeBtn.MouseButton1Click:Connect(function()
    slideOut()
end)

closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
end)

local function executeCommand(command)
    command = command:lower():gsub("^%*", "")
    
    statusLabel.Text = "⚙ Executing: *" .. command
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    wait(0.3)
    
    if command == "rank" then
        statusLabel.Text = "✓ Opening Leaderboard..."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
        
    elseif command == "console" then
        statusLabel.Text = "✓ Opening Console (F9)..."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        StarterGui:SetCore("DevConsoleVisible", true)
        
    elseif command == "reset" then
        statusLabel.Text = "✓ Reset Character disabled!"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        StarterGui:SetCore("ResetButtonCallback", false)
        
    elseif command == "unreset" then
        statusLabel.Text = "✓ Reset Character enabled!"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        StarterGui:SetCore("ResetButtonCallback", true)
        
    elseif command == "self" then
        statusLabel.Text = "⏳ Loading Self Chat Script..."
        statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/apppost/Djeiixhawjeiixyxjsnevrhicidnebegud/refs/heads/main/Self-chat_self-talk"))()
        end)
        if success then
            statusLabel.Text = "✓ Self Chat Script loaded!"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            statusLabel.Text = "❌ Failed to load script!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        
    elseif command == "h" then
        statusLabel.Text = "🔄 Respawning character..."
        statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
        local success, err = pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 0
            end
        end)
        if success then
            statusLabel.Text = "✓ Character respawned!"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            statusLabel.Text = "❌ Failed to respawn!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        
    elseif command == "term" then
        statusLabel.Text = "✓ Toggling Terminal..."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        wait(0.5)
        if mainFrame.Visible then
            slideOut()
        else
            mainFrame.Visible = true
            mainFrame.Position = UDim2.new(0.5, -250, -0.5, 0)
            slideIn:Play()
        end
        
    else
        statusLabel.Text = "❌ Unknown command: *" .. command
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
    
    wait(2)
    statusLabel.Text = "⏺ Listening for commands..."
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end

player.Chatted:Connect(function(message)
    if message:sub(1, 1) == "*" then
        local command = message:sub(2)
        executeCommand(command)
    end
end)

print("✓ Command Terminal loaded successfully!")
print("Use *Term to toggle terminal")
