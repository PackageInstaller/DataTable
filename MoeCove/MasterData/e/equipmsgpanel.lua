---@class EquipMsgPanel : EquipMsgPanel_Generate
---##################### 【EquipMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【EquipMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local EquipMsgPanel = require "EquipMsgPanel_Generate"

function EquipMsgPanel:InitLogic(data)

end

--function EquipMsgPanel:StartCreating(time)
--
--end

--function EquipMsgPanel:StartEnter(time)
--
--end

--function EquipMsgPanel:StartRemoving(time)
--
--end

--function EquipMsgPanel:StartExit(time)
--
--end

function EquipMsgPanel:OnOpen(data, initiative)

end

--function EquipMsgPanel:OnClose(initiative)
--
--end

--function EquipMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function EquipMsgPanel:OnRefresh(data)
--
--end

--[[
/PanelBg/TitleBg/CloseBtn onClick 
--]]
function EquipMsgPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UIMgr:closeUI(self)
end

--[[
/maskImg onClick 
--]]
function EquipMsgPanel:maskImg_Button_onClick(maskImg)
    UIMgr:closeUI(self)
end

return EquipMsgPanel
