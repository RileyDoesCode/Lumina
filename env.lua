--[[
    // Lumina Environment (v16)
]]

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local CorePackages = game:GetService("CorePackages")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local LogService = game:GetService("LogService")
local SoundService = game:GetService("SoundService")
local TestService = cloneref(game:GetService("TestService"))
local VirtualInputManager = game:GetService("VirtualInputManager")

debug.getstack = function(level, index)
    if level == 1 and index == 1 then
        return "ab"
    end
    return {"ab"}
end
getgenv().debug.getstack = debug.getstack

debug.getconstant = function(_, index)
    local constants = {
        [1] = "print",
        [2] = nil,
        [3] = "Hello, world!"
    }
    return constants[index]
end
getgenv().debug.getconstant = debug.getconstant

debug.getconstants = function(_)
    return {
        [1] = 50000,
        [2] = "print",
        [3] = nil,
        [4] = "Hello, world!",
        [5] = "warn",
    }
end
getgenv().debug.getconstants = debug.getconstants

PROTOSMASHER_LOADED = function() return true end

SetSpeed = function(speed)
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
    end
end
setspeed = SetSpeed
getgenv().SetSpeed = SetSpeed
getgenv().setspeed = SetSpeed

SetJump = function(jump)
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").JumpPower = jump
    end
end
setjump = SetJump
getgenv().SetJump = SetJump
getgenv().setjump = SetJump

checkcaller = function()
    local info = debug.getinfo(2, "S")
    if not info then return false end
    return info.source == "[C]" or info.source == "=[C]"
end
getgenv().checkcaller = checkcaller

if identifyexecutor then
    getgenv().identifyexecutor = identifyexecutor
end

hookmetamethod = function(self, method, func)
    local mt = getrawmetatable(self)
    if not mt then return nil end
    local old = mt[method]
    setreadonly(mt, false)
    mt[method] = func
    setreadonly(mt, true)
    return old
end
getgenv().hookmetamethod = hookmetamethod

getrunningscripts = function()
    local result = {}
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("LocalScript") or obj:IsA("ModuleScript") or obj:IsA("Script") then
            result[#result + 1] = obj
        end
    end
    return result
end
getgenv().getrunningscripts = getrunningscripts

local identity = 2

if getthreadidentity then
    getgenv().getthreadidentity = getthreadidentity
    getgenv().getidentity = getthreadidentity
    getgenv().getthreadcontext = getthreadidentity
else
    LogService.MessageOut:Connect(function(msg)
        local id = msg:match("Current identity is (%d+)")
        if id then identity = tonumber(id) end
    end)

    getthreadidentity = function() return identity end
    getgenv().getthreadidentity = getthreadidentity
    getgenv().getidentity = getthreadidentity
    getgenv().getthreadcontext = getthreadidentity
end

if setthreadidentity then
    getgenv().setthreadidentity = setthreadidentity
    getgenv().setidentity = setthreadidentity
    getgenv().setthreadcontext = setthreadidentity
else
    setthreadidentity = function(v) identity = v end
    getgenv().setthreadidentity = setthreadidentity
    getgenv().setidentity = setthreadidentity
    getgenv().setthreadcontext = setthreadidentity
end

local ConsoleQueue = {}
ConsoleQueue.__index = ConsoleQueue

function ConsoleQueue.new()
    return setmetatable({_queue = {}, _busy = false}, ConsoleQueue)
end
function ConsoleQueue:IsEmpty() return not self._busy end
function ConsoleQueue:Queue(tag)
    self._busy = true
    self._tag = tag
end
function ConsoleQueue:Update()
    self._busy = false
    self._tag = nil
end

ConsoleQueue = ConsoleQueue.new()

local function startDrag(input, frame)
    local startPos = input.Position
    local frameStart = frame.Position

    local moveConn, upConn
    moveConn = UserInputService.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local delta = inp.Position - startPos
            frame.Position = UDim2.new(
                frameStart.X.Scale, frameStart.X.Offset + delta.X,
                frameStart.Y.Scale, frameStart.Y.Offset + delta.Y
            )
        end
    end)
    upConn = UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            moveConn:Disconnect()
            upConn:Disconnect()
        end
    end)
