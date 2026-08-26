-- chunkname: @modules/logic/rouge/map/work/WaitEndingThreeViewDoneWork.lua

module("modules.logic.rouge.map.work.WaitEndingThreeViewDoneWork", package.seeall)

local WaitEndingThreeViewDoneWork = class("WaitEndingThreeViewDoneWork", BaseWork)

function WaitEndingThreeViewDoneWork:ctor(endId)
	self.endId = endId
end

function WaitEndingThreeViewDoneWork:onStart()
	if self.endId ~= RougeEnum.EndingThreeId then
		self:onDone(true)

		return
	end

	local resultInfo = RougeModel.instance:getRougeResult()
	local isSucc = resultInfo and resultInfo:isSucceed()

	if not isSucc then
		self:onDone(true)
	end

	self.flow = FlowSequence.New()

	self.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeEndingThreeView))
	self.flow:registerDoneListener(self.onFlowDone, self)
	self.flow:start()
end

function WaitEndingThreeViewDoneWork:onFlowDone()
	self:onDone(true)
end

function WaitEndingThreeViewDoneWork:clearWork()
	if self.flow then
		self.flow:onDestroy()

		self.flow = nil
	end
end

return WaitEndingThreeViewDoneWork
