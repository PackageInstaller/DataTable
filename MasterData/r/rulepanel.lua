---@class RulePanel : RulePanel__Generate
---##################### 【RulePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RulePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RulePanel = require "RulePanel_Generate"

function RulePanel:InitLogic(data)

end

--function RulePanel:StartCreating(time)
--
--end

--function RulePanel:StartEnter(time)
--
--end

--function RulePanel:StartRemoving(time)
--
--end

--function RulePanel:StartExit(time)
--
--end

function RulePanel:OnOpen(data, initiative)
    local ruleID = data
    self.ruleText.text.text = Config.GetRuleInfo(ruleID).Rule
    self.title.text.text = Config.GetRuleInfo(ruleID).RuleName
end

--function RulePanel:OnClose(initiative)
--
--end

--function RulePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function RulePanel:OnRefresh(data)
--
--end

--[[
/Root onClick 
--]]
function RulePanel:button_Button_onClick(button)

end

return RulePanel
