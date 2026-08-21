---@class ResLevelBox : ResLevelBox_Generate
---##################### 【ResLevelBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ResLevelBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ResLevelBox = require "ResLevelBox_Generate"

function ResLevelBox:InitLogic(data)

end

--function ResLevelBox:StartCreating(time)
--
--end

--function ResLevelBox:StartEnter(time)
--
--end

--function ResLevelBox:StartRemoving(time)
--
--end

--function ResLevelBox:StartExit(time)
--
--end

--function ResLevelBox:OnOpen(data, initiative)
--
--end

--function ResLevelBox:OnClose(initiative)
--
--end

--function ResLevelBox:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ResLevelBox:OnRefresh(data)
--
--end

--[[
/PanelBg/Art/TitleBg/CloseBtn onClick 
--]]
function ResLevelBox:closeBtn_ScaleButton_onClick(closeBtn)

end

--[[
/PanelBg/BtnsGroup/CancelBtn onClick 
--]]
function ResLevelBox:cancelBtn_ScaleButton_onClick(cancelBtn)

end

--[[
/PanelBg/BtnsGroup/ConfirmBtn onClick 
--]]
function ResLevelBox:confirmBtn_ScaleButton_onClick(confirmBtn)

end

return ResLevelBox
