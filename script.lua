-- ⚡ Auto Farm Beli với UI (Loop 65s) ⚡

local Players = game:GetService('Players')
local VirtualInputManager = game:GetService('VirtualInputManager')
local TweenService = game:GetService('TweenService')
local UIS = game:GetService('UserInputService')

local player = Players.LocalPlayer

-- 🖼️ Tạo UI
local gui = Instance.new('ScreenGui')
gui.Name = 'TUANHDZVCL_UI'
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild('PlayerGui')

local frame = Instance.new('Frame')
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
frame.Parent = gui
Instance.new('UICorner', frame).CornerRadius = UDim.new(0, 12)

local titleBar = Instance.new('Frame')
titleBar.Size = UDim2.new(1, 0, 0, 28)
titleBar.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
titleBar.Parent = frame

local titleLabel = Instance.new('TextLabel')
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = 'TUANH DZ VCL'
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(50, 50, 50)
titleLabel.Parent = titleBar

-- 📦 Nút Auto Farm
local button = Instance.new('TextButton')
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.Text = 'Auto Farm Beli'
button.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.Parent = frame
Instance.new('UICorner', button).CornerRadius = UDim.new(0, 8)

-- 📌 Hàm farm 1 vòng
local function runAutoFarm()
    -- lấy box
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

    -- bấm phím 2
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
    task.wait(0.08)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Two, false, game)

    -- fallback equip
    task.wait(0.2)
    local equippedTool = char:FindFirstChildOfClass('Tool')
    if not equippedTool then
        local pkg = backpack:FindFirstChild('Package')
        if pkg then
            humanoid:EquipTool(pkg)
        end
    end

    -- ấn phím E
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)

    -- 🖱️ Giữ chuột
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)

    -- tween points (1 vòng duy nhất)
    local hrp = char:WaitForChild('HumanoidRootPart')
    local points = {
        Vector3.new(89.131, 263.010, -37.165),
        Vector3.new(621.862, 300.000, 1217.607),
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

    -- bắt đầu đếm 70s song song với việc di chuyển
    local done = false
    task.delay(90, function()
        done = true
    end)

    for _, pos in ipairs(points) do
        if done then
            break
        end
        moveTo(pos)
        task.wait(0.5)
    end

    -- 🖱️ Thả chuột sau khi đủ 70s hoặc đi hết points
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

-- ⏯️ Khi ấn nút → bắt đầu loop vô hạn
button.MouseButton1Click:Connect(function()
    task.spawn(function()
        while true do
            runAutoFarm()
            task.wait(5) -- lặp lại sau 10s
        end
    end)
end)

-- 🔗 Cho phép kéo UI
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
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end
end)
