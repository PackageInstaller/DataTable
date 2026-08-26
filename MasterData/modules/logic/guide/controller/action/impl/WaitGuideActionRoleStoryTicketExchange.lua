-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoleStoryTicketExchange.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoleStoryTicketExchange", package.seeall)

local WaitGuideActionRoleStoryTicketExchange = class("WaitGuideActionRoleStoryTicketExchange", BaseGuideAction)
local WaitTicketAnimTime = 1.6

function WaitGuideActionRoleStoryTicketExchange:onStart(context)
	WaitGuideActionRoleStoryTicketExchange.super.onStart(self, context)

	local lastExchangeTime = RoleStoryModel.instance.lastExchangeTime
	local cost = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)
	local cur = RoleStoryModel.instance:getLeftNum()

	if cost <= cur and RoleStoryModel.instance:checkTodayCanExchange() then
		RoleStoryController.instance:registerCallback(RoleStoryEvent.ExchangeTick, self._onExchangeTick, self)
	elseif lastExchangeTime and Time.time - lastExchangeTime < WaitTicketAnimTime then
		self:_onExchangeTick()
	else
		self:onDone(true)
	end
end

function WaitGuideActionRoleStoryTicketExchange:_onExchangeTick()
	RoleStoryController.instance:unregisterCallback(RoleStoryEvent.ExchangeTick, self._onExchangeTick, self)
	GuideBlockMgr.instance:startBlock(WaitTicketAnimTime)
	TaskDispatcher.runDelay(self._onDone, self, WaitTicketAnimTime)
end

function WaitGuideActionRoleStoryTicketExchange:_onDone()
	self:onDone(true)
end

function WaitGuideActionRoleStoryTicketExchange:clearWork()
	TaskDispatcher.cancelTask(self._onDone, true)
	RoleStoryController.instance:unregisterCallback(RoleStoryEvent.ExchangeTick, self._onExchangeTick, self)
end

return WaitGuideActionRoleStoryTicketExchange
