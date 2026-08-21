---@class SceneSettingPanel : SceneSettingPanel_Generate
---##################### 【SceneSettingPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SceneSettingPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SceneSettingPanel = require "SceneSettingPanel_Generate"

local scaleCfg = {144, 24, 2, 1}

function SceneSettingPanel:InitLogic(data)

    --通用DOTween动画时间
    self.commonFadeTime = 0.5
    self.breakEvent = false

end

--function SceneSettingPanel:StartCreating(time)
--
--end

--function SceneSettingPanel:StartEnter(time)
--
--end

--function SceneSettingPanel:StartRemoving(time)
--
--end

--function SceneSettingPanel:StartExit(time)
--
--end

function SceneSettingPanel:OnOpen(data, initiative)
    local timeOpenType = CoveManager.instance():GetTimeOpenType()
    local dayTimeType = CoveManager.instance():GetDayTimeType()
    local timeSpeed = CoveManager.instance():GetTimeSpeed()
    local defaultScene = CoveManager.instance():GetDefaultSceneType(true)

    dayTimeType = dayTimeType == 0 and 1 or dayTimeType
    timeSpeed = timeSpeed == 0 and 1 or timeSpeed

    self.breakEvent = true
    local btn = timeOpenType == 1 and self.timeOpenOn or self.timeOpenOff
    self:SetMainVolumeBtnFunc(btn, timeOpenType)

    local timeTypeToggle = self["timeType_" .. dayTimeType]
    if timeTypeToggle ~= nil then
        timeTypeToggle.toggle.isOn = true
    end
    

    local timeScaleType = #scaleCfg
    timeScaleType = tablex.indexof(scaleCfg, timeSpeed)
    if timeScaleType == nil or timeScaleType == -1 then
        timeScaleType = #scaleCfg
    end
    
    local timeScaleToggle = self["timeScaleType_" .. timeScaleType]
    if timeScaleToggle ~= nil then
        timeScaleToggle.toggle.isOn = true
    end

    -- 设置默认场景
    local targetSceneType = self["defaultSceneType_" .. defaultScene]
    if targetSceneType ~= nil then
        targetSceneType.toggle.isOn = true
    end

    self.breakEvent = false
end

--function SceneSettingPanel:OnClose(initiative)
--
--end

--function SceneSettingPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SceneSettingPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function SceneSettingPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