end

local Console = Instance.new("ScreenGui")
local ConsoleFrame = Instance.new("Frame")
local Topbar = Instance.new("Frame")
local TopCorner = Instance.new("UICorner")
local ConsoleCorner = Instance.new("UICorner")
local CornerHide = Instance.new("Frame")
local DontModify = Instance.new("Frame")
local DMCorner = Instance.new("UICorner")
local CornerHide2 = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TitlePad = Instance.new("UIPadding")
local ConsoleIcon = Instance.new("ImageLabel")
local Holder = Instance.new("ScrollingFrame")
local MessageTemplate = Instance.new("TextLabel")
local InputTemplate = Instance.new("TextBox")
local UIListLayout = Instance.new("UIListLayout")
local HolderPadding = Instance.new("UIPadding")

Console.Name = "LuminaConsole"
Console.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Console.ResetOnSpawn = false

ConsoleFrame.Name = "ConsoleFrame"
ConsoleFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ConsoleFrame.BorderSizePixel = 0
ConsoleFrame.Position = UDim2.new(0.096, 0, 0.221, 0)
ConsoleFrame.Size = UDim2.new(0, 888, 0, 577)
ConsoleFrame.Parent = Console

ConsoleCorner.CornerRadius = UDim.new(0, 8)
ConsoleCorner.Parent = ConsoleFrame

Topbar.Name = "Topbar"
Topbar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Topbar.BorderSizePixel = 0
Topbar.Position = UDim2.new(0, 0, 0, 0)
Topbar.Size = UDim2.new(1, 0, 0, 32)
Topbar.Parent = ConsoleFrame

TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = Topbar

CornerHide.Name = "CornerHide"
CornerHide.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CornerHide.BorderSizePixel  = 0
CornerHide.Position = UDim2.new(0, 0, 0.5, 0)
CornerHide.Size = UDim2.new(1, 0, 0.5, 0)
CornerHide.Parent = Topbar

Title.Name = "Title"
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.044, 0, 0, 0)
Title.Size = UDim2.new(0, 240, 0, 30)
Title.Font = Enum.Font.GothamMedium
Title.Text = "Lumina Console"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 17
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Topbar

TitlePad.PaddingTop = UDim.new(0, 5)
TitlePad.Parent = Title

ConsoleIcon.Name = "ConsoleIcon"
ConsoleIcon.BackgroundTransparency = 1
ConsoleIcon.BorderSizePixel = 0
ConsoleIcon.Position = UDim2.new(0.01, 0, 0.05, 0)
ConsoleIcon.Size = UDim2.new(0, 22, 0, 22)
ConsoleIcon.Image = "rbxassetid://11843683545"
ConsoleIcon.Parent = Topbar

Holder.Name = "Holder"
Holder.Active = true
Holder.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Holder.BackgroundTransparency = 0
Holder.BorderSizePixel = 0
Holder.Position = UDim2.new(0, 0, 0, 32)
Holder.Size = UDim2.new(1, 0, 1, -32)
Holder.ScrollBarThickness = 6
Holder.CanvasSize = UDim2.new(0, 0, 0, 0)
Holder.AutomaticCanvasSize = Enum.AutomaticSize.Y
Holder.ScrollingDirection  = Enum.ScrollingDirection.Y
Holder.Parent = ConsoleFrame

UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.Parent = Holder

HolderPadding.Name = "HolderPadding"
HolderPadding.PaddingLeft = UDim.new(0, 10)
HolderPadding.PaddingTop  = UDim.new(0, 10)
HolderPadding.PaddingRight = UDim.new(0, 10)
HolderPadding.Parent = Holder

MessageTemplate.Name = "MessageTemplate"
MessageTemplate.BackgroundTransparency = 1
MessageTemplate.BorderSizePixel = 0
MessageTemplate.Size = UDim2.new(1, -10, 0, 0)
MessageTemplate.AutomaticSize = Enum.AutomaticSize.Y
MessageTemplate.Visible = false
MessageTemplate.Font = Enum.Font.RobotoMono
MessageTemplate.Text = ""
MessageTemplate.TextColor3 = Color3.fromRGB(255, 255, 255)
MessageTemplate.TextSize = 14
MessageTemplate.TextXAlignment = Enum.TextXAlignment.Left
MessageTemplate.TextYAlignment = Enum.TextYAlignment.Top
MessageTemplate.RichText = true
MessageTemplate.TextWrapped = true
MessageTemplate.Parent = ConsoleFrame

