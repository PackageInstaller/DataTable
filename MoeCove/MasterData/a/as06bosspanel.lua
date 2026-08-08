---@class As06BossPanel : As06BossPanel_Generate
---##################### 【As06BossPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【As06BossPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local As06BossPanel = require "As06BossPanel_Generate"

function As06BossPanel:InitLogic(data)

end

--function As06BossPanel:StartCreating(time)
--
--end

--function As06BossPanel:StartEnter(time)
--
--end

--function As06BossPanel:StartRemoving(time)
--
--end

--function As06BossPanel:StartExit(time)
--
--end

--function As06BossPanel:OnOpen(data, initiative)
--
--end

--function As06BossPanel:OnClose(initiative)
--
--end

--function As06BossPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function As06BossPanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/RightMiddle/BossDetailBtn onClick 
--]]
function As06BossPanel:bossDetailBtn_ScaleButton_onClick(bossDetailBtn)

end

--[[
/AdjustRoot/ChallengeBtn onClick 
--]]
function As06BossPanel:challengeBtn_ScaleButton_onClick(challengeBtn)

end

--[[
/AdjustRoot/QuickBattleBtn onClick 
--]]
function As06BossPanel:quickBattleBtn_ScaleButton_onClick(quickBattleBtn)

end

return As06BossPanel
