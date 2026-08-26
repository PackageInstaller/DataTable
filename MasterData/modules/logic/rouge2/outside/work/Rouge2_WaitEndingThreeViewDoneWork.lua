-- chunkname: @modules/logic/rouge2/outside/work/Rouge2_WaitEndingThreeViewDoneWork.lua

module("modules.logic.rouge2.outside.work.Rouge2_WaitEndingThreeViewDoneWork", package.seeall)

local Rouge2_WaitEndingThreeViewDoneWork = class("Rouge2_WaitEndingThreeViewDoneWork", BaseWork)

function Rouge2_WaitEndingThreeViewDoneWork:ctor(endId)
	self.endId = endId
end

function Rouge2_WaitEndingThreeViewDoneWork:onStart()
	if self.endId ~= RougeEnum.EndingThreeId then
		self:onDone(true)

		return
	end

	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local isSucc = resultInfo and resultInfo:isSucceed()

	if not isSucc then
		self:onDone(true)
	end

	self.flow = FlowSequence.New()

	self.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeEndingThreeView))
	self.flow:registerDoneListener(self.onFlowDone, self)
	self.flow:start()
end

function Rouge2_WaitEndingThreeViewDoneWork:onFlowDone()
	self:onDone(true)
end

function Rouge2_WaitEndingThreeViewDoneWork:clearWork()
	if self.flow then
		self.flow:onDestroy()

		self.flow = nil
	end
end

return Rouge2_WaitEndingThreeViewDoneWork