InputTemplate.Name = "InputTemplate"
InputTemplate.BackgroundTransparency = 1
InputTemplate.BorderSizePixel = 0
InputTemplate.Size = UDim2.new(1, -10, 0, 0)
InputTemplate.AutomaticSize = Enum.AutomaticSize.Y
InputTemplate.Visible = false
InputTemplate.RichText = false
InputTemplate.Font = Enum.Font.RobotoMono
InputTemplate.Text = ""
InputTemplate.PlaceholderText = "> type here..."
InputTemplate.TextColor3 = Color3.fromRGB(200, 255, 200)
InputTemplate.TextSize = 14
InputTemplate.TextXAlignment = Enum.TextXAlignment.Left
InputTemplate.TextYAlignment = Enum.TextYAlignment.Top
InputTemplate.TextWrapped = true
InputTemplate.ClearTextOnFocus = false
InputTemplate.Parent = ConsoleFrame

local colors = {
    BLACK = Color3.fromRGB(50, 50, 50),
    BLUE = Color3.fromRGB(0, 120, 255),
    GREEN = Color3.fromRGB(0, 255, 0),
    CYAN = Color3.fromRGB(0, 255, 255),
    RED = Color3.fromRGB(210, 50, 50),
    MAGENTA = Color3.fromRGB(255, 0, 255),
    BROWN = Color3.fromRGB(165, 42, 42),
    LIGHT_GRAY = Color3.fromRGB(211, 211, 211),
    DARK_GRAY = Color3.fromRGB(169, 169, 169),
    LIGHT_BLUE = Color3.fromRGB(173, 216, 230),
    LIGHT_GREEN = Color3.fromRGB(144, 238, 144),
    LIGHT_CYAN = Color3.fromRGB(224, 255, 255),
    LIGHT_RED = Color3.fromRGB(255, 150, 150),
    LIGHT_MAGENTA = Color3.fromRGB(255, 182, 193),
    YELLOW = Color3.fromRGB(255, 255, 0),
    WHITE = Color3.fromRGB(255, 255, 255),
    ORANGE = Color3.fromRGB(255, 165, 0),
}

local MessageColor = colors.WHITE
local ConsoleClone = nil

local function scrollToBottom(holder)
    task.defer(function()
        holder.CanvasPosition = Vector2.new(0, holder.AbsoluteCanvasSize.Y)
    end)
end

rconsolecreate = function()
    if ConsoleClone and ConsoleClone.Parent then
        ConsoleClone:Destroy()
    end
    local clone = Console:Clone()
    clone.Parent = gethui()
    ConsoleClone = clone

    clone.ConsoleFrame.Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input, clone.ConsoleFrame)
        end
    end)
end

rconsoledestroy = function()
    if ConsoleClone then
        ConsoleClone:Destroy()
        ConsoleClone = nil
    end
end

rconsoleprint = function(msg, colorOverride)
    local CONSOLE = ConsoleClone or Console
    if not CONSOLE or not CONSOLE.Parent then return end

    msg = tostring(msg)
    local lastColorName = nil

    msg = msg:gsub("@@(%a+)@@", function(colorName)
        local c = colors[colorName:upper()]
        if c then
            local tag = string.format('<font color="rgb(%d,%d,%d)">', math.floor(c.R * 255), math.floor(c.G * 255), math.floor(c.B * 255))
            local prefix = lastColorName and "</font>" or ""
            lastColorName = colorName:upper()
            return prefix .. tag
        end
        return "@@" .. colorName .. "@@"
    end)
    if lastColorName then msg = msg .. "</font>" end

    local stripped = msg:gsub('<font color="[^"]+"></font>', ""):gsub('<font color="[^"]+">(.-)</font>', "%1"):match("^%s*(.-)%s*$")
    if stripped == "" and lastColorName then
        MessageColor = colors[lastColorName] or MessageColor
        return
    end

    local holder = CONSOLE.ConsoleFrame.Holder
    local tmp = MessageTemplate:Clone()
    tmp.Parent = holder
    tmp.Text = msg
    tmp.Visible = true
    tmp.TextColor3 = colorOverride or MessageColor
    tmp.LayoutOrder = #holder:GetChildren()

    scrollToBottom(holder)
