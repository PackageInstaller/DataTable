-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleCalculateRewardCell.lua

module("logic.extensions.battle.viewcalculate.BattleCalculateRewardCell", package.seeall)

local M = class("GainItemCell", ItemCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("breakpoint", BreakPointComponent)
	self:_addComponent("levelNum", LevelComponent)
	self:_addComponent("animation", BackpackAnimationComponent)
end

return M
