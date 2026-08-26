-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/event/TravelGoDayEventWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.event.TravelGoDayEventWork", package.seeall)

local TravelGoDayEventWork = class("TravelGoDayEventWork", BaseWork)

function TravelGoDayEventWork:onStart()
	self.flow = FlowSequence.New()

	self.flow:registerDoneListener(self.onOk, self)
	self.flow:addWork(TravelGoCreateEventDescWork.New())
	self.flow:addWork(TravelGoController.instance:getDayEventWork())
	self.flow:addWork(TravelGoSettleWork.New())
	self.flow:addWork(TravelGoEventRewardWork.New())
	self.flow:addWork(TravelGoLevelUpWork.New())
	self.flow:start()
	self.flow:addWork(TravelGoSettleWork.New(true))
end

function TravelGoDayEventWork:onOk()
	self:onDone(true)
end

function TravelGoDayEventWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return TravelGoDayEventWork