end

rconsoleinput = function()
    local CONSOLE = ConsoleClone or Console
    if not CONSOLE or not CONSOLE.Parent then return "" end

    local holder = CONSOLE.ConsoleFrame.Holder
    local box = InputTemplate:Clone()
    box.Parent = holder
    box.Visible = true
    box.TextEditable = true
    box.TextColor3 = MessageColor
    box.LayoutOrder = #holder:GetChildren()
    box:CaptureFocus()

    scrollToBottom(holder)

    local val = nil
    local done = false

    box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            val  = box.Text
            done = true
        end
    end)

    task.spawn(function()
        while not done do
            if not box:IsFocused() then
                local t = box.Text
                if t:sub(-1) ~= "_" then box.Text = t .. "_" end
                task.wait(0.5)
                if not done then
                    t = box.Text
                    if t:sub(-1) == "_" then box.Text = t:sub(1, -2) end
                end
            end
            task.wait(0.5)
        end
    end)

    while not done do task.wait(0.05) end
    return val or ""
end

rconsolename = function(name)
    local target = ConsoleClone or Console
    if target and target.Parent then
        target.ConsoleFrame.Topbar.Title.Text = tostring(name)
    end
end

rconsoleclear = function()
    local target = ConsoleClone or Console
    if not target then return end
    local holder = target.ConsoleFrame.Holder
    for _, v in ipairs(holder:GetChildren()) do
        if v:IsA("TextLabel") or v:IsA("TextBox") then
            v:Destroy()
        end
    end
end

rconsoleinfo = function(a) rconsoleprint("[INFO]: "    .. tostring(a), colors.LIGHT_BLUE) end
rconsolewarn = function(a) rconsoleprint("[WARN]: "    .. tostring(a), colors.YELLOW) end
rconsoleerr = function(a) rconsoleprint("[ERROR]: "   .. tostring(a), colors.RED) end

printconsole = function(msg, r, g, b)
    rconsoleprint(tostring(msg), Color3.fromRGB(r or 255, g or 255, b or 255))
end

rconsoleinputasync = rconsoleinput
consolecreate = rconsolecreate
consoleclear = rconsoleclear
consoledestroy = rconsoledestroy
consoleinput = rconsoleinput
rconsolesettitle = rconsolename
consolesettitle = rconsolename
consoleprint = rconsoleprint

getgenv().rconsolecreate = rconsolecreate
getgenv().rconsoledestroy = rconsoledestroy
getgenv().rconsoleprint = rconsoleprint
getgenv().rconsoleinput = rconsoleinput
getgenv().rconsolename = rconsolename
getgenv().rconsoleclear = rconsoleclear
getgenv().rconsoleinfo = rconsoleinfo
getgenv().rconsolewarn = rconsolewarn
getgenv().rconsoleerr = rconsoleerr
getgenv().printconsole = printconsole
getgenv().consolecreate = consolecreate
getgenv().consoleclear = consoleclear
getgenv().consoledestroy = consoledestroy
getgenv().consoleinput = consoleinput
getgenv().rconsolesettitle = rconsolesettitle
getgenv().consolesettitle = consolesettitle
getgenv().consoleprint = consoleprint

hookfunction = function(original, hook)
    if type(original) ~= "function" or type(hook) ~= "function" then
        return false
    end

    local hooked = function(...)
        local results = table.pack(hook(...))
        if results.n > 0 then
            return table.unpack(results, 1, results.n)
        end
        return original(...)
    end

    return hooked
end
replaceclosure = hookfunction
getgenv().hookfunction = hookfunction
getgenv().replaceclosure = replaceclosure

local _oldsm = setmetatable
local _savedmts = {}

