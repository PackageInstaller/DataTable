---@class QuestionWebViewPanel : QuestionWebViewPanel_Generate
---##################### 【QuestionWebViewPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【QuestionWebViewPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local QuestionWebViewPanel = require "QuestionWebViewPanel_Generate"

local Screen = UnityEngine.Screen
local Rect = UnityEngine.Rect
local ScreenOrientation = UnityEngine.ScreenOrientation
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

function QuestionWebViewPanel:InitLogic(data)

end

--function QuestionWebViewPanel:StartCreating(time)
--
--end

--function QuestionWebViewPanel:StartEnter(time)
--
--end

--function QuestionWebViewPanel:StartRemoving(time)
--
--end

--function QuestionWebViewPanel:StartExit(time)
--
--end

function QuestionWebViewPanel:OnOpen(data, initiative)
    self.webUrl = data.url

    LuaLogger.ds("self.webUrl 12 ====", self.webUrl)

    -- 屏蔽系统/WebView 默认返回：禁止 WebView 内部响应返回键，避免直接导致网页后退或异常
    self.webArea.uniWebView:SetBackButtonEnabled(false)
    self.webArea.uniWebView.OnShouldClose = self.webArea.uniWebView.OnShouldClose + function(_)
        return false
    end

    local startFunc = function()
        self:SetupPortraitView()
    end
    self.webArea.uniWebView.OnPageFinished = self.webArea.uniWebView.OnPageFinished + startFunc
    local startPageFunc = function()
        Screen.orientation = ScreenOrientation.Portrait
    end
    self.webArea.uniWebView.OnPageStarted = self.webArea.uniWebView.OnPageStarted + startPageFunc

    self.webArea.uniWebView:Load(self.webUrl)
end

function QuestionWebViewPanel:SetupPortraitView()
     if self.webArea.uniWebView == nil then return end
    -- --Screen.orientation = ScreenOrientation.Portrait
    -- --获取屏幕的宽和高
    -- local screenWidth = Screen.width
    -- local screenHeight = Screen.height

    
    -- --目标：让网页以竖屏显示在横屏游戏中。
    -- --逻辑：将WebView旋转90度，并使其居中显示。

    -- --关键步骤1：将WebView的宽高设置为屏幕的【高】和【宽】，
    -- --因为旋转90度后，原来的“宽度”会变成“高度”。
    -- local portraitWidth = screenHeight  -- 竖屏宽度 = 屏幕高度
    -- local portraitHeight = screenWidth  -- 竖屏高度 = 屏幕宽度

    -- -- 关键步骤2：计算旋转后WebView的位置，使其居中。
    -- -- 因为旋转是绕中心点进行的，所以需要调整位置补偿旋转带来的偏移。
    -- local posX = (screenWidth - portraitWidth) / 2
    -- local posY = (screenHeight - portraitHeight) / 2

    -- --设置WebView的显示区域
    -- self.webArea.uniWebView.Frame = Rect.New(posX, posY, portraitWidth, portraitHeight)

    -- -- 关键步骤3：进行90度旋转
    -- -- 首先将WebView的锚点设置到中心（这样旋转才不会错位）
    -- self.webArea.uniWebView.transform.position = Vector3.New(screenWidth / 2, screenHeight / 2, 0)
    -- -- 然后绕Z轴旋转90度（注意：Unity是左手系，旋转方向可能需要调整）
    -- self.webArea.uniWebView.transform.rotation = Quaternion.Euler(0, 0, 90)
    -- 最后显示WebView
    self.webArea.uniWebView:Show()

end

-- 每帧检测手机返回键（Android 为 KeyCode.Escape），由本界面统一处理，避免系统默认行为影响网页
function QuestionWebViewPanel:Update()
    if Input.GetKeyDown(KeyCode.Escape) then
        self:DoCloseWebView()
    end
end

--- 统一关闭 WebView 并关界面（供关闭按钮与返回键调用）
function QuestionWebViewPanel:DoCloseWebView()
    if self.webArea and self.webArea.uniWebView then
        self.webArea.uniWebView:Hide()
    end
    Screen.orientation = ScreenOrientation.LandscapeLeft
    UIMgr:closeCurrentUI(self)
end

--function QuestionWebViewPanel:OnClose(initiative)
--
--end

--function QuestionWebViewPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function QuestionWebViewPanel:OnRefresh(data)
--
--end

--[[
/maskImg onClick 
--]]
function QuestionWebViewPanel:maskImg_Button_onClick(maskImg)

end

--[[
/closeWebBtn onClick 
--]]
function QuestionWebViewPanel:closeWebBtn_ScaleButton_onClick(closeWebBtn)
    self:DoCloseWebView()
end

return QuestionWebViewPanel
