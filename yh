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
timeLabel.Text = "Time: 10s"
timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextSize = 16

-- Slider background
local sliderBG = Instance.new("Frame", main)
sliderBG.Position = UDim2.new(0.5, -100, 0, 70)
sliderBG.Size = UDim2.new(0, 200, 0, 6)
sliderBG.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
sliderBG.BorderSizePixel = 0
sliderBG.Name = "SliderBG"

Instance.new("UICorner", sliderBG).CornerRadius = UDim.new(0, 3)

-- Knob
local knob = Instance.new("Frame", sliderBG)
knob.Size = UDim2.new(0, 10, 0, 20)
knob.Position = UDim2.new(0, 0, 0.5, -10)
knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
knob.BorderSizePixel = 0
knob.Name = "Knob"

Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

-- Start button
local button = Instance.new("TextButton", main)
button.Position = UDim2.new(0.5, -50, 1, -60)
button.Size = UDim2.new(0, 100, 0, 30)
button.Text = "Start"
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

-- Credit label
local credit = Instance.new("TextLabel", main)
credit.Size = UDim2.new(1, -10, 0, 15)
credit.Position = UDim2.new(0, 5, 1, -20)
credit.Text = "made by: vxq"
credit.Font = Enum.Font.Gotham
credit.TextColor3 = Color3.fromRGB(100, 100, 100)
credit.TextSize = 12
credit.BackgroundTransparency = 1
credit.TextXAlignment = Enum.TextXAlignment.Right

-- Slider logic
local dragging = false
local maxTime = 3600
local minTime = 10
local selectedTime = 10

local UIS = game:GetService("UserInputService")

local function updateSlider(inputX)
	local barStart = sliderBG.AbsolutePosition.X
	local barWidth = sliderBG.AbsoluteSize.X
	local clampedX = math.clamp(inputX - barStart, 0, barWidth)

	local percent = clampedX / barWidth
	selectedTime = math.floor(percent * (maxTime - minTime) + minTime)

	knob.Position = UDim2.new(0, clampedX - knob.AbsoluteSize.X / 2, knob.Position.Y.Scale, knob.Position.Y.Offset)
	timeLabel.Text = "Time: " .. selectedTime .. "s"
end

sliderBG.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		main.Draggable = false
		updateSlider(input.Position.X)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		updateSlider(input.Position.X)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
		main.Draggable = true
	end
end)

-- Countdown and restart logic
local running = false
button.MouseButton1Click:Connect(function()
	if running then return end
	running = true

	button.Text = "Running..."
	button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	button.Active = false
	sliderBG.Active = false
	knob.Active = false

	for i = selectedTime, 0, -1 do
		timeLabel.Text = "Time: " .. i .. "s"
		task.wait(1)
	end

	-- 🚀 Fire the new remote
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RestartMatch"):FireServer()

	-- Reset
	timeLabel.Text = "Time: " .. selectedTime .. "s"
	button.Text = "Start"
	button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	button.Active = true
	sliderBG.Active = true
	knob.Active = true
	running = false
end)
