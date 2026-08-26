-- chunkname: @modules/logic/rouge2/outside/work/Rouge2_WaitOpenSettlementUnlockWork.lua

module("modules.logic.rouge2.outside.work.Rouge2_WaitOpenSettlementUnlockWork", package.seeall)

local Rouge2_WaitOpenSettlementUnlockWork = class("Rouge2_WaitOpenSettlementUnlockWork", BaseWork)

function Rouge2_WaitOpenSettlementUnlockWork:onStart()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if not resultInfo or not resultInfo.gainMaterial or #resultInfo.gainMaterial <= 0 then
		return self:onDone(true)
	end

	local reviewInfo = resultInfo.reviewInfo
	local params = {
		reviewInfo = reviewInfo,
		displayType = Rouge2_OutsideEnum.ResultFinalDisplayType.Result
	}

	self.flow = FlowSequence.New()

	self.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Rouge2_SettlementUnlockView, params))
	self.flow:registerDoneListener(self._onFlowDone, self)
	self.flow:start()
end

function Rouge2_WaitOpenSettlementUnlockWork:_onFlowDone()
	self:onDone(true)
end

function Rouge2_WaitOpenSettlementUnlockWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return Rouge2_WaitOpenSettlementUnlockWork
