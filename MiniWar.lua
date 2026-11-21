local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer
local isMinimized = false
local isCollecting = false
local antiAfkEnabled = false
if game:GetService("CoreGui"):FindFirstChild("XeclerMiniWarGui") then
    game:GetService("CoreGui").XeclerMiniWarGui:Destroy()
end
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XeclerMiniWarGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 154)
MainFrame.Position = UDim2.new(0.05, 0, 0.35, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 26, 44)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(175, 225, 255)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 34)
TopBar.BackgroundColor3 = Color3.fromRGB(165, 32, 42)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -38, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(255, 250, 240)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Text = "❄️ XECLER SCRIPT 🎄"
TitleLabel.Parent = TopBar
local MinButton = Instance.new("TextButton")
MinButton.Size = UDim2.new(0, 28, 0, 28)
MinButton.Position = UDim2.new(1, -32, 0, 3)
MinButton.BackgroundColor3 = Color3.fromRGB(130, 22, 32)
MinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinButton.Font = Enum.Font.GothamBold
MinButton.TextSize = 18
MinButton.Text = "-"
MinButton.Parent = TopBar
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinButton
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -34)
ContentFrame.Position = UDim2.new(0, 0, 0, 34)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame
local garlandColors = {Color3.fromRGB(255, 75, 75), Color3.fromRGB(255, 215, 65), Color3.fromRGB(75, 225, 115), Color3.fromRGB(85, 185, 255)}
local bulbs = {}
local function createBulb(xPos, yPos, idx)
    local Bulb = Instance.new("Frame")
    Bulb.Size = UDim2.new(0, 6, 0, 6)
    Bulb.Position = UDim2.new(0, xPos, 0, yPos)
    Bulb.BackgroundColor3 = garlandColors[(idx % #garlandColors) + 1]
    Bulb.BorderSizePixel = 0
    Bulb.Parent = ContentFrame
    local BulbCorner = Instance.new("UICorner")
    BulbCorner.CornerRadius = UDim.new(1, 0)
    BulbCorner.Parent = Bulb
    table.insert(bulbs, Bulb)
end
for i = 1, 9 do createBulb((i * 23) - 6, 4, i) end
for i = 1, 7 do
    createBulb(6, 10 + (i * 13), i + 1)
    createBulb(228, 10 + (i * 13), i + 3)
end
task.spawn(function()
    local step = 0
    while ScreenGui and ScreenGui.Parent do
        step = step + 1
        for i, bulb in ipairs(bulbs) do
            bulb.BackgroundColor3 = garlandColors[((i + step) % #garlandColors) + 1]
        end
        task.wait(0.6)
    end
end)
local CollectButton = Instance.new("TextButton")
CollectButton.Size = UDim2.new(1, -36, 0, 38)
CollectButton.Position = UDim2.new(0, 18, 0, 16)
CollectButton.BackgroundColor3 = Color3.fromRGB(34, 145, 72)
CollectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectButton.Font = Enum.Font.Gotham
CollectButton.TextSize = 13
CollectButton.Text = "💰 Собрать ресурсы"
CollectButton.Parent = ContentFrame
local CollectCorner = Instance.new("UICorner")
CollectCorner.CornerRadius = UDim.new(0, 8)
CollectCorner.Parent = CollectButton
local CollectStroke = Instance.new("UIStroke")
CollectStroke.Color = Color3.fromRGB(130, 240, 165)
CollectStroke.Thickness = 1
CollectStroke.Parent = CollectButton
local AntiAfkButton = Instance.new("TextButton")
AntiAfkButton.Size = UDim2.new(1, -36, 0, 38)
AntiAfkButton.Position = UDim2.new(0, 18, 0, 62)
AntiAfkButton.BackgroundColor3 = Color3.fromRGB(165, 45, 52)
AntiAfkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAfkButton.Font = Enum.Font.Gotham
AntiAfkButton.TextSize = 13
AntiAfkButton.Text = "🛡️ Anti-AFK: ВЫКЛ"
AntiAfkButton.Parent = ContentFrame
local AfkCorner = Instance.new("UICorner")
AfkCorner.CornerRadius = UDim.new(0, 8)
AfkCorner.Parent = AntiAfkButton
local AfkStroke = Instance.new("UIStroke")
AfkStroke.Color = Color3.fromRGB(240, 130, 135)
AfkStroke.Thickness = 1
AfkStroke.Parent = AntiAfkButton
local function minimizeMenu()
    if not isMinimized then
        isMinimized = true
        ContentFrame.Visible = false
        MinButton.Visible = false
        MainFrame.Size = UDim2.new(0, 175, 0, 34)
    end
end
local function expandMenu()
    if isMinimized then
        isMinimized = false
        MainFrame.Size = UDim2.new(0, 240, 0, 154)
        ContentFrame.Visible = true
        MinButton.Visible = true
    end
end
MinButton.MouseButton1Click:Connect(minimizeMenu)
local draggingMenu, dragStart, startPos, wasDragged = false, nil, nil, false
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMenu = true
        wasDragged = false
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if draggingMenu and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        if delta.Magnitude > 4 then wasDragged = true end
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and draggingMenu then
        draggingMenu = false
        if isMinimized and not wasDragged then expandMenu() end
    end
end)
AntiAfkButton.MouseButton1Click:Connect(function()
    antiAfkEnabled = not antiAfkEnabled
    if antiAfkEnabled then
        AntiAfkButton.Text = "🛡️ Anti-AFK: ВКЛ"
        AntiAfkButton.BackgroundColor3 = Color3.fromRGB(45, 135, 210)
        AfkStroke.Color = Color3.fromRGB(145, 210, 255)
    else
        AntiAfkButton.Text = "🛡️ Anti-AFK: ВЫКЛ"
        AntiAfkButton.BackgroundColor3 = Color3.fromRGB(165, 45, 52)
        AfkStroke.Color = Color3.fromRGB(240, 130, 135)
    end
end)
Player.Idled:Connect(function()
    if antiAfkEnabled then
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end)
local function getPromptPosition(prompt)
    local p = prompt.Parent
    if not p then return nil end
    if p:IsA("BasePart") then return p.Position end
    if p:IsA("Attachment") and p.Parent and p.Parent:IsA("BasePart") then return p.WorldPosition end
    if p:IsA("Model") and p.PrimaryPart then return p.PrimaryPart.Position end
    return nil
end
local function setCharacterTouch(char, state)
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then part.CanTouch = state end
    end
end
local blockedWords = {"shop", "store", "crate", "general", "craft", "npc", "merchant", "sell", "market", "land", "tile", "territory", "expand", "unlock", "buy", "магазин", "купить", "открыть", "продать", "ящик", "%$"}
local allowWords = {
    "wheat", "пшениц", "corn", "кукуруз", "coal", "угол", "tree", "wood", "дерев", "древес",
    "windmill", "flour", "мук", "carrot", "морков", "library", "book", "книг", "библиотек",
    "oil", "нефт", "iron", "желез", "cement", "цемент", "gold", "золот", "bank", "банк", "cash", "money", "деньг",
    "research", "science", "наук", "исслед", "diamond", "алмаз", "uran", "уран", "nuclear", "ядер",
    "data", "данн", "blackhole", "черн", "дыр", "area", "51", "alien", "пришел",
    "antimatter", "антиматер", "quantum", "квант", "supernova", "сверхнов", "gamma", "гамма",
    "anomaly", "аномал", "fusion", "синтез", "термояд", "energy", "энерг", "power", "planks", "доск", "stone", "камен"
}
local function hasAnyWord(text, list)
    for _, word in ipairs(list) do
        if string.find(text, word) then return true end
    end
    return false
end
local function collectAllResources()
    if isCollecting then return end
    isCollecting = true
    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then isCollecting = false return end
    local savedCFrame = root.CFrame
    local targets = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and obj.Enabled then
            local pos = getPromptPosition(obj)
            if pos and (pos - savedCFrame.Position).Magnitude <= 220 then
                local combined = string.lower(obj.ActionText .. " " .. obj.ObjectText)
                local fullPath = string.lower(obj:GetFullName())
                local hasCollect = string.find(combined, "собрать") or string.find(combined, "collect")
                if (hasCollect or hasAnyWord(combined, allowWords) or hasAnyWord(fullPath, allowWords)) and not hasAnyWord(fullPath, blockedWords) and not hasAnyWord(combined, blockedWords) then
                    table.insert(targets, {prompt = obj, pos = pos})
                end
            end
        end
    end

    CollectButton.Text = "🎄 Сбор (" .. #targets .. ")..."
    CollectButton.BackgroundColor3 = Color3.fromRGB(215, 145, 35)
    setCharacterTouch(char, false)
    local collectedCount = 0
    for _, item in ipairs(targets) do
        local prompt = item.prompt
        if prompt and prompt.Parent and prompt.Enabled then
            root.CFrame = CFrame.new(item.pos + Vector3.new(0, 2.5, 0))
            task.wait(0.07)
            pcall(function()
                local oldHold = prompt.HoldDuration
                prompt.HoldDuration = 0
                fireproximityprompt(prompt)
                prompt.HoldDuration = oldHold
                collectedCount = collectedCount + 1
            end)
            task.wait(0.05)
        end
    end
    root.CFrame = savedCFrame
    task.wait(0.05)
    setCharacterTouch(char, true)
    CollectButton.Text = "✅ Собрано: " .. collectedCount
    CollectButton.BackgroundColor3 = Color3.fromRGB(45, 175, 95)
    task.wait(1.3)
    CollectButton.Text = "💰 Собрать ресурсы"
    CollectButton.BackgroundColor3 = Color3.fromRGB(34, 145, 72)
    isCollecting = false
end
CollectButton.MouseButton1Click:Connect(collectAllResources)