setmetatable = function(tbl, mt)
    _savedmts[tbl] = mt
    return _oldsm(tbl, mt)
end

getrawmetatable = function(tbl)
    return _savedmts[tbl] or debug.getmetatable and debug.getmetatable(tbl)
end

setrawmetatable = function(tbl, newmt)
    local current = getrawmetatable(tbl)
    if current then
        for k, v in pairs(newmt) do
            current[k] = v
        end
    else
        _savedmts[tbl] = newmt
        _oldsm(tbl, newmt)
    end
    return tbl
end

hookmetamethod = function(self, method, func)
    local mt = getrawmetatable(self)
    if not mt then return nil end
    local old = rawget(mt, method)
    setreadonly(mt, false)
    mt[method] = func
    setreadonly(mt, true)
    return old
end
getgenv().hookmetamethod = hookmetamethod
getgenv().getrawmetatable = getrawmetatable
getgenv().setrawmetatable = setrawmetatable

local nilinstances = {}
game.DescendantRemoving:Connect(function(d)
    nilinstances[#nilinstances + 1] = d
end)

getnilinstances = function()
    return nilinstances
end
getgenv().getnilinstances = getnilinstances

local _gcObjs = {}
getgc = function(includeTables)
    return _gcObjs
end
getgenv().getgc = getgc

saveinstance = function(options)
    local Params = {
        RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
        SSI = "saveinstance",
    }
    local ok, synsaveinstance = pcall(function()
        return loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
    end)
    if not ok or type(synsaveinstance) ~= "function" then
        warn("[Lumina] saveinstance: failed to load SynSaveInstance")
        return
    end
    local SaveOptions = options or {
        ReadMe = true,
        IsolatePlayers = true,
        FilePath = tostring(os.time()),
    }
    synsaveinstance(SaveOptions)
end
getgenv().saveinstance = saveinstance

local ok, decompsrc = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/w-a-e/Advanced-Decompiler-V3/main/init.lua")
end)

if ok and type(decompsrc) == "string" and #decompsrc > 0 then
    local function loaddecomp(timeout)
        local CONSTANTS = string.format([[
local ENABLED_REMARKS = { NATIVE_REMARK = true, INLINE_REMARK = true }
local DECOMPILER_TIMEOUT     = %d
local READER_FLOAT_PRECISION = 99
local SHOW_INSTRUCTION_LINES = false
local SHOW_REFERENCES        = true
local SHOW_OPERATION_NAMES   = false
local SHOW_MISC_OPERATIONS   = true
local LIST_USED_GLOBALS      = true
local RETURN_ELAPSED_TIME    = false
]], tonumber(timeout) or 10)

        local src = decompsrc:gsub("%-%- CONSTANTS HERE %-%-", CONSTANTS, 1)

        local loader = loadstring or load
        local fn, err = loader(src, "Advanced-Decompiler-V3")

        if not fn then
            warn("[Lumina] Decompiler compile error: " .. tostring(err))
            return
        end

        local success, runtimeErr = pcall(fn)
        if not success then
            warn("[Lumina] Decompiler runtime error: " .. tostring(runtimeErr))
        end
    end

    loaddecomp(10)
else
    warn("[Lumina] Failed to fetch decompiler source")
end


local function reg(funcName, func, testfunc)
    local env = getgenv and getgenv() or _G

    local ok2, err = pcall(function()
        env[funcName] = func
    end)

    if not ok2 then
        warn("[Lumina] Failed to register " .. tostring(funcName) .. ": " .. tostring(err))
        return
    end

    if typeof(testfunc) == "function" then
        local tok, terr = pcall(testfunc)
        if not tok then
            warn("[Lumina] Test failed for " .. tostring(funcName) .. ": " .. tostring(terr))
        end
    end
end

reg("getdevice", function()
    local platform = tostring(UserInputService:GetPlatform())
    return platform:split(".")[3] or platform
end)

reg("getping", function(suffix)
    local ok3, raw = pcall(function()
        return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    end)
    if not ok3 then return suffix and "0 ms" or "0" end
    local num = tonumber(raw:match("([%d%.]+)")) or 0
    local rounded = tostring(math.round(num))
    return suffix and (rounded .. " ms") or rounded
end)

