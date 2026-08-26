-- chunkname: @modules/logic/fight/view/cardeffect/FightCardDiscardAfterPlay.lua

module("modules.logic.fight.view.cardeffect.FightCardDiscardAfterPlay", package.seeall)

local FightCardDiscardAfterPlay = class("FightCardDiscardAfterPlay", BaseWork)

function FightCardDiscardAfterPlay:onStart(context)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)

	local param2 = context.param2

	if param2 then
		if param2 ~= 0 then
			self:_playDiscard(param2)

			return
		end
	else
		local needDiscard = context.needDiscard

		if needDiscard then
			local cards = FightDataHelper.handCardMgr.handCard
			local canDiscard = false

			for i, v in ipairs(cards) do
				local entityMO = FightDataHelper.entityMgr:getById(v.uid)

				if entityMO then
					if not FightCardDataHelper.isBigSkill(v.skillId) then
						canDiscard = true

						break
					end
				else
					canDiscard = true

					break
				end
			end

			if canDiscard then
				FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, false)
				FightController.instance:registerCallback(FightEvent.PlayDiscardEffect, self._onPlayDiscardEffect, self)
				FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.Discard)

				return
			end
		end
	end

	self:onDone(true)
end

function FightCardDiscardAfterPlay:_onPlayDiscardEffect(param2)
	self:_playDiscard(param2)
end

function FightCardDiscardAfterPlay:_playDiscard(param2)
	self.context.view:cancelAbandonState()
	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.DiscardEffect)
	FightController.instance:dispatchEvent(FightEvent.StartPlayDiscardEffect)

	local cards = self.context.cards

	self.context.view:_updateHandCards(cards)

	self.context.fightBeginRoundOp.param2 = param2

	local removeIndexes = {
		param2
	}

	table.sort(removeIndexes, FightWorkCardRemove2.sort)

	local delayTime = FightCardDataHelper.calcRemoveCardTime2(cards, removeIndexes)

	table.remove(cards, param2)
	FightController.instance:dispatchEvent(FightEvent.CancelAutoPlayCardFinishEvent)
	TaskDispatcher.cancelTask(self._afterRemoveCard, self)
	TaskDispatcher.runDelay(self._afterRemoveCard, self, delayTime / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.CardRemove, removeIndexes, delayTime)
end

function FightCardDiscardAfterPlay:_afterRemoveCard()
	TaskDispatcher.cancelTask(self._afterRemoveCard, self)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
	FightController.instance:dispatchEvent(FightEvent.PlayCombineCards, self.context.cards)
end

function FightCardDiscardAfterPlay:_onCombineDone()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.DiscardEffect)
	FightController.instance:dispatchEvent(FightEvent.RevertAutoPlayCardFinishEvent)
	self:onDone(true)
end

function FightCardDiscardAfterPlay:clearWork()
	FightController.instance:dispatchEvent(FightEvent.DiscardAfterPlayCardFinish)
	TaskDispatcher.cancelTask(self._afterRemoveCard, self)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
	FightController.instance:unregisterCallback(FightEvent.PlayDiscardEffect, self._onPlayDiscardEffect, self)
end

return FightCardDiscardAfterPlay
