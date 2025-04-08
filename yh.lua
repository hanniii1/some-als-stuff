local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "TeleportTimerGUI"
gui.ResetOnSpawn = false

-- Main draggable frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 170)
main.Position = UDim2.new(0.5, -150, 0.5, -85)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Restart Match Timer"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Time label
local timeLabel = Instance.new("TextLabel", main)
timeLabel.Position = UDim2.new(0.5, -50, 0, 40)
timeLabel.Size = UDim2.new(0, 100, 0, 20)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Time: 3580s"
timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextSize = 16

-- Slider background (Optional, can be kept or removed as per your preference)
local sliderBG = Instance.new("Frame", main)
sliderBG.Position = UDim2.new(0.5, -100, 0, 70)
sliderBG.Size = UDim2.new(0, 200, 0, 6)
sliderBG.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
sliderBG.BorderSizePixel = 0
sliderBG.Name = "SliderBG"

Instance.new("UICorner", sliderBG).CornerRadius = UDim.new(0, 3)

-- Knob (Optional, can be kept or removed as per your preference)
local knob = Instance.new("Frame", sliderBG)
knob.Size = UDim2.new(0, 10, 0, 20)
knob.Position = UDim2.new(0, 0, 0.5, -10)
knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
knob.BorderSizePixel = 0
knob.Name = "Knob"

Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

-- Credit label (Optional)
local credit = Instance.new("TextLabel", main)
credit.Size = UDim2.new(1, -10, 0, 15)
credit.Position = UDim2.new(0, 5, 1, -20)
credit.Text = "made by: vxq"
credit.Font = Enum.Font.Gotham
credit.TextColor3 = Color3.fromRGB(100, 100, 100)
credit.TextSize = 12
credit.BackgroundTransparency = 1
credit.TextXAlignment = Enum.TextXAlignment.Right

-- Countdown logic
local running = false
local selectedTime = 3580  -- Set the time to 3580s

-- Start the countdown immediately
local function startCountdown()
    running = true

    -- Disable interactions
    sliderBG.Active = false
    knob.Active = false

    for i = selectedTime, 0, -1 do
        timeLabel.Text = "Time: " .. i .. "s"
        task.wait(1)
    end

    -- 🚀 Fire the new remote
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RestartMatch"):FireServer()

    -- Reset the display and interactions
    timeLabel.Text = "Time: " .. selectedTime .. "s"
    sliderBG.Active = true
    knob.Active = true
    running = false
end

-- Immediately start the countdown when the script runs
startCountdown()
