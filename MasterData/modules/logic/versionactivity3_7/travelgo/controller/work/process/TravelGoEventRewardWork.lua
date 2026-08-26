-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/process/TravelGoEventRewardWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.process.TravelGoEventRewardWork", package.seeall)

local TravelGoEventRewardWork = class("TravelGoEventRewardWork", BaseWork)

function TravelGoEventRewardWork:ctor()
	return
end

function TravelGoEventRewardWork:onStart()
	local travelGoEventMO = TravelGoModel.instance.travelGoEventMO
	local rewards = travelGoEventMO:getResultRewards()

	if rewards then
		local work = TravelGoController.instance.travelGoRewardMgr:createGainRewardWork(rewards)

		self.flow = FlowSequence.New()

		self.flow:addWork(work)
		self.flow:registerDoneListener(self.onEventFinish, self)
		self.flow:start()
	else
		self:onDone(true)
	end
end

function TravelGoEventRewardWork:onEventFinish()
	self:onDone(true)
end

function TravelGoEventRewardWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return TravelGoEventRewardWork
