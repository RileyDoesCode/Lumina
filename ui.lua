repeat
	task.wait(1)
until game:IsLoaded();

local executorName, executorVersion, executorType = identifyexecutor()
local http_request = request or http_request or (syn and syn.request) or (http and http.request)
local function GLYX_SAFE_REQUEST(data)
    if type(data) ~= "table" or not data.Url then
        return {
            StatusCode = 0,
            StatusMessage = "Invalid request data",
            Body = ""
        }
    end
    local method = (data.Method or "GET"):upper()
    local url = data.Url
    if http_request then
        local ok, res = pcall(http_request, {
            Url = url,
            Method = method,
            Headers = data.Headers or {},
            Body = data.Body or ""
        })
        if ok and res then
            return {
                StatusCode = res.StatusCode or 200,
                StatusMessage = res.StatusMessage or "OK",
                Body = res.Body or ""
            }
        else
            return {
                StatusCode = 0,
                StatusMessage = tostring(res),
                Body = ""
            }
        end
    end
    local success, result
    if method == "GET" then
        success, result = pcall(game.HttpGet, game, url)
    elseif method == "POST" then
        local contentType = (data.Headers and data.Headers["Content-Type"]) or "application/json"
        success, result = pcall(game.HttpPost, game, url, data.Body or "", contentType)
    else
        return {
            StatusCode = 0,
            StatusMessage = "Unsupported method: " .. method,
            Body = ""
        }
    end
    if success then
        return {
            StatusCode = 200,
            StatusMessage = "OK",
            Body = result
        }
    end
    local code = tonumber(string.match(tostring(result), "%d%d%d"))
    return {
        StatusCode = code or 0,
        StatusMessage = tostring(result),
        Body = ""
    }
end

if game.CoreGui:FindFirstChild('LuminaGui') then
	game.CoreGui.LuminaGui:Destroy()
end
local LuminaGui = Instance.new("ScreenGui")
LuminaGui.DisplayOrder = 3
LuminaGui.IgnoreGuiInset = true
LuminaGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
LuminaGui.Name = "LuminaGui"
LuminaGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local sidebarframe = Instance.new("Frame")
sidebarframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sidebarframe.BackgroundTransparency = 1
sidebarframe.BorderColor = BrickColor.new("Really black")
sidebarframe.BorderColor3 = Color3.fromRGB(0, 0, 0)
sidebarframe.BorderSizePixel = 0
sidebarframe.ClipsDescendants = true
sidebarframe.Size = UDim2.new(0, 170, 1, 0)
sidebarframe.Name = "sidebarframe"

local sidebar = Instance.new("CanvasGroup")
sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
sidebar.BackgroundTransparency = 0.4
sidebar.BorderColor = BrickColor.new("Really black")
sidebar.BorderColor3 = Color3.fromRGB(0, 0, 0)
sidebar.BorderSizePixel = 0
sidebar.Size = UDim2.new(0, 170, 1, 0)
sidebar.Name = "sidebar"

local tabs = Instance.new("Frame")
tabs.AnchorPoint = Vector2.new(0, 0.5)
tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabs.BackgroundTransparency = 1
tabs.BorderColor = BrickColor.new("Really black")
tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
tabs.BorderSizePixel = 0
tabs.Position = UDim2.new(0, 0, 0.5, 0)
tabs.Size = UDim2.new(1, 0, 0, 150)
tabs.Name = "tabs"

local home = Instance.new("TextButton")
home.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
home.Text = ""
home.TextColor = BrickColor.new("Really black")
home.TextColor3 = Color3.fromRGB(0, 0, 0)
home.TextSize = 14
home.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
home.BackgroundTransparency = 1
home.BorderColor = BrickColor.new("Really black")
home.BorderColor3 = Color3.fromRGB(0, 0, 0)
home.BorderSizePixel = 0
home.Size = UDim2.new(1, 0, 0, 32)
home.Name = "home"

local homei = Instance.new("ImageLabel")
homei.Image = "rbxassetid://11433532654"
--[[ Unsupported Type: Content For : ImageContent ]]
homei.ImageTransparency = 0.1
homei.ScaleType = Enum.ScaleType.Fit
homei.AnchorPoint = Vector2.new(0, 0.5)
homei.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
homei.BackgroundTransparency = 1
homei.BorderColor = BrickColor.new("Really black")
homei.BorderColor3 = Color3.fromRGB(0, 0, 0)
homei.BorderSizePixel = 0
homei.Position = UDim2.new(0, 12, 0.5, 0)
homei.Size = UDim2.new(0, 25, 0, 25)
homei.Name = "homei"

local TextLabel = Instance.new("TextLabel")
TextLabel.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel.Text = "Home"
TextLabel.TextColor = BrickColor.new("Institutional white")
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 12
TextLabel.TextTransparency = 0.2
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderColor = BrickColor.new("Really black")
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.3, 0, 0.28, 0)
TextLabel.Size = UDim2.new(0, 90, 0, 14)

local tabglow = Instance.new("ImageLabel")
tabglow.Image = "rbxassetid://137578452726708"
--[[ Unsupported Type: Content For : ImageContent ]]
tabglow.ScaleType = Enum.ScaleType.Crop
tabglow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabglow.BackgroundTransparency = 0.95
tabglow.BorderColor = BrickColor.new("Really black")
tabglow.BorderColor3 = Color3.fromRGB(0, 0, 0)
tabglow.BorderSizePixel = 0
tabglow.Position = UDim2.new(0.03, 0, 0, 0)
tabglow.Size = UDim2.new(0.95, 0, 1, 0)
tabglow.Name = "tabglow"
tabglow.ZIndex=0
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.3, 0)

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
UIGradient.Rotation = -23

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 3)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local executor = Instance.new("TextButton")
executor.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
executor.Text = ""
executor.TextColor = BrickColor.new("Really black")
executor.TextColor3 = Color3.fromRGB(0, 0, 0)
executor.TextSize = 14
executor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
executor.BackgroundTransparency = 1
executor.BorderColor = BrickColor.new("Really black")
executor.BorderColor3 = Color3.fromRGB(0, 0, 0)
executor.BorderSizePixel = 0
executor.Size = UDim2.new(1, 0, 0, 32)
executor.Name = "executor"

local executori = Instance.new("ImageLabel")
executori.Image = "rbxassetid://11295287500"
--[[ Unsupported Type: Content For : ImageContent ]]
executori.ImageTransparency = 0.1
executori.ScaleType = Enum.ScaleType.Fit
executori.AnchorPoint = Vector2.new(0, 0.5)
executori.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
executori.BackgroundTransparency = 1
executori.BorderColor = BrickColor.new("Really black")
executori.BorderColor3 = Color3.fromRGB(0, 0, 0)
executori.BorderSizePixel = 0
executori.Position = UDim2.new(0, 12, 0.5, 0)
executori.Size = UDim2.new(0, 25, 0, 25)
executori.Name = "executori"

local TextLabel_2 = Instance.new("TextLabel")
TextLabel_2.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_2.Text = "Executor"
TextLabel_2.TextColor = BrickColor.new("Institutional white")
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 12
TextLabel_2.TextTransparency = 0.2
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.BorderColor = BrickColor.new("Really black")
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.3, 0, 0.28, 0)
TextLabel_2.Size = UDim2.new(0, 90, 0, 14)

local scripthub = Instance.new("TextButton")
scripthub.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
scripthub.Text = ""
scripthub.TextColor = BrickColor.new("Really black")
scripthub.TextColor3 = Color3.fromRGB(0, 0, 0)
scripthub.TextSize = 14
scripthub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scripthub.BackgroundTransparency = 1
scripthub.BorderColor = BrickColor.new("Really black")
scripthub.BorderColor3 = Color3.fromRGB(0, 0, 0)
scripthub.BorderSizePixel = 0
scripthub.Size = UDim2.new(1, 0, 0, 32)
scripthub.Name = "scripthub"

local scripthubi = Instance.new("ImageLabel")
scripthubi.Image = "rbxassetid://11422151506"
--[[ Unsupported Type: Content For : ImageContent ]]
scripthubi.ImageTransparency = 0.1
scripthubi.ScaleType = Enum.ScaleType.Fit
scripthubi.AnchorPoint = Vector2.new(0, 0.5)
scripthubi.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scripthubi.BackgroundTransparency = 1
scripthubi.BorderColor = BrickColor.new("Really black")
scripthubi.BorderColor3 = Color3.fromRGB(0, 0, 0)
scripthubi.BorderSizePixel = 0
scripthubi.Position = UDim2.new(0, 12, 0.5, 0)
scripthubi.Size = UDim2.new(0, 25, 0, 25)
scripthubi.Name = "scripthubi"

local TextLabel_3 = Instance.new("TextLabel")
TextLabel_3.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_3.Text = "Script Hub"
TextLabel_3.TextColor = BrickColor.new("Institutional white")
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextSize = 12
TextLabel_3.TextTransparency = 0.2
TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1
TextLabel_3.BorderColor = BrickColor.new("Really black")
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.3, 0, 0.28, 0)
TextLabel_3.Size = UDim2.new(0, 90, 0, 14)

local settings = Instance.new("TextButton")
settings.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
settings.Text = ""
settings.TextColor = BrickColor.new("Really black")
settings.TextColor3 = Color3.fromRGB(0, 0, 0)
settings.TextSize = 14
settings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
settings.BackgroundTransparency = 1
settings.BorderColor = BrickColor.new("Really black")
settings.BorderColor3 = Color3.fromRGB(0, 0, 0)
settings.BorderSizePixel = 0
settings.Size = UDim2.new(1, 0, 0, 32)
settings.Name = "settings"

local settingsi = Instance.new("ImageLabel")
settingsi.Image = "rbxassetid://11293977610"
--[[ Unsupported Type: Content For : ImageContent ]]
settingsi.ImageTransparency = 0.1
settingsi.ScaleType = Enum.ScaleType.Fit
settingsi.AnchorPoint = Vector2.new(0, 0.5)
settingsi.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
settingsi.BackgroundTransparency = 1
settingsi.BorderColor = BrickColor.new("Really black")
settingsi.BorderColor3 = Color3.fromRGB(0, 0, 0)
settingsi.BorderSizePixel = 0
settingsi.Position = UDim2.new(0, 12, 0.5, 0)
settingsi.Size = UDim2.new(0, 25, 0, 25)
settingsi.Name = "settingsi"

local TextLabel_4 = Instance.new("TextLabel")
TextLabel_4.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_4.Text = "Settings"
TextLabel_4.TextColor = BrickColor.new("Institutional white")
TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.TextSize = 12
TextLabel_4.TextTransparency = 0.2
TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1
TextLabel_4.BorderColor = BrickColor.new("Really black")
TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.BorderSizePixel = 0
TextLabel_4.Position = UDim2.new(0.3, 0, 0.28, 0)
TextLabel_4.Size = UDim2.new(0, 90, 0, 14)

local logo = Instance.new("ImageButton")
logo.Image = "rbxassetid://79367513177680"
--[[ Unsupported Type: Content For : ImageContent ]]
logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
logo.BackgroundTransparency = 1
logo.BorderColor = BrickColor.new("Really black")
logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
logo.BorderSizePixel = 0
logo.Position = UDim2.new(0, 12, 0, 12)
logo.Size = UDim2.new(0, 25, 0, 25)
logo.Name = "logo"

local close1 = Instance.new("ImageLabel")
close1.Image = "rbxassetid://11293981586"
--[[ Unsupported Type: Content For : ImageContent ]]
close1.AnchorPoint = Vector2.new(0, 1)
close1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
close1.BackgroundTransparency = 1
close1.BorderColor = BrickColor.new("Really black")
close1.BorderColor3 = Color3.fromRGB(0, 0, 0)
close1.BorderSizePixel = 0
close1.Position = UDim2.new(0, 15, 1, -15)
close1.Size = UDim2.new(0, 20, 0, 20)
close1.Name = "close1"

local close2 = Instance.new("TextButton")
close2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
close2.Text = ""
close2.TextColor = BrickColor.new("Really black")
close2.TextColor3 = Color3.fromRGB(0, 0, 0)
close2.TextSize = 14
close2.AnchorPoint = Vector2.new(0.5, 1)
close2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
close2.BackgroundTransparency = 1
close2.BorderColor = BrickColor.new("Really black")
close2.BorderColor3 = Color3.fromRGB(0, 0, 0)
close2.BorderSizePixel = 0
close2.Position = UDim2.new(0.5, 0, 1, -7)
close2.Size = UDim2.new(0.9, 0, 0, 35)
close2.Name = "close2"

local title = Instance.new("TextLabel")
title.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
title.Text = "Lumina"
title.TextColor = BrickColor.new("Institutional white")
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 13
title.TextTransparency = 0
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.BorderColor = BrickColor.new("Really black")
title.BorderColor3 = Color3.fromRGB(0, 0, 0)
title.BorderSizePixel = 0
title.Position = UDim2.new(0, 50, 0, 12)
title.Size = UDim2.new(0, 105, 0, 14)
title.Name = "title"

