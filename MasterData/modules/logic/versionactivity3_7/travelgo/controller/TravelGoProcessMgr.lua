-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/TravelGoProcessMgr.lua

module("modules.logic.versionactivity3_7.travelgo.controller.TravelGoProcessMgr", package.seeall)

local TravelGoProcessMgr = class("TravelGoProcessMgr", TravelGoBase)

function TravelGoProcessMgr:onEnable()
	return
end

function TravelGoProcessMgr:onDisable()
	self:clearFlow()
end

function TravelGoProcessMgr:clearFlow()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

function TravelGoProcessMgr:startNextDay()
	self:clearFlow()

	self.flow = FlowSequence.New()

	self:nextDayWork()

	if TravelGoModel.instance.day == 1 then
		self.flow:addWork(WaitEventWork.New("TravelGoController;TravelGoEvent;OnPlayerBornComplete"))
		self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnPlayerStartMove))
	end

	if not TravelGoController.instance.isNotEvent then
		self.flow:addWork(FunctionWork.New(TravelGoModel.instance.randomDayEvent, TravelGoModel.instance))
		self.flow:addWork(TravelGoDayEventWork.New())
		self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnDayFinish))
	end

	self.flow:start()
end

function TravelGoProcessMgr:nextDayWork()
	TravelGoModel.instance:nextDay()
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnDayChange)
end

return TravelGoProcessMgr
