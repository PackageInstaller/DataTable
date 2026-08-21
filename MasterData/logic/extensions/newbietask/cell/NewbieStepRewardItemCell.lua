-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbietask/cell/NewbieStepRewardItemCell.lua

module("logic.extensions.newbietask.cell.NewbieStepRewardItemCell", package.seeall)

local M = class("NewbieStepRewardItemCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("reward", ReceiveStatusComponent)
end

function M:addComponent(compName, compClass)
	self:_addComponent(compName, compClass)
	self:getComponent(compName):onInit()
end

function M:setStepPoint(stepPoint)
	self._stepPoint = stepPoint
end

function M:getStepPoint()
	return self._stepPoint
end

function M:getGo()
	return self._go
end

function M:dealSelect()
	GlobalDispatcher:dispatchEvent(EventType.NEWBIE_STEP_REWARD_CLICK, self)
end

return M
