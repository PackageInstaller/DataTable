-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gainitem/model/GainItemCell.lua

module("logic.extensions.gainitem.model.GainItemCell", package.seeall)

local M = class("GainItemCell", ItemCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("breakpoint", BreakPointComponent)
	self:_addComponent("levelNum", LevelComponent)
	self:_addComponent("animation", BackpackAnimationComponent)
	self:_addComponent("name", BackpackNameComponent)
end

return M