local closelbl = Instance.new("TextLabel")
closelbl.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
closelbl.Text = "Close"
closelbl.TextColor = BrickColor.new("Institutional white")
closelbl.TextColor3 = Color3.fromRGB(255, 255, 255)
closelbl.TextSize = 13
closelbl.TextTransparency = 0.2
closelbl.TextXAlignment = Enum.TextXAlignment.Left
closelbl.AnchorPoint = Vector2.new(0, 1)
closelbl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
closelbl.BackgroundTransparency = 1
closelbl.BorderColor = BrickColor.new("Really black")
closelbl.BorderColor3 = Color3.fromRGB(0, 0, 0)
closelbl.BorderSizePixel = 0
closelbl.Position = UDim2.new(0, 50, 1, -18)
closelbl.Size = UDim2.new(0, 90, 0, 14)
closelbl.Name = "closelbl"

local title_2 = Instance.new("TextLabel")
title_2.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
title_2.Text = "v1.0"
title_2.TextColor = BrickColor.new("Institutional white")
title_2.TextTransparency=0.2
title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
title_2.TextSize = 11
title_2.TextXAlignment = Enum.TextXAlignment.Left
title_2.TextYAlignment = Enum.TextYAlignment.Top
title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title_2.BackgroundTransparency = 1
title_2.BorderColor = BrickColor.new("Really black")
title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
title_2.BorderSizePixel = 0
title_2.Position = UDim2.new(0, 50, 0, 26)
title_2.Size = UDim2.new(0, 105, 0, 14)
title_2.Name = "title"

local background = Instance.new("ScreenGui")
background.DisplayOrder = 2
background.IgnoreGuiInset = true
background.ScreenInsets = Enum.ScreenInsets.None
background.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
background.Name = "background"

local bg = Instance.new("Frame")
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.2
bg.BorderColor = BrickColor.new("Really black")
bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
bg.BorderSizePixel = 0
bg.Size = UDim2.new(1, 0, 1, 0)
bg.ZIndex = 0
bg.Name = "bg"

local glow = Instance.new("ImageLabel")
glow.Image = "rbxassetid://80389892606711"
--[[ Unsupported Type: Content For : ImageContent ]]
glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glow.BackgroundTransparency = 1
glow.BorderColor = BrickColor.new("Really black")
glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
glow.BorderSizePixel = 0
glow.Size = UDim2.new(1, 0, 1, 0)
glow.Name = "glow"
glow.ImageTransparency=0.8
local UIGradient_2 = Instance.new("UIGradient")
UIGradient_2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})

local glowf1 = Instance.new("ImageLabel")
glowf1.Image = "rbxassetid://76466847613207"
--[[ Unsupported Type: Content For : ImageContent ]]
glowf1.ImageTransparency = 0.8
glowf1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glowf1.BackgroundTransparency = 1
glowf1.BorderColor = BrickColor.new("Really black")
glowf1.BorderColor3 = Color3.fromRGB(0, 0, 0)
glowf1.BorderSizePixel = 0
glowf1.Position = UDim2.new(-0.19, 0, -0.23, 0)
glowf1.Size = UDim2.new(0.46, 0, 0.76, 0)
glowf1.Name = "glowf1"

local UIGradient_3 = Instance.new("UIGradient")
UIGradient_3.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
UIGradient_3.Rotation = -123

local glowf2 = Instance.new("ImageLabel")
glowf2.Image = "rbxassetid://76466847613207"
--[[ Unsupported Type: Content For : ImageContent ]]
glowf2.ImageTransparency = 0.8
glowf2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glowf2.BackgroundTransparency = 1
glowf2.BorderColor = BrickColor.new("Really black")
glowf2.BorderColor3 = Color3.fromRGB(0, 0, 0)
glowf2.BorderSizePixel = 0
glowf2.Position = UDim2.new(-0.11, 0, 0.03, 0)
glowf2.Size = UDim2.new(0.41, 0, 0.79, 0)
glowf2.Name = "glowf2"

local UIGradient_4 = Instance.new("UIGradient")
UIGradient_4.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})

local glowf3 = Instance.new("ImageLabel")
glowf3.Image = "rbxassetid://76466847613207"
--[[ Unsupported Type: Content For : ImageContent ]]
glowf3.ImageTransparency = 0.8
glowf3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glowf3.BackgroundTransparency = 1
glowf3.BorderColor = BrickColor.new("Really black")
glowf3.BorderColor3 = Color3.fromRGB(0, 0, 0)
glowf3.BorderSizePixel = 0
glowf3.Position = UDim2.new(-0.17, 0, 0.35, 0)
glowf3.Size = UDim2.new(0.44, 0, 0.85, 0)
glowf3.Name = "glowf3"

local UIGradient_5 = Instance.new("UIGradient")
UIGradient_5.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
UIGradient_5.Rotation = -180

local homepage = Instance.new("Frame")
homepage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
homepage.BackgroundTransparency = 1
homepage.BorderColor = BrickColor.new("Really black")
homepage.BorderColor3 = Color3.fromRGB(0, 0, 0)
homepage.BorderSizePixel = 0
homepage.Position = UDim2.new(0, 170, 0, 0)
homepage.Size = UDim2.new(1, -170, 1, 0)
homepage.Name = "homepage"

local profile = Instance.new("CanvasGroup")
profile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
profile.BackgroundTransparency = 1
profile.BorderColor = BrickColor.new("Really black")
profile.BorderColor3 = Color3.fromRGB(0, 0, 0)
profile.BorderSizePixel = 0
profile.Position = UDim2.new(0.02, 0, 0.03, 0)
profile.Size = UDim2.new(0.4, 0, 0.15, 0)
profile.Name = "profile"

local UICorner_2 = Instance.new("UICorner")
UICorner_2.CornerRadius = UDim.new(0.1, 0)

local dots = Instance.new("ImageLabel")
dots.Image = "rbxassetid://137720642301046"
--[[ Unsupported Type: Content For : ImageContent ]]
dots.ImageTransparency = 0.5
dots.ScaleType = Enum.ScaleType.Crop
dots.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dots.BackgroundTransparency = 0.8
dots.BorderColor = BrickColor.new("Really black")
dots.BorderColor3 = Color3.fromRGB(0, 0, 0)
dots.BorderSizePixel = 0
dots.Size = UDim2.new(1, 0, 1, 0)
dots.Name = "dots"

local dotg1 = Instance.new("UIGradient")
dotg1.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
dotg1.Rotation = -23
dotg1.Name = "dotg1"

local ava = Instance.new("ImageLabel")
ava.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
--[[ Unsupported Type: Content For : ImageContent ]]
ava.ScaleType = Enum.ScaleType.Fit
ava.AnchorPoint = Vector2.new(0, 0.5)
ava.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ava.BackgroundTransparency = 1
ava.BorderColor = BrickColor.new("Really black")
ava.BorderColor3 = Color3.fromRGB(0, 0, 0)
ava.BorderSizePixel = 0
ava.Position = UDim2.new(0.05, 0, 0.5, 0)
ava.Size = UDim2.new(0.15, 0, 0.6, 0)
ava.Name = "ava"

local UICorner_3 = Instance.new("UICorner")
UICorner_3.CornerRadius = UDim.new(0.1, 0)

local Hello = Instance.new("TextLabel")
Hello.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Hello.Text = "Hello!"
Hello.TextColor = BrickColor.new("Institutional white")
Hello.TextColor3 = Color3.fromRGB(255, 255, 255)
Hello.TextScaled = true
Hello.TextSize = 14
Hello.TextTransparency = 0.2
Hello.TextWrapped = true
Hello.TextXAlignment = Enum.TextXAlignment.Left
Hello.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Hello.BackgroundTransparency = 1
Hello.BorderColor = BrickColor.new("Really black")
Hello.BorderColor3 = Color3.fromRGB(0, 0, 0)
Hello.BorderSizePixel = 0
Hello.Position = UDim2.new(0.23, 0, 0.27, 0)
Hello.Size = UDim2.new(0.6, 0, 0.2, 0)
Hello.Name = "Hello"

local username = Instance.new("TextLabel")
username.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
username.Text = "Player123"
username.TextColor = BrickColor.new("Institutional white")
username.TextColor3 = Color3.fromRGB(255, 255, 255)
username.TextScaled = true
username.TextSize = 14
username.TextWrapped = true
username.TextXAlignment = Enum.TextXAlignment.Left
username.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
username.BackgroundTransparency = 1
username.BorderColor = BrickColor.new("Really black")
username.BorderColor3 = Color3.fromRGB(0, 0, 0)
username.BorderSizePixel = 0
username.Position = UDim2.new(0.23, 0, 0.45, 0)
username.Size = UDim2.new(0.6, 0, 0.34, 0)
username.Name = "username"

local UIStroke = Instance.new("UIStroke")
UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.95

local changelog = Instance.new("CanvasGroup")
changelog.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
changelog.BackgroundTransparency = 1
changelog.BorderColor = BrickColor.new("Really black")
changelog.BorderColor3 = Color3.fromRGB(0, 0, 0)
changelog.BorderSizePixel = 0
changelog.Position = UDim2.new(0.02, 0, 0.2, 0)
changelog.Size = UDim2.new(0.4, 0, 0.76, 0)
changelog.Name = "changelog"

local UICorner_4 = Instance.new("UICorner")
UICorner_4.CornerRadius = UDim.new(0.04, 0)

local dots2 = Instance.new("ImageLabel")
dots2.Image = "rbxassetid://137578452726708"
--[[ Unsupported Type: Content For : ImageContent ]]
dots2.ImageTransparency = 0.8
dots2.ScaleType = Enum.ScaleType.Crop
dots2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dots2.BackgroundTransparency = 0.8
dots2.BorderColor = BrickColor.new("Really black")
dots2.BorderColor3 = Color3.fromRGB(0, 0, 0)
dots2.BorderSizePixel = 0
dots2.Size = UDim2.new(1, 0, 1, 0)
dots2.Name = "dots2"

local dots2g = Instance.new("UIGradient")
dots2g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
dots2g.Rotation = -23
dots2g.Name = "dots2g"

local UIStroke_2 = Instance.new("UIStroke")
UIStroke_2.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
UIStroke_2.Transparency = 0.95

local topbar = Instance.new("ImageLabel")
topbar.Image = "rbxassetid://92088903100095"
--[[ Unsupported Type: Content For : ImageContent ]]
topbar.ImageTransparency = 0.9
topbar.ScaleType = Enum.ScaleType.Crop
topbar.SliceScale = 100
topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
topbar.BackgroundTransparency = 1
topbar.BorderColor = BrickColor.new("Really black")
topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
topbar.BorderSizePixel = 0
topbar.Size = UDim2.new(1, 0, 0.09, 0)
topbar.ZIndex = 3
topbar.Name = "topbar"

local UIStroke_3 = Instance.new("UIStroke")
UIStroke_3.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke_3.Color = Color3.fromRGB(255, 255, 255)
UIStroke_3.Transparency = 0.95

local UIGradient_6 = Instance.new("UIGradient")
UIGradient_6.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
UIGradient_6.Rotation = -23

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Image = "rbxassetid://12974219084"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel.ScaleType = Enum.ScaleType.Fit
ImageLabel.AnchorPoint = Vector2.new(1, 0.5)
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderColor = BrickColor.new("Really black")
ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(0.98, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0.1, 0, 0.6, 0)

local TextLabel_5 = Instance.new("TextLabel")
TextLabel_5.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_5.Text = "ChangeLog"
TextLabel_5.TextColor = BrickColor.new("Institutional white")
TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.TextScaled = true
TextLabel_5.TextSize = 14
TextLabel_5.TextWrapped = true
TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_5.AnchorPoint = Vector2.new(0, 0.5)
TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.BackgroundTransparency = 1
TextLabel_5.BorderColor = BrickColor.new("Really black")
TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.BorderSizePixel = 0
TextLabel_5.Position = UDim2.new(0.05, 0, 0.5, 0)
TextLabel_5.Size = UDim2.new(0.7, 0, 0.5, 0)

local scripts = Instance.new("CanvasGroup")
scripts.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scripts.BackgroundTransparency = 1
scripts.BorderColor = BrickColor.new("Really black")
scripts.BorderColor3 = Color3.fromRGB(0, 0, 0)
scripts.BorderSizePixel = 0
scripts.Position = UDim2.new(0.44, 0, 0.03, 0)
scripts.Size = UDim2.new(0.54, 0, 0.72, 0)
scripts.Transparency = 1
scripts.Name = "scripts"

local UICorner_5 = Instance.new("UICorner")
UICorner_5.CornerRadius = UDim.new(0.02, 0)

