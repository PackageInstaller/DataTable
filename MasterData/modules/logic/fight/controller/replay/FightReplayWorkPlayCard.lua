-- chunkname: @modules/logic/fight/controller/replay/FightReplayWorkPlayCard.lua

module("modules.logic.fight.controller.replay.FightReplayWorkPlayCard", package.seeall)

local FightReplayWorkPlayCard = class("FightReplayWorkPlayCard", BaseWork)

function FightReplayWorkPlayCard:ctor(cardOp)
	self.cardOp = cardOp
end

function FightReplayWorkPlayCard:onStart()
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCombineCardEnd, self)
	FightController.instance:dispatchEvent(FightEvent.SimulatePlayHandCard, self.cardOp.param1, self.cardOp.toId, self.cardOp.param2, self.cardOp.param3, self.cardOp.cardParam1)
end

function FightReplayWorkPlayCard:_onCombineCardEnd()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineCardEnd, self)
	TaskDispatcher.runDelay(self._delayDone, self, 0.01)
end

function FightReplayWorkPlayCard:_delayDone()
	self:onDone(true)
end

function FightReplayWorkPlayCard:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineCardEnd, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightReplayWorkPlayCard
