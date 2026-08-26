-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/TravelGoInvokeEventWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.TravelGoInvokeEventWork", package.seeall)

local TravelGoInvokeEventWork = class("TravelGoInvokeEventWork", BaseWork)

function TravelGoInvokeEventWork:onStart()
	self.flow = FlowSequence.New()

	self.flow:addWork(TravelGoController.instance:getDayEventWork())
	self.flow:registerDoneListener(self.onEventFinish, self)
	self.flow:start()
end

function TravelGoInvokeEventWork:onEventFinish()
	self:onDone(true)
end

function TravelGoInvokeEventWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return TravelGoInvokeEventWork