local dots4 = Instance.new("ImageLabel")
dots4.Image = "rbxassetid://137720642301046"
--[[ Unsupported Type: Content For : ImageContent ]]
dots4.ImageTransparency = 0.8
dots4.ScaleType = Enum.ScaleType.Crop
dots4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dots4.BackgroundTransparency = 0.8
dots4.BorderColor = BrickColor.new("Really black")
dots4.BorderColor3 = Color3.fromRGB(0, 0, 0)
dots4.BorderSizePixel = 0
dots4.Size = UDim2.new(1, 0, 1, 0)
dots4.Name = "dots4"

local dots4g = Instance.new("UIGradient")
dots4g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
dots4g.Rotation = -23
dots4g.Name = "dots4g"

local UIStroke_4 = Instance.new("UIStroke")
UIStroke_4.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke_4.Color = Color3.fromRGB(255, 255, 255)
UIStroke_4.Transparency = 0.95

local topbar_2 = Instance.new("ImageLabel")
topbar_2.Image = "rbxassetid://92088903100095"
--[[ Unsupported Type: Content For : ImageContent ]]
topbar_2.ImageTransparency = 0.9
topbar_2.ScaleType = Enum.ScaleType.Crop
topbar_2.SliceScale = 100
topbar_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
topbar_2.BackgroundTransparency = 1
topbar_2.BorderColor = BrickColor.new("Really black")
topbar_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
topbar_2.BorderSizePixel = 0
topbar_2.Size = UDim2.new(1, 0, 0.09, 0)
topbar_2.ZIndex = 3
topbar_2.Name = "topbar"

local UIStroke_5 = Instance.new("UIStroke")
UIStroke_5.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke_5.Color = Color3.fromRGB(255, 255, 255)
UIStroke_5.Transparency = 0.95

local UIGradient_7 = Instance.new("UIGradient")
UIGradient_7.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
UIGradient_7.Rotation = -23

local ImageLabel_2 = Instance.new("ImageLabel")
ImageLabel_2.Image = "rbxassetid://14202377484"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel_2.ScaleType = Enum.ScaleType.Fit
ImageLabel_2.AnchorPoint = Vector2.new(1, 0.5)
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_2.BackgroundTransparency = 1
ImageLabel_2.BorderColor = BrickColor.new("Really black")
ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_2.BorderSizePixel = 0
ImageLabel_2.Position = UDim2.new(0.98, 0, 0.5, 0)
ImageLabel_2.Size = UDim2.new(0.1, 0, 0.6, 0)

local TextLabel_6 = Instance.new("TextLabel")
TextLabel_6.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_6.Text = "Featured Scripts"
TextLabel_6.TextColor = BrickColor.new("Institutional white")
TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_6.TextScaled = true
TextLabel_6.TextSize = 14
TextLabel_6.TextWrapped = true
TextLabel_6.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_6.AnchorPoint = Vector2.new(0, 0.5)
TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_6.BackgroundTransparency = 1
TextLabel_6.BorderColor = BrickColor.new("Really black")
TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_6.BorderSizePixel = 0
TextLabel_6.Position = UDim2.new(0.05, 0, 0.5, 0)
TextLabel_6.Size = UDim2.new(0.7, 0, 0.52, 0)

local discord = Instance.new("CanvasGroup")
discord.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
discord.BackgroundTransparency = 1
discord.BorderColor = BrickColor.new("Really black")
discord.BorderColor3 = Color3.fromRGB(0, 0, 0)
discord.BorderSizePixel = 0
discord.Position = UDim2.new(0.44, 0, 0.77, 0)
discord.Size = UDim2.new(0.54, 0, 0.18, 0)
discord.Name = "discord"

local UICorner_6 = Instance.new("UICorner")
UICorner_6.CornerRadius = UDim.new(0.1, 0)

local dots3 = Instance.new("ImageLabel")
dots3.Image = "rbxassetid://137720642301046"
--[[ Unsupported Type: Content For : ImageContent ]]
dots3.ImageTransparency = 0.8
dots3.ScaleType = Enum.ScaleType.Crop
dots3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dots3.BackgroundTransparency = 0.8
dots3.BorderColor = BrickColor.new("Really black")
dots3.BorderColor3 = Color3.fromRGB(0, 0, 0)
dots3.BorderSizePixel = 0
dots3.Size = UDim2.new(1, 0, 1, 0)
dots3.Name = "dots3"

local dots3g = Instance.new("UIGradient")
dots3g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
dots3g.Rotation = -23
dots3g.Name = "dots3g"

local UIStroke_6 = Instance.new("UIStroke")
UIStroke_6.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke_6.Color = Color3.fromRGB(255, 255, 255)
UIStroke_6.Transparency = 0.95

local ImageLabel_3 = Instance.new("ImageLabel")
ImageLabel_3.Image = "rbxassetid://101379503343998"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel_3.ImageTransparency = 0.3
ImageLabel_3.ScaleType = Enum.ScaleType.Fit
ImageLabel_3.AnchorPoint = Vector2.new(0, 0.5)
ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_3.BackgroundTransparency = 1
ImageLabel_3.BorderColor = BrickColor.new("Really black")
ImageLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_3.BorderSizePixel = 0
ImageLabel_3.Position = UDim2.new(0.05, 0, 0.5, 0)
ImageLabel_3.Size = UDim2.new(0.15, 0, 0.6, 0)

local UICorner_7 = Instance.new("UICorner")
UICorner_7.CornerRadius = UDim.new(0.1, 0)

local ImageButton = Instance.new("ImageButton")
ImageButton.Image = "rbxassetid://12974407511"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageButton.ImageTransparency = 0.2
ImageButton.ScaleType = Enum.ScaleType.Fit
ImageButton.AnchorPoint = Vector2.new(1, 0.5)
ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageButton.BackgroundTransparency = 1
ImageButton.BorderColor = BrickColor.new("Really black")
ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0.95, 0, 0.5, 0)
ImageButton.Size = UDim2.new(0.1, 0, 0.4, 0)
ImageButton.ZIndex = 3

local TextLabel_7 = Instance.new("TextLabel")
TextLabel_7.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel_7.Text = "discord.gg/9RaBWkyfyT"
TextLabel_7.TextColor = BrickColor.new("Institutional white")
TextLabel_7.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_7.TextScaled = true
TextLabel_7.TextSize = 14
TextLabel_7.TextTransparency = 0.2
TextLabel_7.TextWrapped = true
TextLabel_7.TextYAlignment = Enum.TextYAlignment.Top
TextLabel_7.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_7.BackgroundTransparency = 1
TextLabel_7.BorderColor = BrickColor.new("Really black")
TextLabel_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_7.BorderSizePixel = 0
TextLabel_7.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel_7.Size = UDim2.new(0.5, 0, 0.28, 0)

local executorpage = Instance.new("Frame")
executorpage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
executorpage.BackgroundTransparency = 1
executorpage.BorderColor = BrickColor.new("Really black")
executorpage.BorderColor3 = Color3.fromRGB(0, 0, 0)
executorpage.BorderSizePixel = 0
executorpage.Position = UDim2.new(0, 170, 0, 0)
executorpage.Size = UDim2.new(1, -170, 1, 0)
executorpage.Visible = false
executorpage.Name = "executorpage"

local codeframe = Instance.new("CanvasGroup")
codeframe.AnchorPoint = Vector2.new(0, 1)
codeframe.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
codeframe.BackgroundTransparency = 0.9
codeframe.BorderColor = BrickColor.new("Really black")
codeframe.BorderColor3 = Color3.fromRGB(0, 0, 0)
codeframe.BorderSizePixel = 0
codeframe.Position = UDim2.new(0.03, 0, 0.99, 0)
codeframe.Size = UDim2.new(0.95, 0, 0.8, 0)
codeframe.Name = "codeframe"

local UICorner_8 = Instance.new("UICorner")
UICorner_8.CornerRadius = UDim.new(0.02, 0)

local dots7 = Instance.new("ImageLabel")
dots7.Image = "rbxassetid://137720642301046"
--[[ Unsupported Type: Content For : ImageContent ]]
dots7.ImageTransparency = 0.9
dots7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dots7.BackgroundTransparency = 1
dots7.BorderColor = BrickColor.new("Really black")
dots7.BorderColor3 = Color3.fromRGB(0, 0, 0)
dots7.BorderSizePixel = 0
dots7.Size = UDim2.new(1, 0, 1, 0)
dots7.Name = "dots7"

local dots7g = Instance.new("UIGradient")
dots7g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
dots7g.Rotation = -23
dots7g.Name = "dots7g"

local scrl = Instance.new("ScrollingFrame")
scrl.AutomaticCanvasSize=Enum.AutomaticSize.Y
scrl.BottomImage = ""
--[[ Unsupported Type: Content For : BottomImageContent ]]
scrl.MidImage = "rbxassetid://110837370176178"
--[[ Unsupported Type: Content For : MidImageContent ]]
scrl.ScrollBarImageTransparency = 0.9
scrl.ScrollBarThickness = 5
scrl.ScrollingDirection = Enum.ScrollingDirection.Y
scrl.TopImage = ""
--[[ Unsupported Type: Content For : TopImageContent ]]
scrl.Active = true
scrl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scrl.BackgroundTransparency = 1
scrl.BorderColor = BrickColor.new("Really black")
scrl.BorderColor3 = Color3.fromRGB(0, 0, 0)
scrl.BorderSizePixel = 0
scrl.Size = UDim2.new(1, 0, 1, 0)
scrl.Name = "scrl"

local codebox = Instance.new("TextBox")
codebox.ClearTextOnFocus = false
codebox.FontFace = Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
codebox.MultiLine = true
codebox.RichText = true
codebox.Text = "print(\"Hello World\");"
codebox.TextColor = BrickColor.new("Institutional white")
codebox.TextColor3 = Color3.fromRGB(255, 255, 255)
codebox.TextSize = 14
codebox.TextXAlignment = Enum.TextXAlignment.Left
codebox.TextYAlignment = Enum.TextYAlignment.Top
codebox.AutomaticSize = Enum.AutomaticSize.Y
codebox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
codebox.BackgroundTransparency = 1
codebox.BorderColor = BrickColor.new("Really black")
codebox.BorderColor3 = Color3.fromRGB(0, 0, 0)
codebox.BorderSizePixel = 0
codebox.Size = UDim2.new(1,0,1,0)
codebox.Name = "codebox"

local runn = Instance.new("ImageButton")
runn.Image = "rbxassetid://110837370176178"
--[[ Unsupported Type: Content For : ImageContent ]]
runn.ImageTransparency = 0.65
runn.ScaleType = Enum.ScaleType.Crop
runn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
runn.BackgroundTransparency = 0.9
runn.BorderColor = BrickColor.new("Really black")
runn.BorderColor3 = Color3.fromRGB(0, 0, 0)
runn.BorderSizePixel = 0
runn.Position = UDim2.new(0.02, 0, 0.08, 0)
runn.Size = UDim2.new(0.21, 0, 0.07, 0)
runn.Name = "runn"

local UICorner_9 = Instance.new("UICorner")
UICorner_9.CornerRadius = UDim.new(0.35, 0)

local ImageLabel_4 = Instance.new("ImageLabel")
ImageLabel_4.Image = "rbxassetid://75568552142531"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel_4.ImageTransparency = 0.84
ImageLabel_4.ScaleType = Enum.ScaleType.Crop
ImageLabel_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_4.BackgroundTransparency = 1
ImageLabel_4.BorderColor = BrickColor.new("Really black")
ImageLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_4.BorderSizePixel = 0
ImageLabel_4.Size = UDim2.new(1, 0, 1, 0)

local UICorner_10 = Instance.new("UICorner")
UICorner_10.CornerRadius = UDim.new(0.35, 0)

local UIGradient_8 = Instance.new("UIGradient")
UIGradient_8.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
UIGradient_8.Rotation = -23

local dots5g = Instance.new("UIGradient")
dots5g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
dots5g.Rotation = -23
dots5g.Name = "dots5g"

local TextLabel_8 = Instance.new("TextLabel")
TextLabel_8.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
TextLabel_8.Text = "Execute"
TextLabel_8.TextColor = BrickColor.new("Institutional white")
TextLabel_8.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_8.TextScaled = true
TextLabel_8.TextSize = 11
TextLabel_8.TextTransparency = 0.2
TextLabel_8.TextWrapped = true
TextLabel_8.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_8.TextYAlignment = Enum.TextYAlignment.Bottom
TextLabel_8.AnchorPoint = Vector2.new(0, 0.5)
TextLabel_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_8.BackgroundTransparency = 1
TextLabel_8.BorderColor = BrickColor.new("Really black")
TextLabel_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_8.BorderSizePixel = 0
TextLabel_8.Position = UDim2.new(0.29, 0, 0.5, 0)
TextLabel_8.Size = UDim2.new(0.5, 0, 0.45, 0)

local ImageLabel_5 = Instance.new("ImageLabel")
ImageLabel_5.Image = "rbxassetid://125745849779868"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel_5.ImageTransparency = 0.3
ImageLabel_5.ScaleType = Enum.ScaleType.Fit
ImageLabel_5.AnchorPoint = Vector2.new(0, 0.5)
ImageLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_5.BackgroundTransparency = 1
ImageLabel_5.BorderColor = BrickColor.new("Really black")
ImageLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_5.BorderSizePixel = 0
ImageLabel_5.Position = UDim2.new(0.03, 0, 0.5, 0)
ImageLabel_5.Size = UDim2.new(0.2, 0, 0.7, 0)

local UIStroke_7 = Instance.new("UIStroke")
UIStroke_7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_7.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke_7.Color = Color3.fromRGB(255, 255, 255)
UIStroke_7.Transparency = 0.92

local clear = Instance.new("ImageButton")
clear.Image = "rbxassetid://110837370176178"
--[[ Unsupported Type: Content For : ImageContent ]]
clear.ImageTransparency = 0.65
clear.ScaleType = Enum.ScaleType.Crop
clear.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
clear.BackgroundTransparency = 0.9
clear.BorderColor = BrickColor.new("Really black")
clear.BorderColor3 = Color3.fromRGB(0, 0, 0)
clear.BorderSizePixel = 0
clear.Position = UDim2.new(0.24, 0, 0.08, 0)
clear.Size = UDim2.new(0.05, 0, 0.07, 0)
clear.Name = "clear"

local UICorner_11 = Instance.new("UICorner")
UICorner_11.CornerRadius = UDim.new(0.35, 0)

local ImageLabel_6 = Instance.new("ImageLabel")
ImageLabel_6.Image = "rbxassetid://104629784732670"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel_6.ImageTransparency = 0.9
ImageLabel_6.ScaleType = Enum.ScaleType.Crop
ImageLabel_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_6.BackgroundTransparency = 1
ImageLabel_6.BorderColor = BrickColor.new("Really black")
ImageLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_6.BorderSizePixel = 0
ImageLabel_6.Size = UDim2.new(1, 0, 1, 0)

local UICorner_12 = Instance.new("UICorner")
UICorner_12.CornerRadius = UDim.new(0.35, 0)

local UIGradient_9 = Instance.new("UIGradient")
UIGradient_9.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
UIGradient_9.Rotation = -23

local dots6g = Instance.new("UIGradient")
dots6g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
dots6g.Rotation = -23
dots6g.Name = "dots6g"

local ImageLabel_7 = Instance.new("ImageLabel")
ImageLabel_7.Image = "rbxassetid://102090142048216"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel_7.ImageTransparency = 0.4
ImageLabel_7.ScaleType = Enum.ScaleType.Fit
ImageLabel_7.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_7.BackgroundTransparency = 1
ImageLabel_7.BorderColor = BrickColor.new("Really black")
ImageLabel_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_7.BorderSizePixel = 0
ImageLabel_7.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel_7.Size = UDim2.new(0.7, 0, 0.7, 0)

local UIStroke_8 = Instance.new("UIStroke")
UIStroke_8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_8.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke_8.Color = Color3.fromRGB(255, 255, 255)
UIStroke_8.Transparency = 0.93

local save = Instance.new("ImageButton")
save.Image = "rbxassetid://110837370176178"
--[[ Unsupported Type: Content For : ImageContent ]]
save.ImageTransparency = 0.65
save.ScaleType = Enum.ScaleType.Crop
save.AnchorPoint = Vector2.new(1, 0)
save.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
save.BackgroundTransparency = 0.9
save.BorderColor = BrickColor.new("Really black")
save.BorderColor3 = Color3.fromRGB(0, 0, 0)
save.BorderSizePixel = 0
save.Position = UDim2.new(0.98, 0, 0.08, 0)
save.Size = UDim2.new(0.16, 0, 0.07, 0)
save.Name = "save"

local UICorner_13 = Instance.new("UICorner")
UICorner_13.CornerRadius = UDim.new(0.35, 0)

local ImageLabel_8 = Instance.new("ImageLabel")
ImageLabel_8.Image = "rbxassetid://75568552142531"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel_8.ImageTransparency = 0.9
ImageLabel_8.ScaleType = Enum.ScaleType.Crop
ImageLabel_8.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_8.BackgroundTransparency = 1
ImageLabel_8.BorderColor = BrickColor.new("Really black")
ImageLabel_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_8.BorderSizePixel = 0
ImageLabel_8.Size = UDim2.new(1, 0, 1, 0)

local UICorner_14 = Instance.new("UICorner")
UICorner_14.CornerRadius = UDim.new(0.35, 0)

local UIGradient_10 = Instance.new("UIGradient")
UIGradient_10.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
UIGradient_10.Rotation = -23

local dots7g_2 = Instance.new("UIGradient")
dots7g_2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))})
dots7g_2.Rotation = -23
dots7g_2.Name = "dots7g"

local TextLabel_9 = Instance.new("TextLabel")
TextLabel_9.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
TextLabel_9.Text = "Save"
TextLabel_9.TextColor = BrickColor.new("Institutional white")
TextLabel_9.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_9.TextScaled = true
TextLabel_9.TextSize = 11
TextLabel_9.TextTransparency = 0.2
TextLabel_9.TextWrapped = true
TextLabel_9.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_9.TextYAlignment = Enum.TextYAlignment.Bottom
TextLabel_9.AnchorPoint = Vector2.new(0, 0.5)
TextLabel_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_9.BackgroundTransparency = 1
TextLabel_9.BorderColor = BrickColor.new("Really black")
TextLabel_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_9.BorderSizePixel = 0
TextLabel_9.Position = UDim2.new(0.36, 0, 0.5, 0)
TextLabel_9.Size = UDim2.new(0.5, 0, 0.4, 0)

local ImageLabel_9 = Instance.new("ImageLabel")
ImageLabel_9.Image = "rbxassetid://113375548371322"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel_9.ImageTransparency = 0.3
ImageLabel_9.ScaleType = Enum.ScaleType.Fit
ImageLabel_9.AnchorPoint = Vector2.new(0, 0.5)
ImageLabel_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_9.BackgroundTransparency = 1
ImageLabel_9.BorderColor = BrickColor.new("Really black")
ImageLabel_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_9.BorderSizePixel = 0
ImageLabel_9.Position = UDim2.new(0.07, 0, 0.5, 0)
ImageLabel_9.Size = UDim2.new(0.2, 0, 0.55, 0)

local UIStroke_9 = Instance.new("UIStroke")
UIStroke_9.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_9.BorderStrokePosition = Enum.BorderStrokePosition.Inner
UIStroke_9.Color = Color3.fromRGB(255, 255, 255)
UIStroke_9.Transparency = 0.92

local scripthubpage = Instance.new("Frame")
scripthubpage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scripthubpage.BackgroundTransparency = 1
scripthubpage.BorderColor = BrickColor.new("Really black")
scripthubpage.BorderColor3 = Color3.fromRGB(0, 0, 0)
scripthubpage.BorderSizePixel = 0
scripthubpage.Position = UDim2.new(0, 170, 0, 0)
scripthubpage.Size = UDim2.new(1, -170, 1, 0)
scripthubpage.Visible = false
scripthubpage.Name = "scripthubpage"

local search = Instance.new("TextButton")
search.FontFace = Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
search.Text = "by temmie"
search.TextColor = BrickColor.new("Institutional white")
search.TextColor3 = Color3.fromRGB(255, 255, 255)
search.TextSize = 10
search.TextTransparency = 0.7
search.TextYAlignment = Enum.TextYAlignment.Bottom
search.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
search.BackgroundTransparency = 0.8
search.BorderColor = BrickColor.new("Really black")
search.BorderColor3 = Color3.fromRGB(0, 0, 0)
search.BorderSizePixel = 0
search.Position = UDim2.new(0.02, 0, 0.03, 0)
search.Size = UDim2.new(0.8, 0, 0.08, 0)
search.Transparency = 0.8
search.Name = "search"

local UICorner_15 = Instance.new("UICorner")
UICorner_15.CornerRadius = UDim.new(0.2, 0)

local searchhere = Instance.new("TextBox")
searchhere.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
searchhere.Text = "Search"
searchhere.TextColor = BrickColor.new("Institutional white")
searchhere.TextColor3 = Color3.fromRGB(255, 255, 255)
searchhere.TextScaled = true
searchhere.TextSize = 14
searchhere.TextTransparency = 0.2
searchhere.TextWrapped = true
searchhere.TextXAlignment = Enum.TextXAlignment.Left
searchhere.TextYAlignment = Enum.TextYAlignment.Top
searchhere.AnchorPoint = Vector2.new(0.5, 0.5)
searchhere.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
searchhere.BackgroundTransparency = 1
searchhere.BorderColor = BrickColor.new("Really black")
searchhere.BorderColor3 = Color3.fromRGB(0, 0, 0)
searchhere.BorderSizePixel = 0
searchhere.Position = UDim2.new(0.5, 0, 0.5, 0)
searchhere.Size = UDim2.new(0.94, 0, 0.4, 0)
searchhere.Name = "searchhere"

local ImageLabel_10 = Instance.new("ImageLabel")
ImageLabel_10.Image = "rbxassetid://11293977875"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel_10.ImageTransparency = 0.3
ImageLabel_10.ScaleType = Enum.ScaleType.Fit
ImageLabel_10.AnchorPoint = Vector2.new(1, 0.5)
ImageLabel_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_10.BackgroundTransparency = 1
ImageLabel_10.BorderColor = BrickColor.new("Really black")
ImageLabel_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_10.BorderSizePixel = 0
ImageLabel_10.Position = UDim2.new(1, 0, 0.5, 0)
ImageLabel_10.Size = UDim2.new(0.06, 0, 0.5, 0)

local saved = Instance.new("ImageButton")
saved.Image = "rbxassetid://110837370176178"
--[[ Unsupported Type: Content For : ImageContent ]]
saved.ImageTransparency = 0.96
saved.ScaleType = Enum.ScaleType.Crop
saved.AnchorPoint = Vector2.new(1, 0)
saved.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
saved.BackgroundTransparency = 0.8
saved.BorderColor = BrickColor.new("Really black")
saved.BorderColor3 = Color3.fromRGB(0, 0, 0)
saved.BorderSizePixel = 0
saved.Position = UDim2.new(1, 0, 0.04, 0)
saved.Size = UDim2.new(0.17, 0, 0.06, 0)
saved.Name = "saved"

local UICorner_16 = Instance.new("UICorner")
UICorner_16.CornerRadius = UDim.new(0.2, 0)

local ImageLabel_11 = Instance.new("ImageLabel")
ImageLabel_11.Image = "rbxassetid://11419703493"
--[[ Unsupported Type: Content For : ImageContent ]]
ImageLabel_11.ImageTransparency = 0.2
ImageLabel_11.ScaleType = Enum.ScaleType.Fit
ImageLabel_11.AnchorPoint = Vector2.new(0, 0.5)
ImageLabel_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_11.BackgroundTransparency = 1
ImageLabel_11.BorderColor = BrickColor.new("Really black")
ImageLabel_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_11.BorderSizePixel = 0
ImageLabel_11.Position = UDim2.new(0.05, 0, 0.5, 0)
ImageLabel_11.Size = UDim2.new(0.2, 0, 0.55, 0)

local TextLabel_10 = Instance.new("TextLabel")
TextLabel_10.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel_10.Text = "Saved Scripts"
TextLabel_10.TextColor = BrickColor.new("Institutional white")
TextLabel_10.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_10.TextScaled = true
TextLabel_10.TextSize = 14
TextLabel_10.TextTransparency = 0.1
TextLabel_10.TextWrapped = true
TextLabel_10.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_10.AnchorPoint = Vector2.new(0, 0.5)
TextLabel_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_10.BackgroundTransparency = 1
TextLabel_10.BorderColor = BrickColor.new("Really black")
TextLabel_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_10.BorderSizePixel = 0
TextLabel_10.Position = UDim2.new(0.27, 0, 0.5, 0)
TextLabel_10.Size = UDim2.new(0.65, 0, 0.4, 0)

local results = Instance.new("ScrollingFrame")
results.CanvasSize = UDim2.new(0, 0, 0, 0)
results.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
results.ScrollBarThickness = 0
results.ScrollingDirection = Enum.ScrollingDirection.Y
results.Active = true
results.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
results.BackgroundTransparency = 1
results.BorderColor = BrickColor.new("Really black")
results.BorderColor3 = Color3.fromRGB(0, 0, 0)
results.BorderSizePixel = 0
results.Position = UDim2.new(0.02, 0, 0.14, 0)
results.Size = UDim2.new(0.98, 0, 0.82, 0)
results.Name = "results"

local uil3 = Instance.new("UIListLayout")
uil3.SortOrder = Enum.SortOrder.LayoutOrder
uil3.Name = "uil3"

