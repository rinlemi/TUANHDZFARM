-- ⚡ TUANHDZVCL HUB ⚡

local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local StarterGui = game:GetService('StarterGui')
local TweenService = game:GetService('TweenService')
local VirtualInputManager = game:GetService('VirtualInputManager')

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild('PlayerGui')
local camera = workspace.CurrentCamera

----------------------------------------------------------------
-- 🖼️ UI chính
----------------------------------------------------------------
local gui = Instance.new('ScreenGui')
gui.Name = 'TUANHDZVCL_UI'
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

local frame = Instance.new('Frame')
frame.Size = UDim2.new(0, 320, 0, 260) -- tăng chiều cao để thêm nút
frame.Position = UDim2.new(0.5, -160, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
frame.Parent = gui
Instance.new('UICorner', frame).CornerRadius = UDim.new(0, 12)

-- Title bar
local titleBar = Instance.new('Frame')
titleBar.Size = UDim2.new(1, 0, 0, 28)
titleBar.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
titleBar.Parent = frame

local titleLabel = Instance.new('TextLabel')
titleLabel.Size = UDim2.new(1, -30, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = 'TUANHDZVCL HUB'
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(50, 50, 50)
titleLabel.Parent = titleBar

-- Nút thu nhỏ/phóng to
local closeBtn = Instance.new('TextButton')
closeBtn.Size = UDim2.new(0, 28, 1, 0)
closeBtn.Position = UDim2.new(1, -28, 0, 0)
closeBtn.Text = '–'
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Parent = titleBar

----------------------------------------------------------------
-- 📦 Nút Auto Farm
----------------------------------------------------------------
local farmBtn = Instance.new('TextButton')
farmBtn.Size = UDim2.new(0, 200, 0, 50)
farmBtn.Position = UDim2.new(0.5, -100, 0.5, -95)
farmBtn.Text = 'Auto Farm Beli'
farmBtn.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
farmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
farmBtn.Font = Enum.Font.SourceSansBold
farmBtn.TextSize = 20
farmBtn.Parent = frame
Instance.new('UICorner', farmBtn).CornerRadius = UDim.new(0, 8)

----------------------------------------------------------------
-- 🌟 Nút Auto Spawn
----------------------------------------------------------------
local spawnBtn = Instance.new('TextButton')
spawnBtn.Size = UDim2.new(0, 200, 0, 50)
spawnBtn.Position = UDim2.new(0.5, -100, 0.5, -25)
spawnBtn.Text = 'Auto Spawn'
spawnBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnBtn.Font = Enum.Font.SourceSansBold
spawnBtn.TextSize = 20
spawnBtn.Parent = frame
Instance.new('UICorner', spawnBtn).CornerRadius = UDim.new(0, 8)

----------------------------------------------------------------
-- 🛡️ Nút Chống Sit
----------------------------------------------------------------
local antiSitBtn = Instance.new('TextButton')
antiSitBtn.Size = UDim2.new(0, 200, 0, 50)
antiSitBtn.Position = UDim2.new(0.5, -100, 0.5, 45)
antiSitBtn.Text = 'Chống Sit'
antiSitBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
antiSitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
antiSitBtn.Font = Enum.Font.SourceSansBold
antiSitBtn.TextSize = 20
antiSitBtn.Parent = frame
Instance.new('UICorner', antiSitBtn).CornerRadius = UDim.new(0, 8)

----------------------------------------------------------------
-- 📌 Hàm Auto Farm 1 vòng
----------------------------------------------------------------
local function runAutoFarm()
    pcall(function()
        local args = { 'Package' }
        workspace
            :WaitForChild('Merchants')
            :WaitForChild('QuestFishMerchant')
            :WaitForChild('Clickable')
            :WaitForChild('Retum')
            :FireServer(unpack(args))
    end)

    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild('Humanoid')
    local backpack = player:WaitForChild('Backpack')

    task.wait(0.5)

    -- Bấm phím 2
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
    task.wait(0.08)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Two, false, game)

    -- Fallback equip
    task.wait(0.2)
    local equippedTool = char:FindFirstChildOfClass('Tool')
    if not equippedTool then
        local pkg = backpack:FindFirstChild('Package')
        if pkg then
            humanoid:EquipTool(pkg)
        end
    end

    -- Ấn phím E
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)

    -- Giữ chuột
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)

    -- Tween points
    local hrp = char:WaitForChild('HumanoidRootPart')
    local points = {
        Vector3.new(89.131, 263.010, -37.165),
        Vector3.new(621.862, 250.000, 1217.607),
        Vector3.new(621.862, 213.000, 1217.607),
        Vector3.new(903.428, 267.000, 1219.686),
        Vector3.new(1547.800, 260.899, 2132.253),
        Vector3.new(1520.885, 257.386, 2164.402),
        Vector3.new(1110.352, 214.000, 3366.765),
        Vector3.new(113.475, 275.000, 4951.790),
        Vector3.new(-1843.252, 219.000, 3415.287),
        Vector3.new(1490.294, 257.386, 2170.921),
        Vector3.new(-1067.976, 358.000, 1664.521),
        Vector3.new(2054.818, 300.000, -386.609),
        Vector3.new(2054.818, 213.000, -386.609),
        Vector3.new(4.568, 218.000, -415.644),
        Vector3.new(-132.246, 600.000, -669.693),
        Vector3.new(-132.246, 213.000, -669.693),
        Vector3.new(-1252.285, 300.680, -1174.963),
        Vector3.new(-1252.285, 214.680, -1174.963),
        Vector3.new(-1293.003, 400.000, -1352.464),
        Vector3.new(-1303.691, 215.000, -1352.504),
        Vector3.new(-1282.621, 236.998, -1370.323),
        Vector3.new(-1281.401, 215.200, -1370.365),
        Vector3.new(999.243, 221.000, -3338.135),
        Vector3.new(1246.043, 301.300, -3239.412),
        Vector3.new(1246.043, 221.300, -3239.412),
        Vector3.new(1982.502, 315.000, 562.961),
        Vector3.new(1982.502, 215.000, 562.961),
        Vector3.new(90.495, 263.010, -36.196),
    }
    local function moveTo(pos)
        local tw = TweenService:Create(
            hrp,
            TweenInfo.new(3, Enum.EasingStyle.Linear),
            { CFrame = CFrame.new(pos) }
        )
        tw:Play()
        tw.Completed:Wait()
    end

    local done = false
    task.delay(100, function()
        done = true
    end)

    for _, pos in ipairs(points) do
        if done then
            break
        end
        moveTo(pos)
        task.wait(0.5)
    end

    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

