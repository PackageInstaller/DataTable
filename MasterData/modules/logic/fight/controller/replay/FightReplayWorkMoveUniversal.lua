-- chunkname: @modules/logic/fight/controller/replay/FightReplayWorkMoveUniversal.lua

module("modules.logic.fight.controller.replay.FightReplayWorkMoveUniversal", package.seeall)

local FightReplayWorkMoveUniversal = class("FightReplayWorkMoveUniversal", BaseWork)

function FightReplayWorkMoveUniversal:ctor(cardOp)
	self.cardOp = cardOp
end

function FightReplayWorkMoveUniversal:onStart()
	local uiSpeed = FightModel.instance:getUISpeed()

	TaskDispatcher.runDelay(self._delayDone, self, 10 / Mathf.Clamp(uiSpeed, 0.01, 100))

	local inverval = 0.1 / Mathf.Clamp(uiSpeed, 0.01, 100)

	if self.cardOp.param1 == self.cardOp.param2 - 1 then
		TaskDispatcher.runDelay(self._delaySimulateDragSpecial, self, inverval)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCombineCardEnd, self)
		FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardBegin, self.cardOp.param1)
	else
		self._index = self.cardOp.param1
		self._sign = self.cardOp.param2 > self.cardOp.param1 and 1 or -1
		self._endIndex = self.cardOp.param2 + self._sign

		if self.cardOp.param1 < self.cardOp.param2 then
			self._endIndex = self._endIndex - 1
		end

		TaskDispatcher.runRepeat(self._delaySimulateDrag, self, inverval, self.cardOp.param2 - self.cardOp.param1 + 1)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCombineCardEnd, self)
		FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardBegin, self.cardOp.param1)
	end
end

function FightReplayWorkMoveUniversal:_delaySimulateDragSpecial()
	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCard, self.cardOp.param1, self.cardOp.param1)

	local uiSpeed = FightModel.instance:getUISpeed()
	local delay = 0.2 / Mathf.Clamp(uiSpeed, 0.01, 100)

	TaskDispatcher.runDelay(self._delaySimulateDragEnd, self, delay)
end

function FightReplayWorkMoveUniversal:_delaySimulateDrag()
	self._index = self._index + self._sign

	if self._index ~= self._endIndex then
		FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCard, self.cardOp.param1, self._index)
	else
		TaskDispatcher.cancelTask(self._delaySimulateDrag, self)
		TaskDispatcher.runDelay(self._delaySimulateDragEnd, self, 0.2)
	end
end

function FightReplayWorkMoveUniversal:_delaySimulateDragEnd()
	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, self.cardOp.param1, self.cardOp.param2)
end

function FightReplayWorkMoveUniversal:_onCombineCardEnd()
	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.runDelay(self._delayDone, self, 0.01)
end

function FightReplayWorkMoveUniversal:_delayDone()
	self:onDone(true)
end

function FightReplayWorkMoveUniversal:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineCardEnd, self)
	TaskDispatcher.cancelTask(self._delaySimulateDragSpecial, self)
	TaskDispatcher.cancelTask(self._delaySimulateDrag, self)
	TaskDispatcher.cancelTask(self._delaySimulateDragEnd, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightReplayWorkMoveUniversal
