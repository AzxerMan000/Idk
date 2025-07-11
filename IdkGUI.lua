-- GuiLibrary.lua

local GuiLibrary = {}
GuiLibrary.__index = GuiLibrary

function GuiLibrary.new(config)
    local self = setmetatable({}, GuiLibrary)

    self.config = config or {}
    self.useKeySystem = self.config.useKeySystem or false
    self.correctKey = self.config.correctKey or "DefaultKey123"
    self.keyLink = self.config.keyLink or "https://example.com"

    self:setupGui()
    return self
end

function GuiLibrary:setupGui()
    local player = game:GetService("Players").LocalPlayer
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "GuiLibrary"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.gui = gui

    if self.useKeySystem then
        self:createKeyUI()
    else
        self.guiEnabled = true
    end
end

function GuiLibrary:createKeyUI()
    local keyFrame = Instance.new("Frame", self.gui)
    keyFrame.Size = UDim2.new(0, 300, 0, 180)
    keyFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
    keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    keyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    keyFrame.Name = "KeyFrame"
    keyFrame.Visible = true
    keyFrame.Active = true
keyFrame.Draggable = true

    Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 10)

    local title = Instance.new("TextLabel", keyFrame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "🔑 Key System"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 24

    local input = Instance.new("TextBox", keyFrame)
    input.PlaceholderText = "Enter Key Here"
    input.Size = UDim2.new(0.9, 0, 0, 40)
    input.Position = UDim2.new(0.05, 0, 0, 50)
    input.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    input.TextColor3 = Color3.new(1, 1, 1)
    input.TextSize = 18
    input.Font = Enum.Font.SourceSans
    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)

    local verify = Instance.new("TextButton", keyFrame)
    verify.Text = "✅ Verify"
    verify.Size = UDim2.new(0.4, 0, 0, 35)
    verify.Position = UDim2.new(0.05, 0, 0, 100)
    verify.BackgroundColor3 = Color3.fromRGB(35, 80, 35)
    verify.TextColor3 = Color3.new(1, 1, 1)
    verify.Font = Enum.Font.SourceSansBold
    verify.TextSize = 18
    Instance.new("UICorner", verify).CornerRadius = UDim.new(0, 6)

    local getKey = Instance.new("TextButton", keyFrame)
    getKey.Text = "🔗 Get Key"
    getKey.Size = UDim2.new(0.5, 0, 0, 35)
    getKey.Position = UDim2.new(0.5, -10, 0, 100)
    getKey.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    getKey.TextColor3 = Color3.new(1, 1, 1)
    getKey.Font = Enum.Font.SourceSansBold
    getKey.TextSize = 18
    Instance.new("UICorner", getKey).CornerRadius = UDim.new(0, 6)

    -- Event connections
    verify.MouseButton1Click:Connect(function()
        if input.Text == self.correctKey then
            keyFrame:Destroy()
            self.guiEnabled = true
        else
            input.Text = ""
            input.PlaceholderText = "❌ Incorrect Key!"
        end
    end)

    getKey.MouseButton1Click:Connect(function()
        setclipboard(self.keyLink)
        input.PlaceholderText = "🔗 Link copied!"
    end)
end

    

function GuiLibrary:createWindow(title, iconId)
    if self.useKeySystem and not self.guiEnabled then return end

    local screenGui = self.gui

    local iconButton = Instance.new("ImageButton", screenGui)
    iconButton.Name = "OpenIcon"
    iconButton.Size = UDim2.new(0, 40, 0, 40)
    iconButton.Position = UDim2.new(0, 10, 1, -50)
    iconButton.BackgroundTransparency = 1
    iconButton.Image = iconId or "rbxassetid://6031091002"
    iconButton.Visible = false
    Instance.new("UICorner", iconButton).CornerRadius = UDim.new(0, 10)

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.Draggable = true
    mainFrame.Active = true
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

    local topBar = Instance.new("Frame", mainFrame)
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)

    local titleLabel = Instance.new("TextLabel", topBar)
    titleLabel.Size = UDim2.new(1, -60, 1, 0)
    titleLabel.Position = UDim2.new(0, 5, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "Window"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Minimize
    local minimizeButton = Instance.new("TextButton", topBar)
    minimizeButton.Size = UDim2.new(0, 25, 1, 0)
    minimizeButton.Position = UDim2.new(1, -55, 0, 0)
    minimizeButton.Text = "_"
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.TextSize = 20
    minimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    minimizeButton.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 6)

    -- Close
    local closeButton = Instance.new("TextButton", topBar)
    closeButton.Size = UDim2.new(0, 25, 1, 0)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.Text = "X"
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 20
    closeButton.BackgroundColor3 = Color3.fromRGB(45, 0, 0)
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

    local contentFrame = Instance.new("Frame", mainFrame)
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 10)

    closeButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        iconButton.Visible = true
    end)

    minimizeButton.MouseButton1Click:Connect(function()
        contentFrame.Visible = not contentFrame.Visible
    end)

    iconButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = true
        iconButton.Visible = false
    end)

    local Window = {}
    Window.Tabs = {}
    Window.Frame = contentFrame

    function Window:createTab(tabName)
        local tabButton = Instance.new("TextButton", contentFrame)
        tabButton.Size = UDim2.new(0, 100, 0, 25)
        tabButton.Position = UDim2.new(0, #Window.Tabs * 105, 0, 0)
        tabButton.Text = tabName
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 6)

        local tabFrame = Instance.new("Frame", contentFrame)
        tabFrame.Size = UDim2.new(1, 0, 1, -30)
        tabFrame.Position = UDim2.new(0, 0, 0, 30)
        tabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        tabFrame.Visible = false
        Instance.new("UICorner", tabFrame).CornerRadius = UDim.new(0, 10)

        tabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(Window.Tabs) do
                t.Frame.Visible = false
            end
            tabFrame.Visible = true
        end)

        local Tab = {}
        Tab.Frame = tabFrame

        function Tab:createButton(text, callback)
            local button = Instance.new("TextButton", tabFrame)
            button.Size = UDim2.new(0, 200, 0, 40)
            button.Position = UDim2.new(0, 10, 0, #tabFrame:GetChildren() * 45)
            button.Text = text
            button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            button.TextColor3 = Color3.new(1, 1, 1)
            button.Font = Enum.Font.SourceSans
            button.TextSize = 18
            Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

            button.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
        end

        table.insert(Window.Tabs, { Button = tabButton, Frame = tabFrame })
        return Tab
    end

    return Window
end

return GuiLibrary
