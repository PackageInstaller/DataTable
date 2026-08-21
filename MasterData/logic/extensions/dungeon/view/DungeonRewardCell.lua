-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonRewardCell.lua

module("logic.extensions.dungeon.view.DungeonRewardCell", package.seeall)

local M = class("DungeonRewardCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("cellComp", DungeonRewardCellComp)
end

function M:OnDestroy()
	self._viewElementsRegistry:cleanRegistry()

	self._viewElementsRegistry = nil
end

return M
