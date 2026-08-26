-- chunkname: @modules/logic/fight/system/work/FightWorkRoundEnd.lua

module("modules.logic.fight.system.work.FightWorkRoundEnd", package.seeall)

local FightWorkRoundEnd = class("FightWorkRoundEnd", BaseWork)

function FightWorkRoundEnd:onStart(context)
	FightPlayCardModel.instance:onEndRound()

	local entitys = FightHelper.getAllEntitys()

	for _, entity in ipairs(entitys) do
		entity:resetEntity()
	end

	FightController.instance:registerCallback(FightEvent.NeedWaitEnemyOPEnd, self._needWaitEnemyOPEnd, self)
	TaskDispatcher.runDelay(self._dontNeedWaitEnemyOPEnd, self, 0.01)
	FightController.instance:dispatchEvent(FightEvent.FightRoundEnd)
end

function FightWorkRoundEnd:_needWaitEnemyOPEnd()
	FightController.instance:unregisterCallback(FightEvent.NeedWaitEnemyOPEnd, self._needWaitEnemyOPEnd, self)
	TaskDispatcher.cancelTask(self._dontNeedWaitEnemyOPEnd, self)
	TaskDispatcher.runDelay(self._playCardExpand, self, 0.5 / FightModel.instance:getUISpeed())
end

function FightWorkRoundEnd:_dontNeedWaitEnemyOPEnd()
	FightController.instance:unregisterCallback(FightEvent.NeedWaitEnemyOPEnd, self._needWaitEnemyOPEnd, self)
	TaskDispatcher.cancelTask(self._dontNeedWaitEnemyOPEnd, self)
	self:_playCardExpand()
end

function FightWorkRoundEnd:_playCardExpand()
	local handCardContainer = FightViewHandCard.handCardContainer

	if not FightModel.instance:isFinish() and not gohelper.isNil(handCardContainer) then
		local time = FightWorkEffectDistributeCard.getHandCardScaleTime()
		local scale = FightCardDataHelper.getHandCardContainerScale()

		self._tweenId = ZProj.TweenHelper.DOScale(handCardContainer.transform, scale, scale, scale, time, self._onHandCardsExpand, self)
	else
		self:_onHandCardsExpand()
	end
end

function FightWorkRoundEnd:_onHandCardsExpand()
	logNormal("回合结束")
	self:onDone(true)
end

function FightWorkRoundEnd:clearWork()
	FightController.instance:unregisterCallback(FightEvent.NeedWaitEnemyOPEnd, self._needWaitEnemyOPEnd, self)
	TaskDispatcher.cancelTask(self._dontNeedWaitEnemyOPEnd, self)
	TaskDispatcher.cancelTask(self._playCardExpand, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return FightWorkRoundEnd
