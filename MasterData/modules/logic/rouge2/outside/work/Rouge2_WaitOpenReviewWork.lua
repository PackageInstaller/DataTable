-- chunkname: @modules/logic/rouge2/outside/work/Rouge2_WaitOpenReviewWork.lua

module("modules.logic.rouge2.outside.work.Rouge2_WaitOpenReviewWork", package.seeall)

local Rouge2_WaitOpenReviewWork = class("Rouge2_WaitOpenReviewWork", BaseWork)

function Rouge2_WaitOpenReviewWork:onStart()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.finalScore then
			local finalScore = 0

			if finalScore <= 0 then
				return self:onDone(true)
			end

			local reviewInfo = resultInfo.reviewInfo
			local params = {
				reviewInfo = reviewInfo,
				displayType = Rouge2_OutsideEnum.ResultFinalDisplayType.Result
			}

			self.flow = FlowSequence.New()

			self.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Rouge2_ResultFinalView, params))
			self.flow:registerDoneListener(self._onFlowDone, self)
			self.flow:start()
		end
	end
end

function Rouge2_WaitOpenReviewWork:_onFlowDone()
	self:onDone(true)
end

function Rouge2_WaitOpenReviewWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return Rouge2_WaitOpenReviewWork
