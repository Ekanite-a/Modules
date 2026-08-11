local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

local Text = {}

local rand = Random.new()
local randStr = function(len)
    local t = table.create(len)
    for i = 1, len do
        t[i] = string.char(rand:NextInteger(32, 126))
    end
    return table.concat(t)
end

Text.objs = {}

function Text:Create(opTextSettings)
    --[[
        TextSettings: table = {
            X: number,
            Str: string?,
            StrSize: number?
            Align: str?,
        }
    ]]--
    local TextSettings = opTextSettings or {}

    local object = {}
    local conns = {}
    local maxW = TextSettings.x or 200

    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = randStr(10)
    screenGui.DisplayOrder = 999999
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false

    local frame = Instance.new("Frame", screenGui)
    frame.Name = randStr(10)
    frame.AutomaticSize = Enum.AutomaticSize.XY
    frame.Size = UDim2.fromOffset(0, 0)
    frame.Position = UDim2.fromScale(0.7, 0.1)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Active = true

    local padding = Instance.new("UIPadding", frame)
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 5)
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 5)

    local sizeConstraint = Instance.new("UISizeConstraint", frame)
    sizeConstraint.MaxSize = Vector2.new(maxW, 9999)
    sizeConstraint.MinSize = Vector2.new(20, 20)

    local label = Instance.new("TextLabel", frame)
    label.Name = randStr(10)
    label.AutomaticSize = Enum.AutomaticSize.XY
    label.Size = UDim2.fromScale(0, 0)
    label.Position = UDim2.fromScale(0, 0)
    label.BackgroundTransparency = 1
    label.TextWrapped = true
    label.TextSize = TextSettings.strSize or 13
    label.Font = Enum.Font.Gotham
    label.TextColor3 = Color3.fromRGB(230, 230, 230)

    local align = (TextSettings.Align == "left" and Enum.TextXAlignment.Left) or (TextSettings.Align == "right" and Enum.TextXAlignment.Right) or Enum.TextXAlignment.Center
    label.TextXAlignment = align
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

    function object:UpdateText(newText)
        label.Text = tostring(newText)
    end

    function object:Switch(state)
        if state ~= nil then
            frame.Visible = state
            return
        end
        frame.Visible = not frame.Visible
    end

    function object:Destroy()
        screenGui:Destroy()
        for _, v in next, conns do
            v:Disconnect()
        end
        conns = nil
    end

    object.Instance = screenGui

    table.insert(self.objs, object)
    return object
end

function Text:Clear()
    for i, v in next, self.objs do
        v:Destroy()
    end
    table.clear(self.objs)
end

return Text