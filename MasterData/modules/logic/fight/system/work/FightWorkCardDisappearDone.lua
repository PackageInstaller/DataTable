-- chunkname: @modules/logic/fight/system/work/FightWorkCardDisappearDone.lua

module("modules.logic.fight.system.work.FightWorkCardDisappearDone", package.seeall)

local FightWorkCardDisappearDone = class("FightWorkCardDisappearDone", BaseWork)

function FightWorkCardDisappearDone:ctor()
	return
end

function FightWorkCardDisappearDone:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 10)
	FightController.instance:registerCallback(FightEvent.CardDisappearFinish, self._onCardDisappearFinish, self)
end

function FightWorkCardDisappearDone:_onCardDisappearFinish()
	FightController.instance:unregisterCallback(FightEvent.CardDisappearFinish, self._onCardDisappearFinish, self)
	self:onDone(true)
end

function FightWorkCardDisappearDone:_delayDone()
	logError("卡牌消失超时，isChanging=false")
	self:onDone(true)
end

function FightWorkCardDisappearDone:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	FightController.instance:unregisterCallback(FightEvent.CardDisappearFinish, self._onCardDisappearFinish, self)
end

return FightWorkCardDisappearDone