--[[
/contentPanel/TitleBg/EnemyCloseBtn onClick 
--]]
function SceneSettingPanel:enemyCloseBtn_ScaleButton_onClick(enemyCloseBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

--[[
/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenOn onClick 
--]]
function SceneSettingPanel:timeOpenOn_Button_onClick(timeOpenOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetMainVolumeBtnFunc(timeOpenOn, 1)
end

--[[
/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenOff onClick 
--]]
function SceneSettingPanel:timeOpenOff_Button_onClick(timeOpenOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetMainVolumeBtnFunc(timeOpenOff, 2)
end

--[[
/contentPanel/itemPanel/menuItem_2/TimeTypePanel/timeType_1 onValueChanged 
--]]
function SceneSettingPanel:timeType_1_Toggle_onValueChanged(timeType_1,isOn)
    if not isOn then
        return
    end
    if self.breakEvent then
        return
    end
    self:SetDayTimeType(1)
end

--[[
/contentPanel/itemPanel/menuItem_2/TimeTypePanel/timeType_2 onValueChanged 
--]]
function SceneSettingPanel:timeType_2_Toggle_onValueChanged(timeType_2,isOn)
    if not isOn then
        return
    end
    if self.breakEvent then
        return
    end
    self:SetDayTimeType(2)
end

--[[
/contentPanel/itemPanel/menuItem_2/TimeTypePanel/timeType_3 onValueChanged 
--]]
function SceneSettingPanel:timeType_3_Toggle_onValueChanged(timeType_3,isOn)
    if not isOn then
        return
    end
    if self.breakEvent then
        return
    end
    self:SetDayTimeType(3)
end

--[[
/contentPanel/itemPanel/menuItem_4/rectifyBtn onClick 
--]]
function SceneSettingPanel:rectifyBtn_ScaleButton_onClick(rectifyBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local coveManager = CoveManager.instance()
    local curTime = coveManager:RectifySceneTime()
    if coveManager:GetTimeOpenType() ~= 1 then
        local type = coveManager:CurTimeToType(curTime)
        self.breakEvent = true
        local timeTypeToggle = self["timeType_" .. type]
        if timeTypeToggle ~= nil then
            timeTypeToggle.toggle.isOn = true
        end
        coveManager:SetDayTimeType(type)
        self.breakEvent = false
    end
end

function SceneSettingPanel:SetDayTimeType(index)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    -- 设置对应时间的场景配置
    CoveManager.instance():SetDayTimeType(index)
end

---设置时间流逝
---@param btnObj UnityEngine.GameObject 目标位置btn
---@param val integer 1开始 2关闭
function SceneSettingPanel:SetMainVolumeBtnFunc(btnObj, val)
    self.timeOpenState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = val == 1
    self.timeOpenState.offText.canvasGroup:DOFade(val - 1, self.commonFadeTime)
    self.timeOpenState.onText.canvasGroup:DOFade(2 - val, self.commonFadeTime)

    self.dayTimeTypePanel.gameObject:SetActive(not isOn)
    self.dayTimeDisableBtn.gameObject:SetActive(isOn)
    self.timeScaleTypePanel.gameObject:SetActive(isOn)
    self.timeScaleDisableBtn.gameObject:SetActive(not isOn)

    CoveManager.instance():SetTimeOpenType(val)
end

--[[
/contentPanel/itemPanel/menuItem_2/dayTimeDisableBtn onClick 
--]]
function SceneSettingPanel:dayTimeDisableBtn_ScaleButton_onClick(dayTimeDisableBtn)

end

--[[
/contentPanel/itemPanel/menuItem_3/timeScaleDisableBtn onClick 
--]]
function SceneSettingPanel:timeScaleDisableBtn_ScaleButton_onClick(timeScaleDisableBtn)

end

--[[
/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_1 onValueChanged 
--]]
function SceneSettingPanel:timeScaleType_1_Toggle_onValueChanged(timeScaleType_1,isOn)
     if not isOn then
        return
    end
    if self.breakEvent then
        return
    end
    self:SetTimeScale(scaleCfg[1])
end

--[[
/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_2 onValueChanged 
--]]
function SceneSettingPanel:timeScaleType_2_Toggle_onValueChanged(timeScaleType_2,isOn)
 if not isOn then
        return
    end
    if self.breakEvent then
        return
    end
    self:SetTimeScale(scaleCfg[2])
end

--[[
/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_3 onValueChanged 
--]]
function SceneSettingPanel:timeScaleType_3_Toggle_onValueChanged(timeScaleType_3,isOn)
 if not isOn then
        return
    end
    if self.breakEvent then
        return
    end
    self:SetTimeScale(scaleCfg[3])
end

--[[
/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_4 onValueChanged 
--]]
function SceneSettingPanel:timeScaleType_4_Toggle_onValueChanged(timeScaleType_4,isOn)
     if not isOn then
        return
    end
    if self.breakEvent then
        return
    end
    self:SetTimeScale(scaleCfg[4])
end

function SceneSettingPanel:SetTimeScale(value)
    --TODO
    CoveManager.instance():SetTimeSpeed(value)
end

--设置进入游戏默认显示场景
function SceneSettingPanel:SetDefaultSceneType(value)
    --TODO
    CoveManager.instance():SetDefaultSceneType(value)
end

function SceneSettingPanel:a()
    local scaleCfg = {144, 24, 12, 1}
end

--[[    指挥室
/contentPanel/itemPanel/menuItem_5/defaultSceneToggleGroup/defaultSceneType_1 onValueChanged 
--]]
function SceneSettingPanel:defaultSceneType_1_Toggle_onValueChanged(defaultSceneType_1,isOn)
    self:SetDefaultSceneType(1)
end

--[[    家园
/contentPanel/itemPanel/menuItem_5/defaultSceneToggleGroup/defaultSceneType_2 onValueChanged 
--]]
function SceneSettingPanel:defaultSceneType_2_Toggle_onValueChanged(defaultSceneType_2,isOn)
    self:SetDefaultSceneType(2)
end

--界面关闭
function SceneSettingPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

return SceneSettingPanel