farmBtn.MouseButton1Click:Connect(function()
    task.spawn(function()
        while true do
            runAutoFarm()
            task.wait(5)
        end
    end)
end)

----------------------------------------------------------------
-- ⚡ Auto Spawn Script
----------------------------------------------------------------
local function resetCamera()
    task.wait(0.2)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild('Humanoid')
    camera.CameraSubject = humanoid
    camera.CameraType = Enum.CameraType.Custom
end

local function clearStarter()
    local loadGui = StarterGui:FindFirstChild('Load')
    if loadGui then
        loadGui:Destroy()
    end
end

local function clearPlayer()
    local loadGui = PlayerGui:FindFirstChild('Load')
    if loadGui then
        loadGui:Destroy()
    end
end

local function autoSpawn()
    local args = { 1 }
    pcall(function()
        ReplicatedStorage:WaitForChild('Connections')
            :WaitForChild('Spawn')
            :FireServer(unpack(args))
    end)
    task.delay(0.5, function()
        clearStarter()
        clearPlayer()
        resetCamera()
    end)
end

spawnBtn.MouseButton1Click:Connect(function()
    autoSpawn()
end)

PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == 'Load' then
        task.wait(0.1)
        child:Destroy()
        resetCamera()
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(1)
    autoSpawn()
    resetCamera()
end)

----------------------------------------------------------------
-- 🛡️ Script Chống Sit
----------------------------------------------------------------
local function antiSit(humanoid)
    if not humanoid then
        return
    end
    humanoid.Sit = false
    humanoid:GetPropertyChangedSignal('Sit'):Connect(function()
        if humanoid.Sit then
            humanoid.Sit = false
        end
    end)
end

local antiSitEnabled = false
antiSitBtn.MouseButton1Click:Connect(function()
    antiSitEnabled = not antiSitEnabled
    if antiSitEnabled then
        antiSitBtn.Text = 'Chống Sit: ON'
        if player.Character then
            local humanoid = player.Character:FindFirstChild('Humanoid')
            if humanoid then
                antiSit(humanoid)
            end
        end
        player.CharacterAdded:Connect(function(char)
            local humanoid = char:WaitForChild('Humanoid')
            antiSit(humanoid)
        end)
    else
        antiSitBtn.Text = 'Chống Sit: OFF'
    end
end)

----------------------------------------------------------------
-- 🔗 Kéo UI
----------------------------------------------------------------
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

----------------------------------------------------------------
-- ➕ Thu nhỏ / phóng to toggle
----------------------------------------------------------------
local minimized = false
closeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        for _, child in ipairs(frame:GetChildren()) do
            if child:IsA('TextButton') and child ~= closeBtn then
                child.Visible = false
            end
        end
        frame.Size = UDim2.new(0, 200, 0, 28)
        closeBtn.Text = '+'
    else
        for _, child in ipairs(frame:GetChildren()) do
            if child:IsA('TextButton') and child ~= closeBtn then
                child.Visible = true
            end
        end
        frame.Size = UDim2.new(0, 320, 0, 260)
        closeBtn.Text = '–'
    end
end)
