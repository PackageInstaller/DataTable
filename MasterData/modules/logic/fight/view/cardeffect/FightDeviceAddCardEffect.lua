-- chunkname: @modules/logic/fight/view/cardeffect/FightDeviceAddCardEffect.lua

module("modules.logic.fight.view.cardeffect.FightDeviceAddCardEffect", package.seeall)

local FightDeviceAddCardEffect = class("FightDeviceAddCardEffect", BaseWork)
local TimeFactor = 1

function FightDeviceAddCardEffect:onStart(context)
	FightDeviceAddCardEffect.super.onStart(self, context)

	local cardItem = context.handCardItem

	if cardItem:checkDeviceEffectLoadDone() then
		self:startEffect()
	else
		cardItem:loadDeviceEffectGo(self.startEffect, self)
	end
end

function FightDeviceAddCardEffect:startEffect()
	self._flow = FlowParallel.New()

	local cardItem = self.context.handCardItem

	cardItem:playDeviceAnim("open")

	local animDuration = 1.167 / FightModel.instance:getUISpeed()

	self._flow:addWork(DelayWork.New(animDuration))
	self:doAddCardWork()
end

function FightDeviceAddCardEffect:doAddCardWork()
	local dt = 0.033 * TimeFactor / FightModel.instance:getUISpeed()
	local cardItem = self.context.handCardItem

	if cardItem then
		local handCardGo = cardItem.go
		local foranimGo = gohelper.findChild(handCardGo, "foranim")

		gohelper.setActive(handCardGo, false)

		local oneCardFlow = FlowSequence.New()

		oneCardFlow:addWork(FunctionWork.New(function()
			gohelper.setActive(handCardGo, false)
		end))

		local cardTargetPosX = FightViewHandCard.calcCardPosX(cardItem.index)
		local cardTargetPosXOver = cardTargetPosX + 60
		local card_start_pos_X = cardTargetPosX - 1000

		oneCardFlow:addWork(FunctionWork.New(function()
			gohelper.onceAddComponent(foranimGo, gohelper.Type_CanvasGroup).alpha = 0

			gohelper.setActive(handCardGo, true)
			recthelper.setAnchorX(cardItem.tr, card_start_pos_X)
		end))

		local flyParallel = FlowParallel.New()

		flyParallel:addWork(TweenWork.New({
			from = 0,
			type = "DOFadeCanvasGroup",
			to = 1,
			go = foranimGo,
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

	self._flow:registerDoneListener(self._onCardDone, self)
	self._flow:start()
end

function FightDeviceAddCardEffect:_onCardDone()
	self._flow:unregisterDoneListener(self._onCardDone, self)
	self:onDone(true)
end

function FightDeviceAddCardEffect:clearWork()
	if self._flow then
		self._flow:unregisterDoneListener(self._onCardDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightDeviceAddCardEffect
