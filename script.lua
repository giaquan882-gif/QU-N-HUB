local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("QuânHubUniversal") then PlayerGui.QuânHubUniversal:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QuânHubUniversal"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 230, 0, 420)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 210, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Title.Text = "QUÂN HUB - UNIVERSAL"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 210, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = MainFrame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local WalkSpeed = 100
local JumpPower = 120
local InfJumpEnabled = false
local InvisibleEnabled = false
local NoclipEnabled = false

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

local InviBtn = createButton("Invisible: OFF", function()
    InvisibleEnabled = not InvisibleEnabled
    InviBtn.Text = InvisibleEnabled and "Invisible: ON" or "Invisible: OFF"
    
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                if part.Name ~= "HumanoidRootPart" then
                    part.Transparency = InvisibleEnabled and 1 or 0
                end
            end
        end
    end
end)

local NoclipBtn = createButton("Noclip: OFF", function()
    NoclipEnabled = not NoclipEnabled
    NoclipBtn.Text = NoclipEnabled and "Noclip: ON" or "Noclip: OFF"
end)

game:GetService("RunService").Stepped:Connect(function()
    if NoclipEnabled then
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

createButton("Close Menu", function() ScreenGui:Destroy() end)
