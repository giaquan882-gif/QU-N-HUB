local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Xóa menu cũ nếu đã tồn tại
if PlayerGui:FindFirstChild("QuânHub") then PlayerGui.QuânHub:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QuânHub"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 360)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Title.Text = "QUÂN HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 10) -- Tạo khoảng cách cho đẹp

local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = MainFrame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Cấu hình thông số
local WalkSpeed = 100
local JumpPower = 120
local InfJumpEnabled = false

local SpeedBtn = createButton("Speed: OFF", function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        if hum.WalkSpeed ~= WalkSpeed then
            hum.WalkSpeed = WalkSpeed
            SpeedBtn.Text = "Speed: ON"
        else
            hum.WalkSpeed = 16
            SpeedBtn.Text = "Speed: OFF"
        end
    end
end)

local JumpBtn = createButton("High Jump: OFF", function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        if hum.JumpPower ~= JumpPower then
            hum.JumpPower = JumpPower
            JumpBtn.Text = "High Jump: ON"
        else
            hum.JumpPower = 50
            JumpBtn.Text = "High Jump: OFF"
        end
    end
end)

local InfJumpBtn = createButton("Inf Jump: OFF", function()
    InfJumpEnabled = not InfJumpEnabled
    InfJumpBtn.Text = InfJumpEnabled and "Inf Jump: ON" or "Inf Jump: OFF"
end)

UserInputService.JumpRequest:Connect(function()
    if InfJumpEnabled then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then hum:ChangeState("Jumping") end
    end
end)

createButton("Close Menu", function() ScreenGui:Destroy() end)