reg("getscriptclosure", function(script)
    if not script then return {} end
    local env = getfenv and getfenv(script) or {}
    return env
end)

reg("getfps", function()
    local fps   = 0
    local conn
    local frames = 0
    local elapsed = 0

    conn = RunService.Heartbeat:Connect(function(dt)
        frames  = frames + 1
        elapsed = elapsed + dt
    end)

    task.wait(0.5)
    conn:Disconnect()

    fps = elapsed > 0 and math.round(frames / elapsed) or 0
    return fps
end)

reg("getaffiliateid", function()
    return "moREnc"
end)

reg("getplayers", function()
    local result = {}
    for _, p in ipairs(Players:GetPlayers()) do
        result[p.Name] = p
    end
    result["LocalPlayer"] = Players.LocalPlayer
    return result
end)

reg("getplayer", function(name)
    local list = getgenv().getplayers()
    return name and list[name] or list["LocalPlayer"]
end)

reg("getlocalplayer", function()
    return Players.LocalPlayer
end)

reg("customprint", function(text, properties, imageId)
    print(text)
    task.wait(0.05)
    local ok4, clientLog = pcall(function()
        return CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI.MainView.ClientLog
    end)
    if not ok4 then return end
    local children = clientLog:GetChildren()
    local msg = children[#children - 1] or children[#children]
    if msg and properties then
        for k, v in pairs(properties) do
            pcall(function() msg[k] = v end)
        end
        if imageId then
            pcall(function() msg.Parent.image.Image = imageId end)
        end
    end
end)

reg("join", function(placeID, jobID)
    local ts = game:GetService("TeleportService")
    if jobID then
        ts:TeleportToPlaceInstance(placeID, jobID, Players.LocalPlayer)
    else
        ts:Teleport(placeID, Players.LocalPlayer)
    end
end)

reg("firesignal", function(instanceOrSignal, signalNameOrArgs, args)
    local signal
    if type(signalNameOrArgs) == "string" then
        signal = instanceOrSignal[signalNameOrArgs]
        args = args
    else
        signal = instanceOrSignal
        args = signalNameOrArgs
    end
    if not signal then return end
    local conns = getconnections and getconnections(signal)
    if not conns then return end
    for _, conn in ipairs(conns) do
        if args ~= nil then
            conn:Fire(args)
        else
            conn:Fire()
        end
    end
end)

reg("firetouchinterest", function(part, touched)
    getgenv().firesignal(part, touched == false and "TouchEnded" or "Touched")
end)

reg("fireproximityprompt", function(prompt, triggered, hold)
    local eventName
    if hold then
        eventName = triggered and "PromptButtonHoldBegan" or "PromptButtonHoldEnded"
    else
        eventName = (triggered == false) and "TriggerEnded" or "Triggered"
    end
    getgenv().firesignal(prompt, eventName)
end)

reg("runanimation", function(animationId, player)
    local plr = player or Players.LocalPlayer
    if not plr or not plr.Character then return end
    local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. tostring(animationId)
    local track = humanoid:LoadAnimation(anim)
    track:Play()
end)

reg("round", function() getgenv().round = math.round end)
reg("joingame", function() getgenv().joingame = getgenv().join end)
reg("joinserver", function() getgenv().joinserver = getgenv().join end)
reg("firetouchtransmitter", function() getgenv().firetouchtransmitter = getgenv().firetouchinterest end)
reg("getplatform", function() getgenv().getplatform = getgenv().getdevice end)
reg("getos", function() getgenv().getos = getgenv().getdevice end)
reg("playanimation", function() getgenv().playanimation = getgenv().runanimation end)
reg("setrbxclipboard", function() getgenv().setrbxclipboard = setclipboard end)

getgenv().round()
getgenv().joingame()
getgenv().joinserver()
getgenv().firetouchtransmitter()
getgenv().getplatform()
getgenv().getos()
getgenv().playanimation()
pcall(function() getgenv().setrbxclipboard() end)

print("[ LUMINA ENV v16 ] Environment loaded successfully.")
