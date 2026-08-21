---@class OPMotionComicsPanle : OPMotionComicsPanle_Generate
---##################### 【OPMotionComicsPanle Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【OPMotionComicsPanle Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local OPMotionComicsPanle = require "OPMotionComicsPanle_Generate"
local Screen = UnityEngine.Screen
local ScreenOrientation = UnityEngine.ScreenOrientation
local DeviceOrientation = UnityEngine.DeviceOrientation

function OPMotionComicsPanle:InitLogic(data)
    self.clickNum = 0

    self.isPlay = false
end

function OPMotionComicsPanle:Update()
    if self.isPlay then
        if Input.deviceOrientation == DeviceOrientation.LandscapeRight then
            Screen.orientation = ScreenOrientation.LandscapeRight
        elseif Input.deviceOrientation == DeviceOrientation.LandscapeLeft then
            Screen.orientation = ScreenOrientation.LandscapeLeft
        end
    end
end

function OPMotionComicsPanle:InitPanel()

    self:LuaPlayBgm(Config.AudioPath.Main, true)

    self.animOverCallBack:SetCallBack(function()
        self:_CloseOPPanel()
    end)

    self.animOverCallBack:SetCallBackOfName(function(name)
        if name == "Scene7" then--结束动画
            self:_CloseOPPanel()
        end
    end)
end

function OPMotionComicsPanle:_CloseOPPanel()
    if self.callBack then
        self.callBack()
    end
    self.isPlay = false
    Screen.orientation = ScreenOrientation.Portrait
    UIMgr.uiCanvas.gameObject:GetComponent("CanvasScaler").matchWidthOrHeight = 0

    --结束后打开异性屏适配
    local adjustValue = UnityEngine.PlayerPrefs.GetFloat("ScreenAdjustValue")
    AutoAdjustCanvasRoot.Inst:SetPercent(adjustValue or 0)
    AutoAdjustCanvasRoot.Inst:SetVerticalPadding()

    UIMgr:closeUI(self)
end

--function OPMotionComicsPanle:StartCreating(time)
--
--end

--function OPMotionComicsPanle:StartEnter(time)
--
--end

--function OPMotionComicsPanle:StartRemoving(time)
--
--end

--function OPMotionComicsPanle:StartExit(time)
--
--end

function OPMotionComicsPanle:OnOpen(data, initiative)
    if initiative then
        self.callBack = data and data.callBack
        self:InitPanel()

        Screen.orientation = ScreenOrientation.LandscapeRight
        UIMgr.uiCanvas.gameObject:GetComponent("CanvasScaler").matchWidthOrHeight = 0.45

        --暂时关闭异性屏适配
        AutoAdjustCanvasRoot.Inst:SetPercent(0)
        AutoAdjustCanvasRoot.Inst:SetVerticalPadding()

        self.isPlay = true
    end
end

--function OPMotionComicsPanle:OnClose(initiative)
--
--end

--function OPMotionComicsPanle:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function OPMotionComicsPanle:OnRefresh(data)
--
--end

--[[
/ClickBtn onClick 
--]]
function OPMotionComicsPanle:clickBtn_Button_onClick(clickBtn)
    self.clickNum = self.clickNum + 1
    if self.clickNum == 2 then
        self:_CloseOPPanel()
    end
end

return OPMotionComicsPanle
