---@class HandBooksPanel : HandBooksPanel_Generate
---##################### 【HandBooksPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HandBooksPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HandBooksPanel = require "HandBooksPanel_Generate"

function HandBooksPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
	}
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.nextPanelName = ""
end

function HandBooksPanel:setBooksButtonsInteractable(interactable)
    self.heroBooksBox.scaleButton.interactable = interactable
    self.weaponBooksBox.scaleButton.interactable = interactable
    self.equipBooksBox.scaleButton.interactable = interactable
    self.storyBooksBox.scaleButton.interactable = interactable
end

function HandBooksPanel:resetAnimatorToInit()
    self.animator:Play("init", 0, 0)
    self.animator:Update(0)
end

function HandBooksPanel:setupIntoAnimCallback()
    self.animOverCallBack:SetCallBackOfName(function(name)
        if name == "InNew" then
            self:onIntoAnimFinished()
        end
    end)
end

function HandBooksPanel:onIntoAnimFinished()
    self:setBooksButtonsInteractable(true)
    local panelName = self.nextPanelName
    self.nextPanelName = ""
    if panelName == "DockRolePanel" then
        UIMgr:popUI(panelName, { uiMode = 2 })
    elseif panelName ~= "" then
        UIMgr:popUI(panelName)
    end
end

function HandBooksPanel:onBooksBoxClick(panelName)
    if self.nextPanelName ~= "" then
        return
    end
    self:play2DSound(self.btnSoundPath)
    self:setNextPanel(panelName)
    self:setBooksButtonsInteractable(false)
    self:setupIntoAnimCallback()
    -- 直接 Play 从头播，避免 SetTrigger 在 Into 末态/安卓低帧下丢 Animation Event
    self.animator.enabled = true
    self.animator:Play("Into", 0, 0)
    self.animator:Update(0)
    -- Into.anim 在 0.5s 触发 InNew；安卓 AB 偶发丢事件，超时兜底进子界面
    self:DoAfter(0.65, function()
        if self.nextPanelName ~= "" then
            self:onIntoAnimFinished()
        end
    end)
end

--function HandBooksPanel:StartCreating(time)
--
--end

--function HandBooksPanel:StartEnter(time)
--
--end

--function HandBooksPanel:StartRemoving(time)
--
--end

--function HandBooksPanel:StartExit(time)
--
--end

function HandBooksPanel:OnOpen(data, initiative)
    self.nextPanelName = ""
    self:setBooksButtonsInteractable(true)
    self:resetAnimatorToInit()
    self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.Handbooks, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
        UIMgr:closeUI(self)
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)
    self:setupIntoAnimCallback()
end

function HandBooksPanel:OnRefresh(data)
    self.nextPanelName = ""
    self:setBooksButtonsInteractable(true)
    self:resetAnimatorToInit()
    self:setupIntoAnimCallback()
end

--function HandBooksPanel:OnClose(initiative)
--
--end

--function HandBooksPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

function HandBooksPanel:setNextPanel(panelName)
    self.nextPanelName = panelName
end

--[[
/BooksList/Viewport/Content/HeroBooksBox onClick 
--]]
function HandBooksPanel:heroBooksBox_ScaleButton_onClick(heroBooksBox)
    self:onBooksBoxClick("DockRolePanel")
end

--[[
/BooksList/Viewport/Content/WeaponBooksBox onClick 
--]]
function HandBooksPanel:weaponBooksBox_ScaleButton_onClick(weaponBooksBox)
    self:onBooksBoxClick("WeaponHandbookPanel")
end

--[[
/BooksList/Viewport/Content/EquipBooksBox onClick 
--]]
function HandBooksPanel:equipBooksBox_ScaleButton_onClick(equipBooksBox)
    self:onBooksBoxClick("EquipHandbookPanel")
end

--[[
/BooksList/Viewport/Content/StoryBooksBox onClick 
--]]
function HandBooksPanel:storyBooksBox_ScaleButton_onClick(storyBooksBox)
    self:onBooksBoxClick("StoryHandbookPanel")
end

return HandBooksPanel
