-- chunkname: @modules/logic/fight/view/cardeffect/FightCardResetEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardResetEffect", package.seeall)

local FightCardResetEffect = class("FightCardResetEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033

function FightCardResetEffect:onStart(context)
	TaskDispatcher.runDelay(self.onDelayDone, self, 1)

	self._dt = dt / FightModel.instance:getUISpeed()
	self.flow = FightWorkFlowSequence.New()

	local flow = self.flow

	flow:registWork(FightWorkSendEvent, FightEvent.CorrectHandCardScale)

	local handCardItemList = self.context.view.viewContainer.fightViewHandCard._handCardItemList

	if context.curIndex2OriginHandCardIndex then
		local moveParallel = flow:registWork(FightWorkFlowParallel)

		for i, playCardItem in ipairs(handCardItemList) do
			local cardItemGO = playCardItem.go
			local originCardIndex = context.curIndex2OriginHandCardIndex[i]

			if originCardIndex then
				local targetPosX = FightViewHandCard.calcCardPosX(originCardIndex)

				moveParallel:registWork(FightTweenWork, {
					type = "DOAnchorPos",
					toy = 0,
					tr = cardItemGO.transform,
					tox = targetPosX,
					t = self._dt * 4
				})
			end
		end
	end

	flow:registWork(FightWorkSendEvent, FightEvent.UpdateHandCards)
	flow:registFinishCallback(self._onWorkDone, self)
	flow:start()
end

function FightCardResetEffect:onDelayDone()
	FightController.instance:dispatchEvent(FightEvent.UpdateHandCards)
	self:onDone(true)
end

function FightCardResetEffect:clearWork()
	TaskDispatcher.cancelTask(self.onDelayDone, self)

	if self.flow then
		self.flow:disposeSelf()

		self.flow = nil
	end
end

function FightCardResetEffect:_onWorkDone()
	self:onDone(true)
end

return FightCardResetEffect
