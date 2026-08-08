---@class EquipLevelPanel : EquipLevelPanel_Generate
---##################### 【EquipLevelPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【EquipLevelPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local EquipLevelPanel = require "EquipLevelPanel_Generate"

function EquipLevelPanel:InitLogic(data)
    self.data = {}  --{rank = 1, effectDesc = "xxx"}
end

--function EquipLevelPanel:StartCreating(time)
--
--end

--function EquipLevelPanel:StartEnter(time)
--
--end

--function EquipLevelPanel:StartRemoving(time)
--
--end

--function EquipLevelPanel:StartExit(time)
--
--end

function EquipLevelPanel:OnOpen(data, initiative)
    if initiative then
        self.data = data
        self:SetView()
    end
end

function EquipLevelPanel:SetView()
    local str = "特殊效果  "
    local romanNumerals = {"I", "II", "III", "IV", "V"}
    --显示阶级
    self.rankTxt.text.text = str..romanNumerals[self.data.rank]
    --显示效果描述文本
    self.msgTxt.text.text = self.data.effectDesc
end

--function EquipLevelPanel:OnClose(initiative)
--
--end

--function EquipLevelPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function EquipLevelPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function EquipLevelPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.mask.button.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.mask.button.interactable = true
        UIMgr:closeSpecificUI(self)
    end)
end

return EquipLevelPanel
