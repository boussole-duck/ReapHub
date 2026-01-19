-- ReapHub Loader (fail-safe)

if _G.ReapHubLoaded then return end
_G.ReapHubLoaded = true

local BASE =
"https://raw.githubusercontent.com/boussole-duck/ReapHub/main/ReapHub/"

local RunService = game:GetService("RunService")

local function safeHttp(url)
    local ok, res = pcall(function()
        return game:HttpGet(url, true)
    end)
    return ok and res or nil
end

local function loadModule(name)
    local src = safeHttp(BASE .. name .. ".lua")
    if not src then
        warn("[ReapHub] Failed to load:", name)
        return nil
    end

    local fn = loadstring(src)
    local ok, mod = pcall(fn, _G.ReapHubModules)
    if not ok then
        warn("[ReapHub] Error in module:", name, mod)
        return nil
    end
    return mod
end

_G.ReapHubModules = {}
local M = _G.ReapHubModules

M.State        = loadModule("State")
M.Keybinds     = loadModule("Keybinds")
M.KeybindMenu  = loadModule("KeybindMenu")
M.UI           = loadModule("UI")
M.LockOn       = loadModule("LockOn")
M.ESP          = loadModule("ESP")

if not M.UI then
    warn("[ReapHub] UI failed to load")
    return
end

pcall(function()
    M.UI:Init()
end)

RunService.RenderStepped:Connect(function()
    if M.LockOn then pcall(function() M.LockOn:Update() end) end
    if M.ESP then pcall(function() M.ESP:Update() end) end
end)

_G.ReapHubUnload = function()
    _G.ReapHubLoaded = false
    local g = game:GetService("CoreGui"):FindFirstChild("ReapHub")
    if g then g:Destroy() end
end
