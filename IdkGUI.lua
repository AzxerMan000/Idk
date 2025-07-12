-- GuiLibrary.lua
local GuiLibrary = {}
GuiLibrary.__index = GuiLibrary

function GuiLibrary.new(config)
    local self = setmetatable({}, GuiLibrary)
    self.useKeySystem  = config and config.useKeySystem  or false
    self.correctKey    = config and config.correctKey    or "MySecretKey123"
    self.titleText     = config and config.title         or "GUI Library"
    self.font          = config and config.font          or Enum.Font.Arial
    self.tabs          = {}
    self.currentTab    = nil
    self.player        = game.Players.LocalPlayer
    

    -- Main screen
    self.screenGui = Instance.new("ScreenGui", self.player:WaitForChild("PlayerGui"))
    self.screenGui.Name = "GuiLibraryScreenGui"
    self.screenGui.ResetOnSpawn = false

    -- Key Input Frame
    self.keyFrame = Instance.new("Frame", self.screenGui)
    self.keyFrame.Size = UDim2.new(0, 250, 0, 150)
    self.keyFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
    self.keyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Instance.new("UICorner", self.keyFrame).CornerRadius = UDim.new(0, 12)
    self.keyFrame.Visible = self.useKeySystem

    local keyTitle = Instance.new("TextLabel", self.keyFrame)
    keyTitle.Size = UDim2.new(1,0,0,40); keyTitle.Position = UDim2.new(0,0,0,0)
    keyTitle.BackgroundTransparency = 1; keyTitle.Text = "Enter Key to Unlock GUI"
    keyTitle.TextColor3 = Color3.fromRGB(255,255,255); keyTitle.Font = self.font; keyTitle.TextSize = 18

    self.keyBox = Instance.new("TextBox", self.keyFrame)
    self.keyBox.Size = UDim2.new(1,-40,0,30); self.keyBox.Position = UDim2.new(0,20,0,50)
    self.keyBox.PlaceholderText = "Enter Key..."; self.keyBox.Text = ""
    self.keyBox.Font = self.font; self.keyBox.TextSize = 16
    self.keyBox.BackgroundColor3 = Color3.fromRGB(40,40,40); self.keyBox.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", self.keyBox).CornerRadius = UDim.new(0,6)

    self.submitButton = Instance.new("TextButton", self.keyFrame)
    self.submitButton.Size = UDim2.new(1,-40,0,30); self.submitButton.Position = UDim2.new(0,20,0,90)
    self.submitButton.Text = "Submit"; self.submitButton.Font = self.font; self.submitButton.TextSize = 16
    self.submitButton.BackgroundColor3 = Color3.fromRGB(0,170,127); self.submitButton.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", self.submitButton).CornerRadius = UDim.new(0,6)

    -- Main GUI window
    self.mainFrame = Instance.new("Frame", self.screenGui)
    self.mainFrame.Size = UDim2.new(0, 500, 0, 350)
    self.mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    self.mainFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    self.mainFrame.Active = true; self.mainFrame.Draggable = true
    self.mainFrame.Visible = not self.useKeySystem
    Instance.new("UICorner", self.mainFrame).CornerRadius = UDim.new(0,12)

    local titleLabel = Instance.new("TextLabel", self.mainFrame)
    titleLabel.Size = UDim2.new(1,0,0,40); titleLabel.Position = UDim2.new(0,0,0,0)
    titleLabel.BackgroundTransparency = 1; titleLabel.Text = self.titleText
    titleLabel.TextColor3 = Color3.fromRGB(255,255,255); titleLabel.Font = self.font; titleLabel.TextSize = 22

    -- Left-side vertical tab bar
    self.tabBar = Instance.new("Frame", self.mainFrame)
    self.tabBar.Size = UDim2.new(0, 130, 1, -40)
    self.tabBar.Position = UDim2.new(0, 0, 0, 40)
    self.tabBar.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", self.tabBar).CornerRadius = UDim.new(0,8)

    self.tabLayout = Instance.new("UIListLayout", self.tabBar)
    self.tabLayout.Padding = UDim.new(0,6)
    self.tabLayout.FillDirection = Enum.FillDirection.Vertical
    self.tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Area where tab scroll frames live
    self.tabContainer = Instance.new("Frame", self.mainFrame)
    self.tabContainer.Size = UDim2.new(1, -140, 1, -40)
    self.tabContainer.Position = UDim2.new(0, 140, 0, 40)
    self.tabContainer.BackgroundTransparency = 1

    if self.useKeySystem then
        self.submitButton.MouseButton1Click:Connect(function()
            if self.keyBox.Text == self.correctKey then
                self.keyFrame.Visible = false
                self.mainFrame.Visible = true
            else
                self.keyBox.Text = ""
                self.keyBox.PlaceholderText = "Wrong Key!"
            end
        end)

    end 
