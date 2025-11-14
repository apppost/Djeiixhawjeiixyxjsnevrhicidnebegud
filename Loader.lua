local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoaderGui"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 200)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxasset://textures/ui/GUI/ShadowedBox.png"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Script Loader"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -40, 0, 30)
statusText.Position = UDim2.new(0, 20, 0, 70)
statusText.BackgroundTransparency = 1
statusText.Text = "Initializing..."
statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
statusText.TextSize = 16
statusText.Font = Enum.Font.Gotham
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = mainFrame

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(1, -40, 0, 8)
progressBg.Position = UDim2.new(0, 20, 0, 120)
progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
progressBg.BorderSizePixel = 0
progressBg.Parent = mainFrame

local progressBgCorner = Instance.new("UICorner")
progressBgCorner.CornerRadius = UDim.new(0, 4)
progressBgCorner.Parent = progressBg

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBg

local progressFillCorner = Instance.new("UICorner")
progressFillCorner.CornerRadius = UDim.new(0, 4)
progressFillCorner.Parent = progressFill

local percentText = Instance.new("TextLabel")
percentText.Size = UDim2.new(1, -40, 0, 20)
percentText.Position = UDim2.new(0, 20, 0, 145)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.TextColor3 = Color3.fromRGB(150, 150, 150)
percentText.TextSize = 14
percentText.Font = Enum.Font.Gotham
percentText.TextXAlignment = Enum.TextXAlignment.Right
percentText.Parent = mainFrame

mainFrame.BackgroundTransparency = 1
title.TextTransparency = 1
statusText.TextTransparency = 1
percentText.TextTransparency = 1
progressBg.BackgroundTransparency = 1
progressFill.BackgroundTransparency = 1

local fadeInTween = TweenService:Create(mainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0})
local titleFadeTween = TweenService:Create(title, TweenInfo.new(0.3), {TextTransparency = 0})
local statusFadeTween = TweenService:Create(statusText, TweenInfo.new(0.3), {TextTransparency = 0})
local percentFadeTween = TweenService:Create(percentText, TweenInfo.new(0.3), {TextTransparency = 0})
local progressBgFadeTween = TweenService:Create(progressBg, TweenInfo.new(0.3), {BackgroundTransparency = 0})
local progressFillFadeTween = TweenService:Create(progressFill, TweenInfo.new(0.3), {BackgroundTransparency = 0})

fadeInTween:Play()
titleFadeTween:Play()
statusFadeTween:Play()
percentFadeTween:Play()
progressBgFadeTween:Play()
progressFillFadeTween:Play()

local function updateProgress(percent, status)
    percentText.Text = math.floor(percent) .. "%"
    statusText.Text = status
    
    local progressTween = TweenService:Create(
        progressFill,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(percent/100, 0, 1, 0)}
    )
    progressTween:Play()
end

local function closeLoader()
    local fadeOutTween = TweenService:Create(mainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    local titleFadeOutTween = TweenService:Create(title, TweenInfo.new(0.5), {TextTransparency = 1})
    local statusFadeOutTween = TweenService:Create(statusText, TweenInfo.new(0.5), {TextTransparency = 1})
    local percentFadeOutTween = TweenService:Create(percentText, TweenInfo.new(0.5), {TextTransparency = 1})
    local progressBgFadeOutTween = TweenService:Create(progressBg, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    local progressFillFadeOutTween = TweenService:Create(progressFill, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    
    fadeOutTween:Play()
    titleFadeOutTween:Play()
    statusFadeOutTween:Play()
    percentFadeOutTween:Play()
    progressBgFadeOutTween:Play()
    progressFillFadeOutTween:Play()
    
    fadeOutTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

task.spawn(function()
    wait(0.5)
    
    updateProgress(20, "Connecting to server...")
    wait(0.5)
    
    updateProgress(40, "Downloading script...")
    wait(0.3)
    
    local success, result = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/apppost/Djeiixhawjeiixyxjsnevrhicidnebegud/refs/heads/main/Stores-script.lua")
    end)
    
    if success then
        updateProgress(70, "Script downloaded!")
        wait(0.3)
        
        updateProgress(85, "Executing script...")
        wait(0.3)
        
        local loadSuccess, loadError = pcall(function()
            loadstring(result)()
        end)
        
        if loadSuccess then
            updateProgress(100, "Complete!")
            wait(0.5)
            closeLoader()
        else
            statusText.Text = "Error: " .. tostring(loadError)
            statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
            wait(3)
            closeLoader()
        end
    else
        statusText.Text = "Failed to download script!"
        statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        wait(3)
        closeLoader()
    end
end)
