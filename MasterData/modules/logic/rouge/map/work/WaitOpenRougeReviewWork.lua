-- chunkname: @modules/logic/rouge/map/work/WaitOpenRougeReviewWork.lua

module("modules.logic.rouge.map.work.WaitOpenRougeReviewWork", package.seeall)

local WaitOpenRougeReviewWork = class("WaitOpenRougeReviewWork", BaseWork)

function WaitOpenRougeReviewWork:onStart()
	local resultInfo = RougeModel.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.finalScore then
			local finalScore = 0

			if finalScore <= 0 then
				return self:onDone(true)
			end

			self.flow = FlowSequence.New()

			self.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeResultReView))
			self.flow:registerDoneListener(self._onFlowDone, self)
			self.flow:start()
		end
	end
end

function WaitOpenRougeReviewWork:_onFlowDone()
	self:onDone(true)
end

function WaitOpenRougeReviewWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return WaitOpenRougeReviewWork