-- ❌ X Button (Destroy GUI)
self.xButton = Instance.new("TextButton", self.mainFrame)
self.xButton.Size = UDim2.new(0, 30, 0, 30)
self.xButton.Position = UDim2.new(1, -35, 0, 5)
self.xButton.Text = "X"
self.xButton.TextSize = 18
self.xButton.Font = self.font
self.xButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
self.xButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", self.xButton).CornerRadius = UDim.new(1, 0)

self.xButton.MouseButton1Click:Connect(function()
    self.screenGui:Destroy()
end)

-- 🔁 Toggle Button (Show/Hide GUI)
self.toggleButton = Instance.new("TextButton", self.screenGui)
self.toggleButton.Size = UDim2.new(0, 50, 0, 50)
self.toggleButton.Position = UDim2.new(0, 10, 0.5, -25)
self.toggleButton.Text = "+"
self.toggleButton.TextSize = 24
self.toggleButton.Font = self.font
self.toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
self.toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
self.toggleButton.Active = true
self.toggleButton.Draggable = true
Instance.new("UICorner", self.toggleButton).CornerRadius = UDim.new(1, 0)
        

self.toggleButton.MouseButton1Click:Connect(function()
    self.mainFrame.Visible = not self.mainFrame.Visible
end)

        return self

        
function GuiLibrary:AddTab(name)
    -- reuse if exists
    if self.tabs[name] then
        for _, tab in pairs(self.tabs) do tab.Frame.Visible = false end
        self.tabs[name].Frame.Visible = true
        self.currentTab = name
        return
    end

    -- create new tab button
    local tabButton = Instance.new("TextButton", self.tabBar)
    tabButton.Size = UDim2.new(1, -10, 0, 30)
    tabButton.Text = name
    tabButton.Font = self.font
    tabButton.TextSize = 14
    tabButton.TextColor3 = Color3.fromRGB(255,255,255)
    tabButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
    Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0,6)

    -- create scrollFrame for this tab
    local scrollFrame = Instance.new("ScrollingFrame", self.tabContainer)
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.CanvasSize = UDim2.new(0,0,0,0)
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.ClipsDescendants = true
    scrollFrame.Visible = false
    Instance.new("UICorner", scrollFrame).CornerRadius = UDim.new(0,8)

    local layout = Instance.new("UIListLayout", scrollFrame)
    layout.Padding = UDim.new(0,6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    self.tabs[name] = {Button = tabButton, Frame = scrollFrame, Layout = layout}
    self.currentTab = name

    -- connect switching behavior
    tabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(self.tabs) do tab.Frame.Visible = false end
        scrollFrame.Visible = true
        self.currentTab = name
    end)

    -- automatically switch to new tab
    for _, tab in pairs(self.tabs) do tab.Frame.Visible = false end
    scrollFrame.Visible = true
end

function GuiLibrary:AddButton(text, callback)
    if not self.currentTab then self:AddTab("Default") end
    local tabData = self.tabs[self.currentTab]

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -12, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(70,130,180)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = text or "Button"
    btn.Font = self.font
    btn.TextSize = 16
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    btn.Parent = tabData.Frame

    if callback and typeof(callback) == "function" then
        btn.MouseButton1Click:Connect(callback)
    end

    return btn
end

return GuiLibrary
