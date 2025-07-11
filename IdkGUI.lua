local GuiLibrary = {}
GuiLibrary.__index = GuiLibrary

function GuiLibrary.new(config)
    local self = setmetatable({}, GuiLibrary)

    self.useKeySystem = config and config.useKeySystem or false
    self.correctKey = config and config.correctKey or "MySecretKey123"
    self.titleText = (config and config.title) or "Gui Library"

    self.player = game.Players.LocalPlayer

    self.screenGui = Instance.new("ScreenGui", self.player:WaitForChild("PlayerGui"))
    self.screenGui.Name = "GuiLibraryScreenGui"
    self.screenGui.ResetOnSpawn = false

    self.keyFrame = Instance.new("Frame", self.screenGui)
    self.keyFrame.Size = UDim2.new(0, 250, 0, 150)
    self.keyFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
    self.keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", self.keyFrame).CornerRadius = UDim.new(0, 12)
    self.keyFrame.Visible = self.useKeySystem

    local keyTitle = Instance.new("TextLabel", self.keyFrame)
    keyTitle.Size = UDim2.new(1, 0, 0, 40)
    keyTitle.Position = UDim2.new(0, 0, 0, 0)
    keyTitle.BackgroundTransparency = 1
    keyTitle.Text = "Enter Key to Unlock GUI"
    keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyTitle.Font = Enum.Font.GothamBold
    keyTitle.TextSize = 18

    self.keyBox = Instance.new("TextBox", self.keyFrame)
    self.keyBox.Size = UDim2.new(1, -40, 0, 30)
    self.keyBox.Position = UDim2.new(0, 20, 0, 50)
    self.keyBox.PlaceholderText = "Enter Key..."
    self.keyBox.Text = ""
    self.keyBox.Font = Enum.Font.Gotham
    self.keyBox.TextSize = 16
    self.keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    self.keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", self.keyBox).CornerRadius = UDim.new(0, 6)

    self.submitButton = Instance.new("TextButton", self.keyFrame)
    self.submitButton.Size = UDim2.new(1, -40, 0, 30)
    self.submitButton.Position = UDim2.new(0, 20, 0, 90)
    self.submitButton.Text = "Submit"
    self.submitButton.Font = Enum.Font.GothamBold
    self.submitButton.TextSize = 16
    self.submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
    self.submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", self.submitButton).CornerRadius = UDim.new(0, 6)

    self.mainFrame = Instance.new("Frame", self.screenGui)
    self.mainFrame.Size = UDim2.new(0, 400, 0, 300)
    self.mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    self.mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    self.mainFrame.Active = true
    self.mainFrame.Draggable = true
    self.mainFrame.Visible = not self.useKeySystem
    Instance.new("UICorner", self.mainFrame).CornerRadius = UDim.new(0, 12)

    local titleLabel = Instance.new("TextLabel", self.mainFrame)
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.titleText
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 22

    self.scrollFrame = Instance.new("ScrollingFrame", self.mainFrame)
    self.scrollFrame.Size = UDim2.new(0, 140, 1, -40)
    self.scrollFrame.Position = UDim2.new(0, 0, 0, 40)
    self.scrollFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    self.scrollFrame.ScrollBarThickness = 6
    self.scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.scrollFrame.ClipsDescendants = true

    self.layout = Instance.new("UIListLayout", self.scrollFrame)
    self.layout.Padding = UDim.new(0, 6)
    self.layout.SortOrder = Enum.SortOrder.LayoutOrder

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

    return self
end

function GuiLibrary:AddButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -12, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text or "Button"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.Parent = self.scrollFrame

    if callback and typeof(callback) == "function" then
        btn.MouseButton1Click:Connect(callback)
    end
    return btn
end

return GuiLibrary





--another day anoher script im getting more headache.
