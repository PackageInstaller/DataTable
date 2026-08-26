-- chunkname: @modules/logic/fight/controller/replay/FightReplayWorkMoveCard.lua

module("modules.logic.fight.controller.replay.FightReplayWorkMoveCard", package.seeall)

local FightReplayWorkMoveCard = class("FightReplayWorkMoveCard", BaseWork)

function FightReplayWorkMoveCard:ctor(cardOp)
	self.cardOp = cardOp
end

function FightReplayWorkMoveCard:onStart()
	self._index = self.cardOp.param1
	self._sign = self.cardOp.param2 > self.cardOp.param1 and 1 or -1
	self._endIndex = self.cardOp.param2 + self._sign

	local uiSpeed = FightModel.instance:getUISpeed()
	local inverval = 0.1 / Mathf.Clamp(uiSpeed, 0.01, 100)

	TaskDispatcher.runRepeat(self._delaySimulateDrag, self, inverval, self.cardOp.param2 - self.cardOp.param1 + 1)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCombineCardEnd, self)
	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardBegin, self.cardOp.param1)
end

function FightReplayWorkMoveCard:_delaySimulateDrag()
	self._index = self._index + self._sign

	if self._index ~= self._endIndex then
		FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCard, self.cardOp.param1, self._index)
	else
		TaskDispatcher.cancelTask(self._delaySimulateDrag, self)

		local uiSpeed = FightModel.instance:getUISpeed()
		local delay = 0.2 / Mathf.Clamp(uiSpeed, 0.01, 100)

		TaskDispatcher.runDelay(self._delaySimulateDragEnd, self, delay)
	end
end

function FightReplayWorkMoveCard:_delaySimulateDragEnd()
	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, self.cardOp.param1, self.cardOp.param2)
end

function FightReplayWorkMoveCard:_onCombineCardEnd()
	TaskDispatcher.runDelay(self._delayDone, self, 0.01)
end

function FightReplayWorkMoveCard:_delayDone()
	self:onDone(true)
end

function FightReplayWorkMoveCard:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineCardEnd, self)
	TaskDispatcher.cancelTask(self._delaySimulateDrag, self)
	TaskDispatcher.cancelTask(self._delaySimulateDragEnd, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightReplayWorkMoveCard
