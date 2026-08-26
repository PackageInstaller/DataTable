-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/event/TravelGoLuckEventWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.event.TravelGoLuckEventWork", package.seeall)

local TravelGoLuckEventWork = class("TravelGoLuckEventWork", BaseWork)

function TravelGoLuckEventWork:ctor()
	return
end

function TravelGoLuckEventWork:onStart()
	local travelGoEventMO = TravelGoModel.instance.travelGoEventMO
	local luckEventType = travelGoEventMO.luckEventType
	local actId = TravelGoModel.instance.activityId

	self.flow = FlowSequence.New()

	self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnStartLuckEvent, luckEventType))

	local strTime = TravelGoConfig.instance:getConsValue(actId, TravelGoConst.ConstId.LuckyEventWaitTime)
	local timeArr = string.splitToNumber(strTime, "#")

	if timeArr then
		if not timeArr[luckEventType] then
			local waitTime = 0

			self.flow:addWork(TimerWork.New(waitTime))

			local descList = travelGoEventMO:getLuckDescList()

			if descList then
				local descIntervalTime = TravelGoConfig.instance:getConsValue(actId, TravelGoConst.ConstId.DescIntervalTime, true) or 0

				for i, desc in ipairs(descList) do
					local param = {
						desc = desc,
						luckType = luckEventType
					}

					self.flow:addWork(FunctionWork.New(TravelGoController.instance.addDescItem, TravelGoController.instance, param))

					if i ~= #descList then
						self.flow:addWork(TimerWork.New(descIntervalTime))
					end
				end
			end

			self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnLuckEventFinish))
			self.flow:registerDoneListener(self.onEventFinish, self)
			self.flow:start()
		end
	end
end

function TravelGoLuckEventWork:onEventFinish()
	self:onDone(true)
end

function TravelGoLuckEventWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return TravelGoLuckEventWork