local savedscripts = Instance.new("ScrollingFrame")
savedscripts.CanvasSize = UDim2.new(0, 0, 0, 0)
savedscripts.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
savedscripts.ScrollBarThickness = 0
savedscripts.ScrollingDirection = Enum.ScrollingDirection.Y
savedscripts.Active = true
savedscripts.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
savedscripts.BackgroundTransparency = 1
savedscripts.BorderColor = BrickColor.new("Really black")
savedscripts.BorderColor3 = Color3.fromRGB(0, 0, 0)
savedscripts.BorderSizePixel = 0
savedscripts.Position = UDim2.new(0.44, 0, 0.14, 0)
savedscripts.Size = UDim2.new(0.98, 0, 0.82, 0)
savedscripts.Visible = false
savedscripts.Name = "savedscripts"

local uil4 = Instance.new("UIListLayout")
uil4.SortOrder = Enum.SortOrder.LayoutOrder
uil4.Name = "uil4"

local settingspage = Instance.new("Frame")
settingspage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
settingspage.BackgroundTransparency = 1
settingspage.BorderColor = BrickColor.new("Really black")
settingspage.BorderColor3 = Color3.fromRGB(0, 0, 0)
settingspage.BorderSizePixel = 0
settingspage.Position = UDim2.new(0, 170, 0, 0)
settingspage.Size = UDim2.new(1, -170, 1, 0)
settingspage.Visible = false
settingspage.Name = "settingspage"

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.BottomImage = ""
--[[ Unsupported Type: Content For : BottomImageContent ]]
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.MidImage = "rbxassetid://76466847613207"
--[[ Unsupported Type: Content For : MidImageContent ]]
ScrollingFrame.ScrollBarImageTransparency = 0.9
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingFrame.TopImage = ""
--[[ Unsupported Type: Content For : TopImageContent ]]
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderColor = BrickColor.new("Really black")
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0.03, 0, 0.03, 0)
ScrollingFrame.Size = UDim2.new(0.95, 0, 0.95, 0)

local UIListLayout_2 = Instance.new("UIListLayout")
UIListLayout_2.Padding = UDim.new(0.01, 0)
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

local Frame = Instance.new("Frame")
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.8
Frame.BorderColor = BrickColor.new("Really black")
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(1, -5, 0.2, 0)

local UICorner_17 = Instance.new("UICorner")
UICorner_17.CornerRadius = UDim.new(0.1, 0)

local logo2 = Instance.new("ImageLabel")
logo2.Image = "rbxassetid://79367513177680"
--[[ Unsupported Type: Content For : ImageContent ]]
logo2.ScaleType = Enum.ScaleType.Fit
logo2.AnchorPoint = Vector2.new(0, 0.5)
logo2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
logo2.BackgroundTransparency = 1
logo2.BorderColor = BrickColor.new("Really black")
logo2.BorderColor3 = Color3.fromRGB(0, 0, 0)
logo2.BorderSizePixel = 0
logo2.Position = UDim2.new(0.02, 0, 0.5, 0)
logo2.Size = UDim2.new(0.1, 0, 0.5, 0)
logo2.Name = "logo2"

local TextLabel_11 = Instance.new("TextLabel")
TextLabel_11.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_11.Text = "Developed by RileyBeeRBLX & GigaBacon"
TextLabel_11.TextColor = BrickColor.new("Institutional white")
TextLabel_11.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_11.TextScaled = true
TextLabel_11.TextSize = 14
TextLabel_11.TextWrapped = true
TextLabel_11.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_11.BackgroundTransparency = 1
TextLabel_11.BorderColor = BrickColor.new("Really black")
TextLabel_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_11.BorderSizePixel = 0
TextLabel_11.Position = UDim2.new(0.12, 0, 0.55, 0)
TextLabel_11.Size = UDim2.new(0.5, 0, 0.15, 0)

local TextLabel_12 = Instance.new("TextLabel")
TextLabel_12.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_12.Text = "Lumina 1.0"
TextLabel_12.TextColor = BrickColor.new("Institutional white")
TextLabel_12.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_12.TextScaled = true
TextLabel_12.TextSize = 14
TextLabel_12.TextWrapped = true
TextLabel_12.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_12.TextYAlignment = Enum.TextYAlignment.Bottom
TextLabel_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_12.BackgroundTransparency = 1
TextLabel_12.BorderColor = BrickColor.new("Really black")
TextLabel_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_12.BorderSizePixel = 0
TextLabel_12.Position = UDim2.new(0.12, 0, 0.25, 0)
TextLabel_12.Size = UDim2.new(0.5, 0, 0.26, 0)

local TextLabel_13 = Instance.new("TextLabel")
TextLabel_13.FontFace = Font.new("rbxassetid://12187375958", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel_13.Text = "ui by temmie  "
TextLabel_13.TextColor = BrickColor.new("Institutional white")
TextLabel_13.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_13.TextScaled = true
TextLabel_13.TextSize = 14
TextLabel_13.TextTransparency = 0.5
TextLabel_13.TextWrapped = true
TextLabel_13.TextXAlignment = Enum.TextXAlignment.Right
TextLabel_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_13.BackgroundTransparency = 1
TextLabel_13.BorderColor = BrickColor.new("Really black")
TextLabel_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_13.BorderSizePixel = 0
TextLabel_13.Position = UDim2.new(0.5, 0, 0.07, 0)
TextLabel_13.Size = UDim2.new(0.5, 0, 0.15, 0)

local open = Instance.new("ImageButton")
open.Image = "rbxassetid://79367513177680"
--[[ Unsupported Type: Content For : ImageContent ]]
open.AnchorPoint = Vector2.new(0.5, 0.5)
open.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
open.BackgroundTransparency = 1
open.BorderColor = BrickColor.new("Really black")
open.BorderColor3 = Color3.fromRGB(0, 0, 0)
open.BorderSizePixel = 0
open.Position = UDim2.new(0.5, 0, 0.2, 0)
open.Size = UDim2.new(0, 25, 0, 25)
open.Visible = false
open.Name = "open"

LuminaGui.Parent = game.CoreGui
sidebarframe.Parent = LuminaGui
sidebar.Parent = sidebarframe
tabs.Parent = sidebar
home.Parent = tabs
homei.Parent = home
TextLabel.Parent = home
tabglow.Parent = home
UICorner.Parent = tabglow
UIGradient.Parent = tabglow
UIListLayout.Parent = tabs
executor.Parent = tabs
executori.Parent = executor
TextLabel_2.Parent = executor
scripthub.Parent = tabs
scripthubi.Parent = scripthub
TextLabel_3.Parent = scripthub
settings.Parent = tabs
settingsi.Parent = settings
TextLabel_4.Parent = settings
logo.Parent = sidebar
close1.Parent = sidebar
close2.Parent = sidebar
title.Parent = sidebarframe
closelbl.Parent = sidebarframe
title_2.Parent = sidebarframe
background.Parent = LuminaGui
bg.Parent = background
glow.Parent = background
UIGradient_2.Parent = glow
glowf1.Parent = background
UIGradient_3.Parent = glowf1
glowf2.Parent = background
UIGradient_4.Parent = glowf2
glowf3.Parent = background
UIGradient_5.Parent = glowf3
homepage.Parent = LuminaGui
profile.Parent = homepage
UICorner_2.Parent = profile
dots.Parent = profile
dotg1.Parent = dots
ava.Parent = profile
UICorner_3.Parent = ava
Hello.Parent = profile
username.Parent = profile
UIStroke.Parent = profile
changelog.Parent = homepage
UICorner_4.Parent = changelog
dots2.Parent = changelog
dots2g.Parent = dots2
UIStroke_2.Parent = dots2
topbar.Parent = changelog
UIStroke_3.Parent = topbar
UIGradient_6.Parent = topbar
ImageLabel.Parent = topbar
TextLabel_5.Parent = topbar
scripts.Parent = homepage
UICorner_5.Parent = scripts
dots4.Parent = scripts
dots4g.Parent = dots4
UIStroke_4.Parent = dots4
topbar_2.Parent = scripts
UIStroke_5.Parent = topbar_2
UIGradient_7.Parent = topbar_2
ImageLabel_2.Parent = topbar_2
TextLabel_6.Parent = topbar_2
discord.Parent = homepage
UICorner_6.Parent = discord
dots3.Parent = discord
dots3g.Parent = dots3
UIStroke_6.Parent = dots3
ImageLabel_3.Parent = discord
UICorner_7.Parent = ImageLabel_3
ImageButton.Parent = discord
TextLabel_7.Parent = discord
executorpage.Parent = LuminaGui
codeframe.Parent = executorpage
UICorner_8.Parent = codeframe
dots7.Parent = codeframe
dots7g.Parent = dots7
scrl.Parent = codeframe
codebox.Parent = scrl
runn.Parent = executorpage
UICorner_9.Parent = runn
ImageLabel_4.Parent = runn
UICorner_10.Parent = ImageLabel_4
UIGradient_8.Parent = ImageLabel_4
dots5g.Parent = runn
TextLabel_8.Parent = runn
ImageLabel_5.Parent = runn
UIStroke_7.Parent = runn
clear.Parent = executorpage
UICorner_11.Parent = clear
ImageLabel_6.Parent = clear
UICorner_12.Parent = ImageLabel_6
UIGradient_9.Parent = ImageLabel_6
dots6g.Parent = clear
ImageLabel_7.Parent = clear
UIStroke_8.Parent = clear
save.Parent = executorpage
UICorner_13.Parent = save
ImageLabel_8.Parent = save
UICorner_14.Parent = ImageLabel_8
UIGradient_10.Parent = ImageLabel_8
dots7g_2.Parent = save
TextLabel_9.Parent = save
ImageLabel_9.Parent = save
UIStroke_9.Parent = save
scripthubpage.Parent = LuminaGui
search.Parent = scripthubpage
UICorner_15.Parent = search
searchhere.Parent = search
ImageLabel_10.Parent = search
saved.Parent = scripthubpage
UICorner_16.Parent = saved
ImageLabel_11.Parent = saved
TextLabel_10.Parent = saved
results.Parent = scripthubpage
uil3.Parent = results
savedscripts.Parent = scripthubpage
uil4.Parent = savedscripts
settingspage.Parent = LuminaGui
ScrollingFrame.Parent = settingspage
UIListLayout_2.Parent = ScrollingFrame
Frame.Parent = ScrollingFrame
UICorner_17.Parent = Frame
logo2.Parent = Frame
TextLabel_11.Parent = Frame
TextLabel_12.Parent = Frame
TextLabel_13.Parent = Frame
open.Parent = LuminaGui
ava.Image="https://www.roblox.com/headshot-thumbnail/image?userId="..game.Players.LocalPlayer.UserId.."&width=150&height=150&format=png"
ava.BackgroundTransparency=0.7
ava.BackgroundColor3=Color3.new(0, 0, 0)
username.Text=game.Players.LocalPlayer.DisplayName


-->> codeframe <<--
local ts=game:GetService("TweenService")
local expo=TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local p=UDim2.new
local o=Color3.new

sidebarframe.Visible=false
homepage.Visible=false
executorpage.Visible=false
scripthubpage.Visible=false
settingspage.Visible=false
bg.Transparency=1
glow.ImageTransparency=1
glowf1.ImageTransparency=1
glowf2.ImageTransparency=1
glowf3.ImageTransparency=1
open.Visible=true

--draggable "open"
do
    dragToggle = nil
    dragSpeed = 0.25
    dragInput = nil
    dragStart = nil
    dragPos = nil
    function updateInput(input)
        Delta = input.Position - dragStart
        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        game:GetService("TweenService"):Create(open, TweenInfo.new(0.20, Enum.EasingStyle.Back), {Position = Position}):Play()
    end
    open.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and game:GetService("UserInputService"):GetFocusedTextBox() == nil then
            dragToggle = true
            dragStart = input.Position
            startPos = open.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    open.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            updateInput(input)
        end
    end)
end
open.MouseEnter:Connect(function()
	ts:Create(open,expo,{Size=p(0,30,0,30)}):Play()
end)
open.MouseLeave:Connect(function()
	ts:Create(open,expo,{Size=p(0,25,0,25)}):Play()
end)
open.MouseButton1Up:Connect(function()
	ts:Create(open,expo,{Size=p(0,25,0,25)}):Play()
end)
open.MouseButton1Down:Connect(function()
	ts:Create(open,expo,{Size=p(0,30,0,30)}):Play()
end)

