---@class PassBuyLevelResutPanel : PassBuyLevelResutPanel_Generate
---##################### 【PassBuyLevelResutPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【PassBuyLevelResutPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local PassBuyLevelResutPanel = require "PassBuyLevelResutPanel_Generate"

function PassBuyLevelResutPanel:InitLogic(data)

end

--function PassBuyLevelResutPanel:StartCreating(time)
--
--end

--function PassBuyLevelResutPanel:StartEnter(time)
--
--end

--function PassBuyLevelResutPanel:StartRemoving(time)
--
--end

--function PassBuyLevelResutPanel:StartExit(time)
--
--end

function PassBuyLevelResutPanel:OnOpen(data, initiative)
    self.prevLevel.text.text = data.prevLevel
    self.nextLevel.text.text = data.nextLevel
end

--function PassBuyLevelResutPanel:OnClose(initiative)
--
--end

--function PassBuyLevelResutPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function PassBuyLevelResutPanel:OnRefresh(data)
--
--end

--[[
/closeBg onClick 
--]]
function PassBuyLevelResutPanel:closeBg_Button_onClick(closeBg)
    UIMgr:closeUI(self)
end

return PassBuyLevelResutPanel
