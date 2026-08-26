-- chunkname: @modules/logic/fight/view/cardeffect/FightHeDuoNieAddCardEffect.lua

module("modules.logic.fight.view.cardeffect.FightHeDuoNieAddCardEffect", package.seeall)

local FightHeDuoNieAddCardEffect = class("FightHeDuoNieAddCardEffect", BaseWork)
local TimeFactor = 1

function FightHeDuoNieAddCardEffect:onStart(context)
	self:doAddCardWork()
end

function FightHeDuoNieAddCardEffect:doAddCardWork()
	local dt = 0.033 * TimeFactor / FightModel.instance:getUISpeed()
	local cardItem = self.context.handCardItem

	if cardItem then
		self._flow = FlowSequence.New()

		local handCardGo = cardItem.go
		local foranimGo = gohelper.findChild(handCardGo, "foranim")

		gohelper.onceAddComponent(foranimGo, gohelper.Type_CanvasGroup).alpha = 0

		gohelper.setActive(handCardGo, true)

		local cardTargetPosX = FightViewHandCard.calcCardPosX(cardItem.index)

		recthelper.setAnchor(cardItem.tr, cardTargetPosX, 0)
		self._flow:addWork(TweenWork.New({
			from = 0,
			type = "DOFadeCanvasGroup",
			to = 1,
			go = foranimGo,
			t = dt * 8,
			ease = EaseType.linear
		}))
		self._flow:registerDoneListener(self._onCardDone, self)
		self._flow:start()
	else
		return self:onDone(true)
	end
end

function FightHeDuoNieAddCardEffect:_onCardDone()
	self._flow:unregisterDoneListener(self._onCardDone, self)
	self:onDone(true)
end

function FightHeDuoNieAddCardEffect:clearWork()
	if self._flow then
		self._flow:unregisterDoneListener(self._onCardDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightHeDuoNieAddCardEffect
