local Modules = _G.ReapHubModules
local State = Modules.State
local Keybinds = Modules.Keybinds
local KeyMenu = Modules.KeybindMenu

local UI = {}
UI.Objects = {}

function UI:Init()
    local gui = Instance.new("ScreenGui")
    gui.Name = "ReapHub"
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")

    local f = Instance.new("Frame", gui)
    f.Size = UDim2.fromOffset(320,240)
    f.Position = UDim2.fromScale(0.5,0.5)
    f.AnchorPoint = Vector2.new(0.5,0.5)
    f.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
    f.BorderSizePixel = 0

    local stroke = Instance.new("UIStroke", f)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0,255,255)

    local function button(text, y)
        local b = Instance.new("TextButton", f)
        b.Size = UDim2.new(1,-20,0,40)
        b.Position = UDim2.fromOffset(10,y)
        b.Text = text
        b.Font = Enum.Font.GothamBold
        b.TextSize = 18
        b.TextColor3 = Color3.fromRGB(0,255,255)
        b.BackgroundColor3 = Color3.fromRGB(15,15,35)
        b.BorderSizePixel = 0

        local c = Instance.new("UICorner", b)
        c.CornerRadius = UDim.new(0,10)

        return b
    end

    UI.Objects.Lock = button("LOCK : OFF", 20)
    UI.Objects.ESP  = button("ESP : OFF", 70)
    UI.Objects.Key  = button("RE-BIND LOCK (Q)", 130)

    Keybinds:Bind("Lock", Enum.KeyCode.Q, "Toggle", function(v)
        State.data.lockOn = v
        UI.Objects.Lock.Text = v and "LOCK : ON" or "LOCK : OFF"
    end)

    Keybinds:Bind("ESP", Enum.KeyCode.E, "Toggle", function(v)
        State.data.esp = v
        UI.Objects.ESP.Text = v and "ESP : ON" or "ESP : OFF"
    end)

    KeyMenu:Listen(UI.Objects.Key, Keybinds.Binds.Lock)
end

return UI
