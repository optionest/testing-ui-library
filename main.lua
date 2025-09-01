
local UILibrary = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomUILib"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.Parent = MainFrame

local Tabs = {}

function UILibrary:CreateTab(tabName)
    local Tab = {}

    local TabButton = Instance.new("TextButton")
    TabButton.Text = tabName
    TabButton.Size = UDim2.new(0, 100, 0, 30)
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.TextColor3 = Color3.new(1,1,1)
    TabButton.Parent = MainFrame

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -100, 1, -30)
    ContentFrame.Position = UDim2.new(0, 100, 0, 30)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Visible = false
    ContentFrame.Parent = MainFrame

    local UIList = Instance.new("UIListLayout")
    UIList.Padding = UDim.new(0, 5)
    UIList.Parent = ContentFrame

    Tab.Sections = {}
    Tab.Frame = ContentFrame

    TabButton.MouseButton1Click:Connect(function()
        for _,t in pairs(Tabs) do
            t.Frame.Visible = false
        end
        ContentFrame.Visible = true
    end)

    function Tab:CreateSection(sectionName)
        local Section = {}

        local SectionFrame = Instance.new("Frame")
        SectionFrame.Size = UDim2.new(1, -10, 0, 50)
        SectionFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
        SectionFrame.BorderSizePixel = 0
        SectionFrame.Parent = ContentFrame

        local UIList2 = Instance.new("UIListLayout")
        UIList2.Padding = UDim.new(0, 5)
        UIList2.Parent = SectionFrame

        local Title = Instance.new("TextLabel")
        Title.Text = sectionName
        Title.Size = UDim2.new(1, 0, 0, 20)
        Title.TextColor3 = Color3.new(1,1,1)
        Title.BackgroundTransparency = 1
        Title.Parent = SectionFrame

        Section.Frame = SectionFrame

        function Section:CreateButton(btnName, callback)
            local Btn = Instance.new("TextButton")
            Btn.Text = btnName
            Btn.Size = UDim2.new(1, -10, 0, 25)
            Btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.Parent = SectionFrame

            Btn.MouseButton1Click:Connect(function()
                if callback then
                    callback()
                end
            end)
        end

        table.insert(Tab.Sections, Section)
        return Section
    end

    table.insert(Tabs, Tab)
    return Tab
end

return UILibrary
