---@class PosterAdjustPanel : PosterAdjustPanel_Generate
---##################### 【PosterAdjustPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【PosterAdjustPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local PosterAdjustPanel = require "PosterAdjustPanel_Generate"

function PosterAdjustPanel:InitLogic(data)
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.skinId = nil
    self.posterData = {}
end

--function PosterAdjustPanel:StartCreating(time)
--
--end

--function PosterAdjustPanel:StartEnter(time)
--
--end

--function PosterAdjustPanel:StartRemoving(time)
--
--end

--function PosterAdjustPanel:StartExit(time)
--
--end

function PosterAdjustPanel:OnOpen(data, initiative)
    self.skinId = data.skinId
    self:SetView()
end

function PosterAdjustPanel:SetView()
    self.MainPanel = UIMgr:getUIData("MainPanel")
    self.sizeSlider.slider.value = ClientData:GetPosterData().Size   --TODO: 存的大小
end

--function PosterAdjustPanel:OnClose(initiative)
--
--end

--function PosterAdjustPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function PosterAdjustPanel:OnRefresh(data)
--
--end

--[[
/RoleListBg/ResetBtn onClick 
--]]
function PosterAdjustPanel:resetBtn_ScaleButton_onClick(resetBtn)
    self:play2DSound(self.btnSoundPath)
    self.MainPanel.ui:ResetPosterPos()
    self.sizeSlider.slider.value = 1
end

--[[
/RoleListBg/OkBtn onClick 
--]]
function PosterAdjustPanel:okBtn_ScaleButton_onClick(okBtn)
    self:play2DSound(self.btnSoundPath)
    local data = self.MainPanel.ui:GetPosterPosData()
    local temp = {
        PosX = data.x,
        PosY = data.y,
        Size = data.size
    }
    Me:setPosterPosReq({PosX = temp.PosX, PosY = temp.PosY, Size = temp.Size}, function()
        --GameMsgMgr:sendEvent(GameMsgType.RefreshPoster)
        self.MainPanel.ui:CloseRoleChangeMode()
        self.MainPanel.ui:PosterPanelMode(false)
        self.MainPanel.ui:ResetDialogBoxPosition()
        self.animator:SetTrigger("Out")
        UIMgr:closeSpecificUI("PosterAdjustPanel")
        UIMgr:closeUI("PosterPanel")
        --UIMgr:clearAllUI()
        --UIMgr:popUI("MainPanel")
    end)
end

--[[
/RoleListBg/CancelBtn onClick 
--]]
function PosterAdjustPanel:cancelBtn_ScaleButton_onClick(cancelBtn)
    self:play2DSound(self.btnSoundPath)
    local PosterPanel = UIMgr:getUIData("PosterPanel")
    if PosterPanel then
        UIMgr:showUI("PosterPanel")
    end
    self.MainPanel.ui:CloseRoleChangeMode()
    self.MainPanel.ui:PosterPanelMode(true)
    self.cancelBtn.scaleButton.interactable = false
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        self.cancelBtn.scaleButton.interactable = true
        UIMgr:closeUI(self)
    end)
    GameMsgMgr:sendEvent(GameMsgType.RefreshPoster)
end

--[[
/RoleListBg/SizeSlider onValueChanged 
--]]
function PosterAdjustPanel:sizeSlider_Slider_onValueChanged(sizeSlider,value)
    self.MainPanel.ui:SetPosterSize(value)
end

return PosterAdjustPanel