--sidebar minimize
logo.MouseButton1Click:Connect(function()
	if sidebarframe.Size==p(0,170,1,0)then
        ts:Create(tabglow,expo,{ImageTransparency=1,BackgroundTransparency=1}):Play()
		ts:Create(sidebarframe,expo,{Size=p(0,50,1)}):Play()
        ts:Create(homepage,expo,{Position=p(0,50),Size=p(1,-50,1)}):Play()
        ts:Create(executorpage,expo,{Position=p(0,50),Size=p(1,-50,1)}):Play()
        ts:Create(scripthubpage,expo,{Position=p(0,50),Size=p(1,-50,1)}):Play()
        ts:Create(settingspage,expo,{Position=p(0,50),Size=p(1,-50,1)}):Play()
		close2.Interactable=false
		task.wait(0.5)
		close2.Interactable=true
	elseif sidebarframe.Size==p(0,50,1,0)then
        ts:Create(tabglow,expo,{ImageTransparency=0.4,BackgroundTransparency=0.95}):Play()
		ts:Create(sidebarframe,expo,{Size=p(0,170,1)}):Play()
        ts:Create(homepage,expo,{Position=p(0,170),Size=p(1,-170,1)}):Play()
        ts:Create(executorpage,expo,{Position=p(0,170),Size=p(1,-170,1)}):Play()
        ts:Create(scripthubpage,expo,{Position=p(0,170),Size=p(1,-170,1)}):Play()
        ts:Create(settingspage,expo,{Position=p(0,170),Size=p(1,-170,1)}):Play()
		close2.Interactable=false
		task.wait(0.5)
		close2.Interactable=true
	end
end)
--pages(or windows)
local page='home'
local function switch(pagee)
	if pagee=='home' then
            tabglow.Parent=home
            page=pagee
            homepage.Visible=true
            executorpage.Visible=false
            scripthubpage.Visible=false
            settingspage.Visible=false

            profile.Position = UDim2.new(0.02, 0, 1.03, 0)
            changelog.Position = UDim2.new(0.02, 0, 1.2, 0)
            scripts.Position = UDim2.new(0.44, 0, 1.03, 0)
            discord.Position = UDim2.new(0.44, 0, 1.77, 0)

            ts:Create(profile,expo,{Position=p(0.02,0,0.03,0)}):Play()
            ts:Create(scripts,expo,{Position=p(0.44,0,0.03,0)}):Play()
            task.wait(0.1)
            ts:Create(changelog,expo,{Position=p(0.02,0,0.2,0)}):Play()
            ts:Create(discord,expo,{Position=p(0.44,0,0.77,0)}):Play()
    elseif pagee=='executor'then
            tabglow.Parent=executor
            page=pagee
            homepage.Visible=false
            executorpage.Visible=true
            scripthubpage.Visible=false
            settingspage.Visible=false

            runn.Position=p(0.02,0,1.08,0)
            clear.Position=p(0.24,0,1.08,0)
            save.Position=p(0.98,0,1.08,0)
            codeframe.Position=p(0.025,0,1.99)

            ts:Create(runn,expo,{Position=p(0.02,0,0.08,0)}):Play()
            ts:Create(clear,expo,{Position=p(0.24,0,0.08,0)}):Play()
            ts:Create(save,expo,{Position=p(0.98,0,0.08,0)}):Play()
            task.wait(0.1)
            ts:Create(codeframe,expo,{Position=p(0.025,0,0.99,0)}):Play()
    elseif pagee=='scripthub'then
            tabglow.Parent=scripthub
            page=pagee
            homepage.Visible=false
            executorpage.Visible=false
            scripthubpage.Visible=true
            settingspage.Visible=false

            search.Position=p(0.02,0,1.03,0)
            saved.Position=p(1,0,1.04)
            results.Position=p(0.02,0,1.14)
            savedscripts.Position=p(0.02,0,1.14)

			results.CanvasPosition=Vector2.new(0, 0)
			savedscripts.CanvasPosition=Vector2.new(0, 0)
			uil3.Padding=UDim.new(3, 0)
			ts:Create(uil3,expo,{Padding=UDim.new(0.01, 0)}):Play()
			uil4.Padding=UDim.new(3, 0)
			ts:Create(uil4,expo,{Padding=UDim.new(0.01, 0)}):Play()
            ts:Create(search,expo,{Position=p(0.02,0,0.03,0)}):Play()
            ts:Create(saved,expo,{Position=p(1,0,0.04,0)}):Play()
            task.wait(0.1)
            ts:Create(results,expo,{Position=p(0.02,0,0.14,0)}):Play()
            ts:Create(savedscripts,expo,{Position=p(0.02,0.1,0.14,0)}):Play()
        elseif pagee=='settings'then
            tabglow.Parent=settings
            page=pagee
            homepage.Visible=false
            executorpage.Visible=false
            scripthubpage.Visible=false
            settingspage.Visible=true

            ScrollingFrame.Position=p(0.03,0,1.03,0)
			UIListLayout_2.Padding=UDim.new(2, 0)
			
			ts:Create(UIListLayout_2,expo,{Padding=UDim.new(0.01, 0)}):Play()
            ts:Create(ScrollingFrame,expo,{Position=p(0.03,0,0.03,0)}):Play()
    end
end
home.MouseButton1Click:Connect(function()
    if page~='home'then
        switch('home')
    end
end)
executor.MouseButton1Click:Connect(function()
    if page~='executor'then
        switch('executor')
    end
end)
scripthub.MouseButton1Click:Connect(function()
    if page~='scripthub'then
        switch('scripthub')
    end
end)
settings.MouseButton1Click:Connect(function()
    if page~='settings'then
        switch('settings')
    end
end)


--open\close
open.MouseButton1Click:Connect(function()
	game.CoreGui.TopBarApp.TopBarApp.Enabled=false
	open.Interactable=false
	open.ImageTransparency=1
    sidebarframe.Position=p(0,-170,0,0)
    sidebarframe.Visible=true
    homepage.Position=p(0,sidebarframe.Size.X.Offset,0,0)
    executorpage.Position=p(0,sidebarframe.Size.X.Offset,0,0)
    scripthubpage.Position=p(0,sidebarframe.Size.X.Offset,0,0)
    settingspage.Position=p(0,sidebarframe.Size.X.Offset,0,0)

    do
        for i = 1, 14 do
            local p=Instance.new("Frame")
			p.Position=open.Position
			p.AnchorPoint=Vector2.new(0.5, 0.5)
            p.Parent = LuminaGui
            p.Size = UDim2.new(0,16,0,16)
            p.BackgroundTransparency = 0.1
            p.ZIndex = 10
			Instance.new("UICorner",p).CornerRadius=UDim.new(1)
            ts:Create(p, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.new(open.Position.X.Scale, open.Position.X.Offset + math.cos(math.rad(math.random(360)))*math.random(70,180), open.Position.Y.Scale, open.Position.Y.Offset + math.sin(math.rad(math.random(360)))*math.random(70,180)),
                Size = UDim2.new(0,0,0,0),
                Transparency = 1
            }):Play()
            task.delay(0.8, p.Destroy, p)
        end
		ts:Create(bg,expo,{Transparency=0.2}):Play()
		 ts:Create(glow,expo,{ImageTransparency=0.7}):Play()
		  ts:Create(glowf1,expo,{ImageTransparency=0.8}):Play()
           ts:Create(glowf2,expo,{ImageTransparency=0.8}):Play()
            ts:Create(glowf3,expo,{ImageTransparency=0.8}):Play()
             ts:Create(sidebarframe,expo,{Position=p(0)}):Play()
		if page=='home'or page=='executor'or page=='scripthub'or page=='settings'then
			switch(page)
		end
    end
end)
close2.MouseButton1Click:Connect(function()
   game.CoreGui.TopBarApp.TopBarApp.Enabled=true
    ts:Create(bg,expo,{Transparency=1}):Play()
   	 ts:Create(glow,expo,{ImageTransparency=1}):Play()
  	  ts:Create(glowf1,expo,{ImageTransparency=1}):Play()
  	   ts:Create(glowf2,expo,{ImageTransparency=1}):Play()
  	    ts:Create(glowf3,expo,{ImageTransparency=1}):Play()
    ts:Create(sidebarframe,expo,{Position=p(0,-sidebarframe.Size.X.Offset,0,0)}):Play()
     ts:Create(homepage,expo,{Position=p(0,homepage.Position.X.Offset,1,0)}):Play()
      ts:Create(executorpage,expo,{Position=p(0,executorpage.Position.X.Offset,1,0)}):Play()
       ts:Create(scripthubpage,expo,{Position=p(0,scripthubpage.Position.X.Offset,1,0)}):Play()
        ts:Create(settingspage,expo,{Position=p(0,settingspage.Position.X.Offset,1,0)}):Play()
   open.Size=p(0)
   open.ImageTransparency=0
	ts:Create(open,expo,{Size=p(0,25,0,25)}):Play()
   wait(0.5)
	open.Interactable=true
end)

-->> Script Cloud <<--
LOGOS = {
    scriptblox = "rbxassetid://117094404420446",
    wearedevs  = "rbxassetid://72207054198561",
    rscripts   = "rbxassetid://92995265754379"
}
function resscript(parent, data, logo, source)
    frame = Instance.new("Frame")
    frame.BackgroundColor3 = o(0,0,0)
    frame.BackgroundTransparency = 0.9
    frame.Size = p(1, 0, 0.17)
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0.15)
    img = Instance.new("ImageLabel", frame)
    img.Image = logo
    img.Size = p(0.1, 0, 0.7)
    img.Position = p(0.0125, 0, 0.5)
	img.AnchorPoint=Vector2.new(0, 0.5)
    img.BackgroundTransparency = 1
    img.ScaleType = Enum.ScaleType.Fit
	local imgc=Instance.new("UICorner",img)
	imgc.CornerRadius=UDim.new(0.2, 0)
    title = Instance.new("TextLabel", frame)
    title.Text = data.title or data.name or "Unknown"
    title.Size = p(0.5,0,0.5)
    title.Position = p(0.13, 0, 0.1)
    title.TextColor3 = o(1,1,1)
    title.TextScaled = true
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold)
    gameText = data.game
    if type(gameText) == "table" then
        gameText = gameText.name or gameText.title or tostring(gameText)
    elseif type(gameText) ~= "string" then
        gameText = nil
    end
    desc = Instance.new("TextLabel", frame)
    desc.Text = gameText or data.description or source
    desc.Size = p(0.6, 0, 0.3)
    desc.Position = p(0.13, 0, 0.63)
    desc.TextColor3 = o(0.7, 0.7, 0.7)
    desc.TextScaled = true
    desc.BackgroundTransparency = 1
    desc.TextXAlignment = Enum.TextXAlignment.Left
    copy = Instance.new("ImageButton", frame)
    copy.Size = p(0.1,0,0.45)
    copy.Position = p(0.81,0,0.5)
    copy.AnchorPoint = Vector2.new(0, 0.5)
    copy.ScaleType = Enum.ScaleType.Fit
    copy.Image = "rbxassetid://133545892825594"
    copy.BackgroundTransparency = 1
    run = Instance.new("ImageButton", frame)
    run.Size = p(0.1,0,0.5)
    run.Position = p(0.89,0,0.25)
    run.ScaleType = Enum.ScaleType.Fit
    run.Image = 'rbxassetid://108000369351911'
    run.BackgroundTransparency = 1
    copy.MouseButton1Click:Connect(function()
        if data.script or data.raw then setclipboard(data.script or data.raw) end
    end)
    run.MouseButton1Click:Connect(function()
        code = data.script or data.raw
        if code then loadstring(code)() end
    end)
end
function clearResults()
    for _, child in pairs(results:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
end
searchhere.FocusLost:Connect(function(enterPressed)
	results.CanvasPosition=Vector2.new(0, 0)
    if not enterPressed then return end
    clearResults()
    local query = searchhere.Text
    if query == "" then return end
    local HttpService = game:GetService("HttpService")
    local encoded = HttpService:UrlEncode(query)
    local completed = 0
    local function checkComplete()
        completed = completed + 1
        if completed >= 4 then
            local layout = results:FindFirstChildOfClass("UIListLayout")
            if layout then 
                results.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20) 
            end
        end
    end
    -- ScriptBlox
    task.spawn(function()
        local s, r = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://scriptblox.com/api/script/search?q=" .. encoded))
        end)
        if s and r and r.result and r.result.scripts then
            for _, script in ipairs(r.result.scripts) do
                resscript(results, {
                    title = script.title,
                    game = script.game,
                    script = script.script
                }, LOGOS.scriptblox, "ScriptBlox")
            end
        end
        checkComplete()
    end)
    -- WeAreDevs
    task.spawn(function()
        local s, r = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://wearedevs.net/api/scripts/search?s=" .. encoded))
        end)
        if s and r and r.scripts then
            for _, script in ipairs(r.scripts) do
                resscript(results, {
                    title = script.name,
                    description = script.description,
                    raw = 'loadstring(game:HttpGet("'..script.raw..'"))()'
                }, LOGOS.wearedevs, "WeAreDevs")
            end
        end
        checkComplete()
    end)
	-- Rscripts.net
	task.spawn(function()
		local s, r = pcall(function()
			local url = "https://rscripts.net/api/v2/scripts?page=1&orderBy=views&sort=desc&q=" .. encoded
			return HttpService:JSONDecode(game:HttpGet(url))
		end)
		if s and r and r.scripts then
			for _, script in ipairs(r.scripts) do
				local rawUrl = script.rawScript
				local finalCode
				if rawUrl and typeof(rawUrl) == "string" and rawUrl:match("^https?://") then
					finalCode = 'loadstring(game:HttpGet("' .. rawUrl .. '", true))()'
				end
				resscript(results, {
					title       = script.title or script.name or "no name",
					game        = script.game or {name = 'nil'},
					description = script.description or "",
					script      = finalCode,
					id          = script._id
				}, LOGOS.rscripts, "Rscripts")
			end
		end
		checkComplete()
	end)
