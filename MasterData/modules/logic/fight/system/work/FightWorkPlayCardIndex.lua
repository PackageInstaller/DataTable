-- chunkname: @modules/logic/fight/system/work/FightWorkPlayCardIndex.lua

module("modules.logic.fight.system.work.FightWorkPlayCardIndex", package.seeall)

local FightWorkPlayCardIndex = class("FightWorkPlayCardIndex", BaseWork)

function FightWorkPlayCardIndex:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkPlayCardIndex:onStart(context)
	if FightHelper.isPlayerCardSkill(self.fightStepData) then
		FightController.instance:dispatchEvent(FightEvent.InvalidUsedCard, self.fightStepData.cardIndex, -1)
		FightPlayCardModel.instance:playCard(self.fightStepData.cardIndex)
		TaskDispatcher.runDelay(self._delayAfterDissolveCard, self, 1 / FightModel.instance:getUISpeed())
	else
		self:onDone(true)
	end
end

function FightWorkPlayCardIndex:_delayAfterDissolveCard()
	self:onDone(true)
end

function FightWorkPlayCardIndex:clearWork()
	TaskDispatcher.cancelTask(self._delayAfterDissolveCard, self)
end

return FightWorkPlayCardIndex
