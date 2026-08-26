-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/event/TravelGoCreateEventDescWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.event.TravelGoCreateEventDescWork", package.seeall)

local TravelGoCreateEventDescWork = class("TravelGoCreateEventDescWork", BaseWork)

function TravelGoCreateEventDescWork:ctor()
	return
end

function TravelGoCreateEventDescWork:onStart()
	self.flow = FlowSequence.New()

	local travelGoEventMO = TravelGoModel.instance.travelGoEventMO
	local descList = travelGoEventMO.descList

	if descList then
		local descIntervalTime = TravelGoConfig.instance:getConsValue(TravelGoModel.instance.activityId, TravelGoConst.ConstId.DescIntervalTime, true) or 0

		for i, desc in ipairs(descList) do
			local param = {
				desc = desc
			}

			self.flow:addWork(FunctionWork.New(TravelGoController.instance.addDescItem, TravelGoController.instance, param))

			if i ~= #descList then
				self.flow:addWork(TimerWork.New(descIntervalTime))
			end
		end
	end

	self.flow:registerDoneListener(self.onOk, self)
	self.flow:start()
end

function TravelGoCreateEventDescWork:onOk()
	self:onDone(true)
end

function TravelGoCreateEventDescWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return TravelGoCreateEventDescWork
