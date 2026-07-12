--QUÂN-HUB
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("MovementClientHub") then
    CoreGui.MovementClientHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MovementClientHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 260)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Title.Text = "MOVEMENT CLIENT"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

local function createToggle(text, layoutOrder, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 200, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Button.Text = text .. ": OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSans
    Button.LayoutOrder = layoutOrder
    Button.Parent = MainFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Button

    local active = false
    Button.MouseButton1Click:Connect(function()
        active = not active
        Button.Text = text .. (active and ": ON" or ": OFF")
        Button.BackgroundColor3 = active and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(50, 50, 60)
        callback(active)
    end)
    return Button
end

local speedActive = false
local defaultSpeed = 16
local hackSpeed = 100

createToggle("Chạy Nhanh (Speed)", 1, function(state)
    speedActive = state
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    if speedActive then
        hum.WalkSpeed = hackSpeed
    else
        hum.WalkSpeed = defaultSpeed
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    if speedActive then
        local hum = char:WaitForChild("Humanoid")
        hum.WalkSpeed = hackSpeed
    end
end)

local jumpActive = false
local defaultJump = 50
local hackJump = 120

createToggle("Nhảy Cao (High Jump)", 2, function(state)
    jumpActive = state
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    if jumpActive then
        hum.JumpPower = hackJump
    else
        hum.JumpPower = defaultJump
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    if jumpActive then
        local hum = char:WaitForChild("Humanoid")
        hum.JumpPower = hackJump
    end
end)

local infJumpActive = false

createToggle("Nhảy Vô Hạn (Inf Jump)", 3, function(state)
    infJumpActive = state
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpActive then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState("Jumping")
        end
    end
end)

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 200, 0, 35)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
CloseButton.Text = "Tắt Menu"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.LayoutOrder = 4
CloseButton.Parent = MainFrame
local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 6)
UICornerClose.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    infJumpActive = false
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = defaultSpeed
        char:FindFirstChildOfClass("Humanoid").JumpPower = defaultJump
    end
    ScreenGui:Destroy()
end)
