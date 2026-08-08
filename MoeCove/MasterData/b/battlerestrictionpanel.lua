---@class BattleRestrictionPanel : BattleRestrictionPanel_Generate
---##################### 【BattleRestrictionPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BattleRestrictionPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local BattleRestrictionPanel = require "BattleRestrictionPanel_Generate"

function BattleRestrictionPanel:InitLogic(data)

end

--function BattleRestrictionPanel:StartCreating(time)
--
--end

--function BattleRestrictionPanel:StartEnter(time)
--
--end

--function BattleRestrictionPanel:StartRemoving(time)
--
--end

--function BattleRestrictionPanel:StartExit(time)
--
--end

function BattleRestrictionPanel:OnOpen(data, initiative)
    if data ~= nil then
        self.closeFunc = data.closeFunc
    end
end

--function BattleRestrictionPanel:OnClose(initiative)
--
--end

--function BattleRestrictionPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function BattleRestrictionPanel:OnRefresh(data)
--
--end

--退出动画
function BattleRestrictionPanel:Out()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeUI(self)
        if self.closeFunc then
            self.closeFunc()
            self.closeFunc = nil
        end
    end)
end

--[[
/Mask onClick 
--]]
function BattleRestrictionPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:Out()
end

--[[
/BoxBg/CloseBtn onClick 
--]]
function BattleRestrictionPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:Out()
end

return BattleRestrictionPanel
