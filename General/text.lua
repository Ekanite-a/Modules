local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

local Text = {}

rand = Random.new()
local randStr = function(len)
    local t = table.create(len)

    for i = 1, len do
        t[i] = string.char(rand:NextInteger(32, 126))
    end
    return table.concat(t)
end

Text.create = function(TextSettings)
    --[[
        TextSettings: table = {
            x: number,
            y: number,
            str: string?,
            strSize: number?
        }
    ]]--


    local self = {}
    local conns = {}
    local pos = {TextSettings.x or error(), TextSettings.y or error()}
    
    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = randStr(10)
    screenGui.DisplayOrder = 999999
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false

    local frame = Instance.new("Frame", screenGui)
    frame.Name = randStr(10)
    frame.Size = UDim2.fromOffset(unpack(pos))
    frame.Position = UDim2.fromScale(0.7, 0.1)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Active = true

    local label = Instance.new("TextLabel", frame)
    label.Name = randStr(10)
    label.Size = UDim2.fromScale(1, 1)
    label.Position = UDim2.fromScale(0, 0)
    label.BackgroundTransparency = 1
    label.TextWrapped = true
    label.TextSize = TextSettings.strSize or 13
    label.Font = Enum.Font.Gotham
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.Text = TextSettings.str or ""

    local dragStart, startPos, dragging

    conns[1] = frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    conns[2] = UIS.InputEnded:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false
        end
    end)

    conns[3] = UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    self.updText = function(newText)
        label.Text = tostring(newText)
    end
    self.destroy = function()
        screenGui:Destroy()
        for _, v in next, conns do
            v:Disconnect()
        end
        conns = nil
    end

    self.Instance = screenGui

    return self
end

return Text
