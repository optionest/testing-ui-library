-- Simple Vape-like UI Library
local UILib = {}

--// Setup ScreenGui
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Name = "CustomUILib"

--// Main Window
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
mainFrame.Size = UDim2.new(0, 500, 0, 350)

-- Tab bar on the left
local tabBar = Instance.new("Frame", mainFrame)
tabBar.Size = UDim2.new(0, 120, 1, 0)
tabBar.BackgroundColor3 = Color3.fromRGB(35,35,35)

local tabList = Instance.new("UIListLayout", tabBar)
tabList.SortOrder = Enum.SortOrder.LayoutOrder
tabList.Padding = UDim.new(0,5)

-- Where tab contents go
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Position = UDim2.new(0,120,0,0)
contentFrame.Size = UDim2.new(1,-120,1,0)
contentFrame.BackgroundColor3 = Color3.fromRGB(45,45,45)

--// Keep track of tabs
local tabs = {}

-- Create Tab
function UILib:CreateTab(name)
    local tabButton = Instance.new("TextButton", tabBar)
    tabButton.Size = UDim2.new(1, -10, 0, 30)
    tabButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
    tabButton.TextColor3 = Color3.new(1,1,1)
    tabButton.Text = name

    -- content frame for this tab
    local tabContent = Instance.new("Frame", contentFrame)
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.Visible = false
    tabContent.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", tabContent)
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local tab = {}
    tab.Frame = tabContent

    -- Switching logic
    tabButton.MouseButton1Click:Connect(function()
        for _,t in pairs(tabs) do
            t.Frame.Visible = false
        end
        tabContent.Visible = true
    end)

    -- Add Button function
    function tab:CreateButton(text, callback)
        local btn = Instance.new("TextButton", tabContent)
        btn.Size = UDim2.new(0, 200, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Text = text
        btn.Font = Enum.Font.SciFi
        btn.TextSize = 18

        btn.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)
    end

    table.insert(tabs, tab)
    return tab
end

return UILib
