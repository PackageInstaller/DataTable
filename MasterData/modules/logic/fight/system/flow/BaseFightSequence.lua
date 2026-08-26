-- chunkname: @modules/logic/fight/system/flow/BaseFightSequence.lua

module("modules.logic.fight.system.flow.BaseFightSequence", package.seeall)

local BaseFightSequence = class("BaseFightSequence")

function BaseFightSequence:ctor()
	self._sequence = nil
end

function BaseFightSequence:buildFlow()
	if self._sequence then
		self._sequence:destroy()
	end

	self._sequence = FlowSequence.New()
end

function BaseFightSequence:addWork(work)
	self._sequence:addWork(work)
end

function BaseFightSequence:start(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj

	self._sequence:registerDoneListener(self.doCallback, self)
	self._sequence:start({})
end

function BaseFightSequence:stop()
	if self._sequence and self._sequence.status == WorkStatus.Running then
		self._sequence:stop()
	end
end

function BaseFightSequence:isRunning()
	return self._sequence and self._sequence.status == WorkStatus.Running
end

function BaseFightSequence:doneRunningWork()
	local needDoneWorkList = {}

	self:_getRunningWorks(self._sequence, needDoneWorkList)

	for _, work in ipairs(needDoneWorkList) do
		logError("行为复现出错，work: " .. work.__cname)
		work:onDone(true)
	end
end

function BaseFightSequence:_getRunningWorks(flow, needDoneWorkList)
	local list = flow:getWorkList()

	for _, work in ipairs(list) do
		if work.status == WorkStatus.Running then
			if isTypeOf(work, FlowSequence) then
				self:_getRunningWorks(work, needDoneWorkList)
			elseif isTypeOf(work, FlowParallel) then
				self:_getRunningWorks(work, needDoneWorkList)
			else
				table.insert(needDoneWorkList, work)
			end
		end
	end
end

function BaseFightSequence:dispose()
	if self._sequence then
		self._sequence:unregisterDoneListener(self.doCallback, self)
		self._sequence:destroy()
	end

	self._sequence = nil
	self._context = nil
	self._callback = nil
	self._callbackObj = nil
end

function BaseFightSequence:doCallback()
	self._sequence:unregisterDoneListener(self.doCallback, self)

	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj)
		else
			self._callback()
		end
	end
end

return BaseFightSequence
