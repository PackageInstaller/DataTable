---@class SevenRewardPanel : SevenRewardPanel_Generate
---##################### 【SevenRewardPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SevenRewardPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SevenRewardPanel = require "SevenRewardPanel_Generate"

function SevenRewardPanel:InitLogic(data)

end

--function SevenRewardPanel:StartCreating(time)
--
--end

--function SevenRewardPanel:StartEnter(time)
--
--end

--function SevenRewardPanel:StartRemoving(time)
--
--end

--function SevenRewardPanel:StartExit(time)
--
--end

function SevenRewardPanel:OnOpen(data, initiative)
    local rewardList = data.rewardList or {}
    local pointTxt = data.pointTxt or 0

    self.msgTxt.text.text = string.format("积分达到<color=#1881d7>%s</color>后，可以获得以下奖励:", pointTxt)
    self:FillTemplateContent(self.customBox, self.rewardList, tablex.size(rewardList), function(index, customBox)
        local customBox = customBox.customBox
        customBox:setMono(self)
        customBox:SetUIData(rewardList[index], {navType = GE.NavigationType.TaskPanel, tipsPassEventState = false})
    end)
end

--function SevenRewardPanel:OnClose(initiativse)
--
--end

--function SevenRewardPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SevenRewardPanel:OnRefresh(data)
--
--end

--[[
/Bg onClick 
--]]
function SevenRewardPanel:mask_Button_onClick(bg)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    self:playCloseAnim()
end

--[[
/Main/Bg/CloseBtn onClick 
--]]
function SevenRewardPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    self:playCloseAnim()
end

--[[
/Main/OkBtn onClick 
--]]
function SevenRewardPanel:okBtn_ScaleButton_onClick(okBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    self:playCloseAnim()
end

--[[
/Main/CancelBtn onClick 
--]]
function SevenRewardPanel:cancelBtn_ScaleButton_onClick(cancelBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    self:playCloseAnim()
end

function SevenRewardPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

return SevenRewardPanel