end)
results.AutomaticCanvasSize=Enum.AutomaticSize.Y
uil3.Padding=UDim.new(0.01, 0)

savedscripts.AutomaticCanvasSize=Enum.AutomaticSize.Y
search.MouseButton1Click:Connect(function()
	searchhere:CaptureFocus()
end)
saved.MouseButton1Click:Connect(function()
    if results.Visible==true then
        results.Visible=false
        savedscripts.Visible=true
        results.Position=p(0.02,0,1.14,0)
        results.CanvasPosition=Vector2.new(0, 0)
        ts:Create(savedscripts,expo,{Position=p(0.02,0,0.14,0)}):Play()
        uil4.Padding=UDim.new(3, 0)
        ts:Create(uil4,expo,{Padding=UDim.new(0.01, 0)}):Play()
        ImageLabel_11.Image=scripthubi.image
        TextLabel_10.Text='Cloud Scripts'
    else
        results.Visible=true
        savedscripts.Visible=false
        results.Position=p(0.02,0,1.14,0)
        results.CanvasPosition=Vector2.new(0, 0)
        ts:Create(results,expo,{Position=p(0.02,0,0.14,0)}):Play()
        uil3.Padding=UDim.new(3, 0)
        ts:Create(uil3,expo,{Padding=UDim.new(0.01, 0)}):Play()
        ImageLabel_11.Image='rbxassetid://11419703493'
        TextLabel_10.Text='Saved Scripts'
    end
end)
--settings
local themes=Instance.new('Frame',ScrollingFrame)
themes.Size=p(1,0,0.2)
themes.BackgroundColor3=o(0,0,0)
themes.BackgroundTransparency=0.9
Instance.new("UICorner",themes).CornerRadius=UDim.new(0.1)
local title1=Instance.new('TextLabel',themes)
title1.Text='Themes'
title1.TextColor3=o(1,1,1)
title1.BackgroundTransparency=1
title1.Size=p(0.7,0,0.2)
title1.Position=p(0.05,0,0.15)
title1.TextScaled=true
title1.FontFace=Font.new("rbxassetid://12187365977",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
title1.TextXAlignment=Enum.TextXAlignment.Left
local themes2=Instance.new("Frame",themes)
themes2.Size=p(0.9,0,0.4)
themes2.Position=p(0.05,0,0.45)
themes2.Transparency=1
local uil5 = Instance.new('UIListLayout', themes2)
uil5.Padding = UDim.new(0.01)
uil5.FillDirection = Enum.FillDirection.Horizontal

local purple=Instance.new('TextButton',themes2)
purple.Transparency=0.2
purple.Size=p(0.1,0,1)
purple.BackgroundColor3=o(0.5,0,0.5)
purple.Text=''
Instance.new('UICorner',purple).CornerRadius=UDim.new(0.2)
local dark=Instance.new('TextButton',themes2)
dark.Transparency=0.2
dark.Size=p(0.1,0,1)
dark.BackgroundColor3=o(0.1,0.1,0.1)
dark.Text=''
Instance.new('UICorner',dark).CornerRadius=UDim.new(0.2)
local light=Instance.new('TextButton',themes2)
light.Transparency=0.2
light.Size=p(0.1,0,1)
light.BackgroundColor3=o(1,0.95,0.95)
light.Text=''
Instance.new('UICorner',light).CornerRadius=UDim.new(0.2)
local red=Instance.new('TextButton',themes2)
red.Transparency=0.2
red.Size=p(0.1,0,1)
red.BackgroundColor3=o(0.8,0.2,0)
red.Text=''
Instance.new('UICorner',red).CornerRadius=UDim.new(0.2)
local blue=Instance.new('TextButton',themes2)
blue.Transparency=0.2
blue.Size=p(0.1,0,1)
blue.BackgroundColor3=o(0,0.2,0.9)
blue.Text=''
Instance.new('UICorner',blue).CornerRadius=UDim.new(0.2)

local theme = "light"

--[[Universal Theme Changer Script By @papi.wf]]
local function switchtheme()
    local purple_gradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 42, 255))
    })
    local dark_gradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    })
    local light_gradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    local red_gradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 70))
    })
    local blue_gradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 150, 255))
    })
    local selected_gradient
    if theme == 'purple' then
        selected_gradient = purple_gradient
    elseif theme == 'dark' then
        selected_gradient = dark_gradient
    elseif theme == 'light' then
        selected_gradient = light_gradient
    elseif theme == 'red' then
        selected_gradient = red_gradient
    elseif theme == 'blue' then
        selected_gradient = blue_gradient
    end
    UIGradient.Color = selected_gradient
    UIGradient_2.Color = selected_gradient
    UIGradient_3.Color = selected_gradient
    UIGradient_4.Color = selected_gradient
    UIGradient_5.Color = selected_gradient
    UIGradient_6.Color = selected_gradient
    UIGradient_7.Color = selected_gradient
    UIGradient_8.Color = selected_gradient
    UIGradient_9.Color = selected_gradient
    UIGradient_10.Color = selected_gradient
    dotg1.Color = selected_gradient
    dots2g.Color = selected_gradient
    dots3g.Color = selected_gradient
    dots4g.Color = selected_gradient
    dots5g.Color = selected_gradient
    dots6g.Color = selected_gradient
    dots7g.Color = selected_gradient
    dots7g_2.Color = selected_gradient
	if glow.ImageTransparency~=1 then
		glow.ImageTransparency=0
		 glowf1.ImageTransparency=0
		  glowf2.ImageTransparency=0
		   glowf3.ImageTransparency=0
		ts:Create(glow,TweenInfo.new(1.2,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{ImageTransparency=0.8}):Play()
		 ts:Create(glowf1,TweenInfo.new(1.2,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{ImageTransparency=0.8}):Play()
		  ts:Create(glowf2,TweenInfo.new(1.2,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{ImageTransparency=0.8}):Play()
		   ts:Create(glowf3,TweenInfo.new(1.2,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{ImageTransparency=0.8}):Play()
	end
    local infinite = TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, true)
     ts:Create(UIGradient, infinite, {Rotation = UIGradient.Rotation + 360}):Play()
      ts:Create(UIGradient_2, infinite, {Rotation = UIGradient_2.Rotation + 360}):Play()
       ts:Create(UIGradient_3, infinite, {Rotation = UIGradient_3.Rotation + 360}):Play()
        ts:Create(UIGradient_4, infinite, {Rotation = UIGradient_4.Rotation + 360}):Play()
       ts:Create(UIGradient_5, infinite, {Rotation = UIGradient_5.Rotation + 360}):Play()
      ts:Create(UIGradient_8, infinite, {Rotation = UIGradient_8.Rotation + 360}):Play()
     ts:Create(UIGradient_9, infinite, {Rotation = UIGradient_9.Rotation + 360}):Play()
    ts:Create(UIGradient_10, infinite, {Rotation = UIGradient_10.Rotation + 360}):Play()
     ts:Create(dotg1, infinite, {Rotation = dotg1.Rotation + 360}):Play()
      ts:Create(dots2g, infinite, {Rotation = dots2g.Rotation + 360}):Play()
       ts:Create(dots3g, infinite, {Rotation = dots3g.Rotation + 360}):Play()
        ts:Create(dots4g, infinite, {Rotation = dots4g.Rotation + 360}):Play()
       ts:Create(dots5g, infinite, {Rotation = dots5g.Rotation + 360}):Play()
      ts:Create(dots6g, infinite, {Rotation = dots6g.Rotation + 360}):Play()
     ts:Create(dots7g, infinite, {Rotation = dots7g.Rotation + 360}):Play()
    ts:Create(dots7g_2, infinite, {Rotation = dots7g_2.Rotation + 360}):Play()
end
purple.MouseButton1Click:Connect(function()
    theme = 'purple'
    switchtheme()
    writefile('.luminagui//theme',theme)
end)
dark.MouseButton1Click:Connect(function()
    theme = 'dark'
    switchtheme()
    writefile('.luminagui//theme',theme)
end)
light.MouseButton1Click:Connect(function()
    theme = 'light'
    switchtheme()
    writefile('.luminagui//theme',theme)
end)
red.MouseButton1Click:Connect(function()
    theme = 'red'
    switchtheme()
    writefile('.luminagui//theme',theme)
end)
blue.MouseButton1Click:Connect(function()
    theme = 'blue'
    switchtheme()
    writefile('.luminagui//theme',theme)
end)
if not isfile('.luminagui//theme')then
    writefile('.luminagui//theme','light')
end

theme = readfile('.luminagui//theme')
switchtheme()

local function newtoggle(title,description,enabled,disabled,isenabled)
    local frame=Instance.new("Frame")
    frame.BackgroundColor3=o(0,0,0)
    frame.BackgroundTransparency=0.9
    frame.Size=p(1,-5,0.2)
    frame.Parent=ScrollingFrame
    Instance.new("UICorner",frame).CornerRadius=UDim.new(0.1)
    local text=Instance.new("TextLabel",frame)
    text.Text=title
    text.Size=p(0.7,0,0.2)
    text.Position=p(0.05,0,0.4)
    text.AnchorPoint=Vector2.new(0, 0.5)
    text.TextColor3=o(1,1,1)
    text.TextScaled=true
    text.BackgroundTransparency=1
    text.TextXAlignment=Enum.TextXAlignment.Left
    text.FontFace=Font.new("rbxassetid://12187365977",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
    local desc=Instance.new("TextLabel",frame)
    desc.Text=description
    desc.Size=p(0.7,0,0.17)
    desc.Position=p(0.05,0,0.6)
    desc.AnchorPoint=Vector2.new(0, 0.5)
    desc.TextColor3=o(0.7,0.7,0.7)
    desc.TextScaled=true
    desc.BackgroundTransparency=1
    desc.TextXAlignment=Enum.TextXAlignment.Left
    desc.FontFace=Font.new("rbxassetid://12187365977",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
    local toggle = Instance.new("TextButton",frame)
    toggle.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    toggle.Text = ""
    toggle.TextColor = BrickColor.new("Really black")
    toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
    toggle.TextSize = 14
    toggle.AnchorPoint = Vector2.new(1, 0.5)
    toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggle.BackgroundTransparency = 0.9
    toggle.BorderColor = BrickColor.new("Really black")
    toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    toggle.BorderSizePixel = 0
    toggle.Position = UDim2.new(0.95, 0, 0.5, 0)
    toggle.Size = UDim2.new(0.09, 0, 0.3, 0)
    toggle.Name = "toggle"
    Instance.new("UICorner",toggle).CornerRadius = UDim.new(1, 0)
    local circle = Instance.new("ImageLabel",toggle)
    circle.Image = "rbxassetid://138162908811780"
    circle.ScaleType = Enum.ScaleType.Fit
    circle.AnchorPoint = Vector2.new(0, 0.5)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BackgroundTransparency = 1
    circle.BorderColor = BrickColor.new("Really black")
    circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    circle.BorderSizePixel = 0
    circle.Position = UDim2.new(0, 0, 0.5, 0)
    circle.Size = UDim2.new(0.45, 0, 0.8, 0)
    circle.Transparency = 1
    circle.Name = "circle"
    toggle.MouseButton1Click:Connect(function()
        isenabled = not isenabled
        if isenabled then
            if enabled then enabled() end
            ts:Create(circle, expo, {Position = UDim2.new(1, 0, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5)}):Play()
        else
            if disabled then disabled() end
            ts:Create(circle, expo, {Position = UDim2.new(0, 0, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5)}):Play()
        end
    end)
    if isenabled then ts:Create(circle, expo, {Position = UDim2.new(1, 0, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5)}):Play() end
end
local function newtextbox(title, description, focuslost)
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = o(0, 0, 0)
    frame.BackgroundTransparency = 0.9
    frame.Size = p(1,-5,0.2)
    frame.Parent = ScrollingFrame
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0.1)
    local text = Instance.new("TextLabel", frame)
    text.Text = title
    text.Size = p(0.7, 0, 0.2)
    text.Position = p(0.05, 0, 0.4)
    text.AnchorPoint = Vector2.new(0, 0.5)
    text.TextColor3 = o(1, 1, 1)
    text.TextScaled = true
    text.BackgroundTransparency = 1
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    local desc = Instance.new("TextLabel", frame)
    desc.Text = description
    desc.Size = p(0.7, 0, 0.17)
    desc.Position = p(0.05, 0, 0.6)
    desc.AnchorPoint = Vector2.new(0, 0.5)
    desc.TextColor3 = o(0.7, 0.7, 0.7)
    desc.TextScaled = true
    desc.BackgroundTransparency = 1
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    local textbox = Instance.new("TextBox", frame)
    textbox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    textbox.Text = ""
    textbox.PlaceholderText = '  ...  '
    textbox.TextColor3 = o(1, 1, 1)
    textbox.TextScaled = true
    textbox.AnchorPoint = Vector2.new(1, 0.5)
    textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    textbox.BackgroundTransparency = 0.9
    textbox.BorderColor = BrickColor.new("Really black")
    textbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
    textbox.BorderSizePixel = 0
    textbox.Position = UDim2.new(0.95, 0, 0.5, 0)
    textbox.Size = UDim2.new(0.09, 0, 0.3, 0)
    textbox.Name = "textbox"
    Instance.new("UICorner", textbox).CornerRadius = UDim.new(1, 0)
    textbox.FocusLost:Connect(function(enterPressed)
        if not enterPressed then return end
        if focuslost then
            focuslost(textbox)
        end
    end)
end
local function newbutton(title, description, click)
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = o(0, 0, 0)
    frame.BackgroundTransparency = 0.9
    frame.Size = p(1, -5,0.2)
    frame.Parent = ScrollingFrame
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0.1)
    local text = Instance.new("TextLabel", frame)
    text.Text = title
    text.Size = p(0.7, 0, 0.2)
    text.Position = p(0.05, 0, 0.4)
    text.AnchorPoint = Vector2.new(0, 0.5)
    text.TextColor3 = o(1, 1, 1)
    text.TextScaled = true
    text.BackgroundTransparency = 1
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    local desc=Instance.new("TextLabel",frame)
    desc.Text=description
    desc.Size=p(0.7,0,0.17)
    desc.Position=p(0.05,0,0.6)
    desc.AnchorPoint=Vector2.new(0, 0.5)
    desc.TextColor3=o(0.7,0.7,0.7)
    desc.TextScaled=true
    desc.BackgroundTransparency=1
    desc.TextXAlignment=Enum.TextXAlignment.Left
    desc.FontFace=Font.new("rbxassetid://12187365977",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
    local button = Instance.new("TextButton",frame)
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    button.Text = "    Tap    "
    button.TextColor3 = o(1,1,1)
    button.TextScaled = true
    button.AnchorPoint = Vector2.new(1, 0.5)
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundTransparency = 0.9
    button.BorderColor = BrickColor.new("Really black")
    button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    button.BorderSizePixel = 0
    button.Position = UDim2.new(0.95, 0, 0.5, 0)
    button.Size = UDim2.new(0.09, 0, 0.3, 0)
    button.Name = "button"
    Instance.new("UICorner",button).CornerRadius = UDim.new(1, 0)
    button.MouseButton1Click:Connect(function()
        click()
    end)
end
local syntaxh=true
codebox.TextWrapped=false
local hl=Instance.new("TextButton",codebox)
hl.Size=p(1,0,1)
hl.BackgroundTransparency=1
hl.Text=codebox.Text
hl.RichText=true
hl.TextWrapped=true
hl.TextXAlignment=Enum.TextXAlignment.Left
hl.TextYAlignment=Enum.TextYAlignment.Top
hl.Name='Highlight'
hl.TextColor3=o(1,1,1)
local function h(src)
    local keywords = {
        ["local"] = "rgb(255,100,100)",
        ["function"] = "rgb(255,100,100)",
        ["end"] = "rgb(255,100,100)",
        ["if"] = "rgb(255,100,100)",
        ["then"] = "rgb(255,100,100)",
        ["else"] = "rgb(255,100,100)",
        ["for"] = "rgb(255,100,100)",
        ["while"] = "rgb(255,100,100)",
        ["do"] = "rgb(255,100,100)",
        ["return"] = "rgb(100,100,255)",
		["Enum"] = "rgb(100,100,255)"
    }
    src = src:gsub("<","&lt;"):gsub(">","&gt;")
    src = src:gsub("([\"'])(.-)%1", function(q,str)
        return string.format("<font color=\"rgb(255,155,100)\">%s%s%s</font>", q, str, q)
    end)
    src = src:gsub("%-%-[^\n]*", function(comment)
        return string.format("<font color=\"rgb(175,175,175)\">%s</font>", comment)
    end)
    for kw,color in pairs(keywords) do
        src = src:gsub("(%f[%a])"..kw.."(%f[%A])", 
            string.format("<font color=\"%s\">%s</font>", color, kw))
    end
    return src
end
hl.Text = h(codebox.Text)
hl.Visible=true
codebox.Visible=true
codebox.TextTransparency=1
hl.MouseButton1Click:Connect(function()
	hl.Visible=false
	codebox.TextTransparency=0
    wait(0.01)
	codebox:CaptureFocus()
end)
codebox.FocusLost:Connect(function()
	if syntaxh==true then
		codebox.TextTransparency=1
		hl.Visible=true
		hl.Text = h(codebox.Text)
	end
end)

if not isfolder('.luminagui')then
    makefolder('.luminagui')
end
if not isfile('.luminagui//fontsize')then
    writefile('.luminagui//fontsize','14')
end
if not isfile('.luminagui//syntaxhighlight')then
    writefile('.luminagui//syntaxhighlight','true')
end
if readfile('.luminagui//syntaxhighlight')=='true' then
    newtoggle('Syntax Highlight','Highlight code syntax for readability',function()
        syntaxh=true
        hl.Visible=true
        codebox.TextTransparency=1
        writefile('.luminagui//syntaxhighlight','true')
    end,function ()
        syntaxh=false
        hl.Visible=false
        codebox.TextTransparency=0
        writefile('.luminagui//syntaxhighlight','false')
    end,true)
else
	    syntaxh=false
        hl.Visible=false
        codebox.TextTransparency=0

        newtoggle('Syntax Highlight','Highlight code syntax for readability',function()
        syntaxh=true
        hl.Visible=true
        codebox.TextTransparency=1
        writefile('.luminagui//syntaxhighlight','true')
    end,function ()
        syntaxh=false
        hl.Visible=false
        codebox.TextTransparency=0
        writefile('.luminagui//syntaxhighlight','false')
    end,false)
end
newtextbox('Editor Font Size','Adjust editor font size easily (14)',function(textbox)
    codebox.TextSize=textbox.Text
    hl.TextSize=textbox.Text
	writefile('.luminagui//fontsize',textbox.Text)
end)
codebox.TextSize=readfile('.luminagui//fontsize')
hl.TextSize=readfile('.luminagui//fontsize')
hl.FontFace=codebox.FontFace
newtextbox('Set FPS Cap','Set maximum framerate for smoother gameplay (60)',function(textbox)
    setfpscap(tonumber(textbox.Text))
end)

newbutton("Developer Console",'Display warnings, errors, and info',function()
    game:GetService('StarterGui'):SetCore("DevConsoleVisible", true)
end)
newbutton('Rejoin Server','Quickly reconnect to your current server',function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,game.Players.LocalPlayer)
end)
local site=Instance.new('ImageButton',Frame)
site.Size=p(0.03,0,0.15)
site.Position=p(0.99,0,0.95)
site.ScaleType=Enum.ScaleType.Fit
site.Image='rbxassetid://98369329844510'
site.BackgroundTransparency=1
site.AnchorPoint=Vector2.new(1,1)
site.MouseButton1Click:Connect(function()
 game:GetService("GuiService"):BroadcastNotification('{"presentationStyle":2,"url":"https://getlumina.infinityfree.me","title":"LuminaGui","visible":true}', 20)
end)
local youtube=Instance.new('ImageButton',Frame)
youtube.Size=p(0.03,0,0.15)
youtube.Position=p(0.96,0,0.95)
youtube.ScaleType=Enum.ScaleType.Fit
youtube.Image='rbxassetid://12967528364'
youtube.BackgroundTransparency=1
youtube.ImageTransparency=0.2
youtube.AnchorPoint=Vector2.new(1,1)
youtube.MouseButton1Click:Connect(function()
 game:GetService("GuiService"):BroadcastNotification('{"presentationStyle":2,"url":"https://www.youtube.com/","title":"LuminaGui","visible":true}', 20)
end)

codebox.AutomaticSize=Enum.AutomaticSize.Y

-- homepage
local changelog2=Instance.new('ScrollingFrame',changelog)
changelog2.Size=p(0.9,0,0.8)
changelog2.Position=p(0.05,0,0.12)
changelog2.Transparency=1
changelog2.AutomaticCanvasSize=Enum.AutomaticSize.Y
changelog2.CanvasSize=UDim2.new(0,0,0,0)
changelog2.ScrollBarThickness=0
Instance.new('UIListLayout',changelog2).Padding=UDim.new(0.015)

local function newcl(txt)
    local txtt=Instance.new('TextLabel',changelog2)
    txtt.Text=txt
    txtt.Size=p(1,0,0.06)
    txtt.BackgroundTransparency=1
    txtt.TextTransparency=0.26
    txtt.TextScaled=true
    txtt.TextXAlignment=Enum.TextXAlignment.Left
    txtt.TextYAlignment=Enum.TextYAlignment.Top
    txtt.FontFace=Font.new("rbxassetid://12187365977",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
    txtt.TextColor3=o(1,1,1)
end


local recscripts=Instance.new('ScrollingFrame',scripts)
recscripts.Size=p(0.9,0,0.8)
recscripts.Position=p(0.05,0,0.12)
recscripts.Transparency=1
recscripts.AutomaticCanvasSize=Enum.AutomaticSize.Y
recscripts.CanvasSize=UDim2.new(0,0,0,0)
recscripts.ScrollBarThickness=0
Instance.new('UIListLayout',recscripts).Padding=UDim.new(0.02)
local function newsc(txt,srs)
    local txtt=Instance.new('TextLabel',recscripts)
    txtt.Text=txt
    txtt.Size=p(1,0,0.06)
    txtt.BackgroundTransparency=1
    txtt.TextScaled=true
    txtt.TextTransparency=0.26
    txtt.TextXAlignment=Enum.TextXAlignment.Left
    txtt.TextYAlignment=Enum.TextYAlignment.Top
    txtt.FontFace=Font.new("rbxassetid://12187365977",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
    txtt.TextColor3=o(1,1,1)
    local runsc=Instance.new('ImageButton',txtt)
    runsc.Size=p(0.1,0,1)
    runsc.Position=p(0.9,0,0)
    runsc.ScaleType=Enum.ScaleType.Fit
    runsc.Image='rbxassetid://108000369351911'
    runsc.BackgroundTransparency=1
    runsc.MouseButton1Click:Connect(function()
        loadstring(srs)()
    end)
end
ImageButton.MouseButton1Click:Connect(function ()
	setclipboard('https://discord.gg/9RaBWkyfyT')
	game:GetService("GuiService"):BroadcastNotification('{"presentationStyle":2,"url":"https://discord.gg/9RaBWkyfyT","title":"LuminaGui","visible":true}', 20)
end)

--Editor
local scriptname=Instance.new('Frame',save)
scriptname.Size=p(-1.5,0,0.6)
scriptname.Position=p(-0.05,0,0.2)
scriptname.BackgroundColor3=o(0,0,0)
scriptname.BackgroundTransparency=1
scriptname.Visible=false

local tbb=Instance.new('TextBox',scriptname)
tbb.Text=''
tbb.PlaceholderText='Script Name...'
tbb.TextColor3=o(1,1,1)
tbb.TextScaled=true
tbb.BackgroundTransparency=0.8
tbb.BackgroundColor3=o(0,0,0)
tbb.Size=p(1,0,1)

Instance.new('UICorner',tbb).CornerRadius=UDim.new(1,0)
runn.MouseButton1Click:Connect(function()
    loadstring(codebox.Text)()
end)
clear.MouseButton1Click:Connect(function()
    codebox.Text = ""
    hl.Text=''
    scrl.CanvasSize=UDim2.new(0,0,0,0)
end)
save.MouseButton1Click:Connect(function()
    scriptname.Visible=true
    tbb:CaptureFocus()
end)
tbb.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end
    if tbb.Text~='' then
        --save
    end
    scriptname.Visible=false
end)



--featured scripts
newsc('Infinite Yield',game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))
newsc('Nameless Admin',game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))
newsc('Dex Explorer',game:HttpGet('https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua'))

--changelogs
newcl('Current Changelogs (3/2026)')
newcl('+ Android Released!')
newcl('+ New Interface!')

--variables
local function loadenv() 
  loadstring(game:HttpGet("https://raw.githubusercontent.com/RileyDoesCode/Lumina/refs/heads/main/env.lua"))()
end
local function unc() 
  loadenv()
  loadstring(game:HttpGet("https://github.com/unified-naming-convention/NamingStandard/blob/main/UNCCheckEnv.lua?raw=true"))()
end
local function reload()
 loadstring(game:HttpGet("https://raw.githubusercontent.com/RileyDoesCode/Lumina/refs/heads/main/ui.lua"))()
end
local function getthreadidentity()
   return 3 
end
loadenv()
