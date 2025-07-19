-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EventToggleGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Create main draggable bar
local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 300, 0, 40)
bar.Position = UDim2.new(0.3, 0, 0.1, 0)
bar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
bar.Active = true
bar.Draggable = true
bar.Parent = screenGui

local barCorner = Instance.new("UICorner", bar)
barCorner.CornerRadius = UDim.new(0, 10)

-- Toggle button (minimize)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(1, -45, 0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
toggleButton.Text = "-"
toggleButton.TextSize = 24
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Parent = bar

local toggleCorner = Instance.new("UICorner", toggleButton)
toggleCorner.CornerRadius = UDim.new(0, 6)

-- Create main panel
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 300, 0, 100)
panel.Position = UDim2.new(0, 0, 1, 0)
panel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
panel.Visible = true
panel.Parent = bar

local panelCorner = Instance.new("UICorner", panel)
panelCorner.CornerRadius = UDim.new(0, 10)

-- Action button
local actionButton = Instance.new("TextButton")
actionButton.Size = UDim2.new(0.8, 0, 0, 40)
actionButton.Position = UDim2.new(0.1, 0, 0.5, -20)
actionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
actionButton.Text = "Trigger ZenEvent"
actionButton.TextSize = 18
actionButton.TextColor3 = Color3.new(1, 1, 1)
actionButton.Font = Enum.Font.GothamBold
actionButton.Parent = panel

local btnCorner = Instance.new("UICorner", actionButton)
btnCorner.CornerRadius = UDim.new(0, 6)

-- Minimize / Maximize logic
local isMinimized = false

toggleButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	panel.Visible = not isMinimized
	toggleButton.Text = isMinimized and "+" or "-"
end)

-- Trigger ZenEvent logic
actionButton.MouseButton1Click:Connect(function()
	-- Remove DinoEvent if exists
	local dinoEvent = Workspace:FindFirstChild("DinoEvent")
	if dinoEvent then
		dinoEvent:Destroy()
	end

	-- Move ZenEvent from ReplicatedStorage to Workspace
	local updateService = ReplicatedStorage:FindFirstChild("Modules")
	if updateService then
		local updateModule = updateService:FindFirstChild("UpdateService")
		if updateModule then
			local zenEvent = updateModule:FindFirstChild("ZenEvent")
			if zenEvent then
				zenEvent.Parent = Workspace

				-- Optional: Notify the player
				game.StarterGui:SetCore("SendNotification", {
					Title = "Zen Event";
					Text = "ZenEvent successfully triggered!";
					Duration = 3;
				})
			end
		end
	end
end)
