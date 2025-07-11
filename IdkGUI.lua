local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "MyGuiLibrary"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 300)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
titleBar.Text = "Gui Library"
titleBar.TextColor3 = Color3.new(1, 1, 1)
titleBar.Font = Enum.Font.SourceSansBold
titleBar.TextSize = 20
titleBar.Parent = mainFrame

local tabButtonsFrame = Instance.new("Frame")
tabButtonsFrame.Size = UDim2.new(1, 0, 0, 30)
tabButtonsFrame.Position = UDim2.new(0, 0, 0, 30)
tabButtonsFrame.BackgroundTransparency = 1
tabButtonsFrame.Parent = mainFrame

local tabPagesFrame = Instance.new("Frame")
tabPagesFrame.Size = UDim2.new(1, 0, 1, -60)
tabPagesFrame.Position = UDim2.new(0, 0, 0, 60)
tabPagesFrame.BackgroundTransparency = 1
tabPagesFrame.Parent = mainFrame

local tabs = {}

local function createTab(name)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 100, 1, 0)
	button.Position = UDim2.new(0, #tabs * 100, 0, 0)
	button.Text = name
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Font = Enum.Font.SourceSans
	button.TextSize = 16
	button.Parent = tabButtonsFrame

	local page = Instance.new("Frame")
	page.Size = UDim2.new(1, 0, 1, 0)
	page.Position = UDim2.new(0, 0, 0, 0)
	page.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	page.Visible = false
	page.Parent = tabPagesFrame

	local layout = Instance.new("UIListLayout", page)
	layout.Padding = UDim.new(0, 6)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	button.MouseButton1Click:Connect(function()
		for _, tab in pairs(tabs) do
			tab.page.Visible = false
		end
		page.Visible = true
	end)

	local tabData = {
		button = button,
		page = page,
		AddButton = function(text, callback)
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(0, 200, 0, 30)
			btn.Text = text
			btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 16
			btn.Parent = page

			btn.MouseButton1Click:Connect(function()
				if callback then callback() end
			end)
		end
	}

	table.insert(tabs, tabData)
	return tabData
end

-- 📌 USAGE
local tab1 = createTab("Main")
tab1.page.Visible = true -- Show first tab by default
tab1.AddButton("Click Me!", function()
	print("Main tab button clicked")
end)

local tab2 = createTab("Settings")
tab2.AddButton("Settings Button", function()
	print("Settings clicked")
end)
