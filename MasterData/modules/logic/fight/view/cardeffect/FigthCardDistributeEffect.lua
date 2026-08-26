-- chunkname: @modules/logic/fight/view/cardeffect/FigthCardDistributeEffect.lua

module("modules.logic.fight.view.cardeffect.FigthCardDistributeEffect", package.seeall)

local FigthCardDistributeEffect = class("FigthCardDistributeEffect", BaseWork)
local TimeFactor = 1

function FigthCardDistributeEffect:onStart(context)
	FigthCardDistributeEffect.super.onStart(self, context)

	if context.playCardContainer then
		gohelper.onceAddComponent(context.playCardContainer, typeof(UnityEngine.CanvasGroup)).alpha = 0
	end

	self._flow = FlowParallel.New()

	local dt = 0.033 * TimeFactor / FightModel.instance:getUISpeed()
	local preCardCount = context.preCardCount
	local newCardCount = context.newCardCount

	for i = 1, newCardCount do
		local cardIndex = preCardCount + i
		local cardItem = context.handCardItemList[cardIndex]

		if cardItem then
			gohelper.setActive(cardItem.go, false)

			local oneCardFlow = FlowSequence.New()

			oneCardFlow:addWork(FunctionWork.New(function()
				gohelper.setActive(cardItem.go, false)
			end))

			local delay = (1 + 3 * (i - 1)) * dt

			if delay > 0 then
				oneCardFlow:addWork(WorkWaitSeconds.New(delay))
			end

			local cardTargetPosX = FightViewHandCard.calcCardPosX(cardIndex)
			local cardTargetPosXOver = cardTargetPosX + 60
			local card_start_pos_X = cardTargetPosX - 1000

			oneCardFlow:addWork(FunctionWork.New(function()
				gohelper.onceAddComponent(cardItem.go, gohelper.Type_CanvasGroup).alpha = 0

				gohelper.setActive(cardItem.go, true)
				recthelper.setAnchorX(cardItem.tr, card_start_pos_X)
			end))

			local flyParallel = FlowParallel.New()

			flyParallel:addWork(TweenWork.New({
				from = 0,
				type = "DOFadeCanvasGroup",
				to = 1,
				go = cardItem.go,
				t = dt * 8,
				ease = EaseType.linear
			}))
			flyParallel:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = cardItem.tr,
				to = cardTargetPosXOver,
				t = dt * 8,
				ease = EaseType.InOutSine
			}))
			oneCardFlow:addWork(flyParallel)
			oneCardFlow:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = cardItem.tr,
				to = cardTargetPosX,
				t = dt * 4,
				ease = EaseType.OutCubic
			}))
			self._flow:addWork(oneCardFlow)
		end
	end

	if newCardCount > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightDistribute)
	end

	self._flow:registerDoneListener(self._onCardDone, self)
	self._flow:start(context)
end

function FigthCardDistributeEffect:_onCardDone()
	self._flow:unregisterDoneListener(self._onCardDone, self)
	self:onDone(true)
end

function FigthCardDistributeEffect:clearWork()
	self._flow:unregisterDoneListener(self._onCardDone, self)
	self._flow:stop()
end

return FigthCardDistributeEffect
