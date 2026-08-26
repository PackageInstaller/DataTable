-- chunkname: @modules/logic/rouge2/outside/work/Rouge2_WaitOpenUnlockInfoWork.lua

module("modules.logic.rouge2.outside.work.Rouge2_WaitOpenUnlockInfoWork", package.seeall)

local Rouge2_WaitOpenUnlockInfoWork = class("Rouge2_WaitOpenUnlockInfoWork", BaseWork)

function Rouge2_WaitOpenUnlockInfoWork:onStart()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.collectionNum then
			local unlockCount = 0

			if unlockCount <= 0 then
				return self:onDone(true)
			end

			self.flow = FlowSequence.New()

			self.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Rouge2_ResultUnlockInfoView))
			self.flow:registerDoneListener(self._onFlowDone, self)
			self.flow:start()
		end
	end
end

function Rouge2_WaitOpenUnlockInfoWork:_onFlowDone()
	self:onDone(true)
end

function Rouge2_WaitOpenUnlockInfoWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return Rouge2_WaitOpenUnlockInfoWork
