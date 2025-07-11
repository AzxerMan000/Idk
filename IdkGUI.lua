local GuiLibrary = {}

function GuiLibrary:CreateWindow(windowTitle)
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    screenGui.Name = "IDK GUI Libary"

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.Active = true
    mainFrame.Draggable = true

    local titleLabel = Instance.new("TextLabel", mainFrame)
    titleLabel.Text = windowTitle or "Window"
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20

    local tabFolder = Instance.new("Folder", mainFrame)
    tabFolder.Name = "Tabs"

    local tabButtons = {}

    function GuiLibrary:CreateTab(tabName)
        local tab = Instance.new("Frame", tabFolder)
        tab.Name = tabName
        tab.Size = UDim2.new(1, 0, 1, -30)
        tab.Position = UDim2.new(0, 0, 0, 30)
        tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tab.Visible = false

        local button = Instance.new("TextButton", mainFrame)
        button.Text = tabName
        button.Size = UDim2.new(0, 100, 0, 25)
        button.Position = UDim2.new(0, #tabButtons * 100, 0, 0)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 18

        table.insert(tabButtons, button)

        button.MouseButton1Click:Connect(function()
            for _, t in ipairs(tabFolder:GetChildren()) do
                t.Visible = false
            end
            tab.Visible = true
        end)

        local yOffset = 10

        function tab:AddButton(text, callback)
            local btn = Instance.new("TextButton", tab)
            btn.Text = text
            btn.Size = UDim2.new(0, 200, 0, 30)
            btn.Position = UDim2.new(0, 10, 0, yOffset)
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 16

            btn.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)

            yOffset = yOffset + 35
        end

        return tab
    end

    return self
end

return GuiLibrary
