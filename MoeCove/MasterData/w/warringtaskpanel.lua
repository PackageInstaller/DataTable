---@class WarringTaskPanel : WarringTaskPanel_Generate
---##################### 【WarringTaskPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WarringTaskPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WarringTaskPanel = require "WarringTaskPanel_Generate"

function WarringTaskPanel:InitLogic(data)

end

--function WarringTaskPanel:StartCreating(time)
--
--end

--function WarringTaskPanel:StartEnter(time)
--
--end

--function WarringTaskPanel:StartRemoving(time)
--
--end

--function WarringTaskPanel:StartExit(time)
--
--end

function WarringTaskPanel:OnOpen(data, initiative)

end

--function WarringTaskPanel:OnClose(initiative)
--
--end

--function WarringTaskPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function WarringTaskPanel:OnRefresh(data)
--
--end

--[[
/PanelBg/CloseBtn onClick 
--]]
function WarringTaskPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UIMgr:closeUI(self)
end

--[[
/Custom/TaskBox/Task/FastBtn onClick 
--]]
function WarringTaskPanel:fastBtn_ScaleButton_onClick(fastBtn)
    UIMgr:closeUI(self)
end

return WarringTaskPanel
