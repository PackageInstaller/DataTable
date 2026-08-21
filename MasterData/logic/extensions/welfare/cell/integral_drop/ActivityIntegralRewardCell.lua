-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/cell/integral_drop/ActivityIntegralRewardCell.lua

module("logic.extensions.welfare.cell.integral_drop.ActivityIntegralRewardCell", package.seeall)

local M = class("ActivityIntegralRewardCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("reward", RedPointReceiveStatusComponent)
end

function M:addComponent(compName, compClass)
	self:_addComponent(compName, compClass)
	self:getComponent(compName):onInit()
end

function M:setStepOrder(orderId)
	self._orderIdCell = orderId
end

function M:getStepOrder()
	return self._orderIdCell
end

function M:getGo()
	return self._go
end

function M:dealSelect()
	GlobalDispatcher:dispatchEvent(EventType.ACTIVITY_INTEGRAL_DROP_REWARD, self)
end

return M
