-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/RewardCell.lua

module("logic.extensions.dungeon.view.RewardCell", package.seeall)

local M = class("RewardCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("cellComp", RewardCellComp)
	self:_addComponent("signComp", ItemSignComponent)
	self:_addComponent("reward", ReceiveStatusComponent)
end

function M:OnDestroy()
	self._viewElementsRegistry:cleanRegistry()

	self._viewElementsRegistry = nil
end

return M
