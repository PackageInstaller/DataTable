-- chunkname: @modules/logic/fight/view/cardeffect/FightCardHeDuoNieDisappearEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardHeDuoNieDisappearEffect", package.seeall)

local FightCardHeDuoNieDisappearEffect = class("FightCardHeDuoNieDisappearEffect", BaseWork)
local Duration = 0.5

function FightCardHeDuoNieDisappearEffect:onStart(context)
	if not context then
		return self:onDone(true)
	end

	context:startLoadHeDuoNieCardRemoveEffect(self.doDisappearWork, self)
end

function FightCardHeDuoNieDisappearEffect:doDisappearWork()
	local go = self.context.go
	local parentGo = go.transform.parent.gameObject
	local lock = gohelper.findChild(parentGo, "lock")

	gohelper.setActive(lock, false)
	gohelper.setActive(self.context.goHeDuoNieCardRemoveEffect, true)

	if go.activeSelf then
		local duration = Duration / FightModel.instance:getUISpeed()

		self._flow = FlowSequence.New()

		self._flow:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = go,
			t = duration
		}))
		self._flow:registerDoneListener(self._onWorkDone, self)
		self._flow:start()
	else
		self:_onWorkDone()
	end
end

function FightCardHeDuoNieDisappearEffect:onStop()
	if self._flow then
		self._flow:unregisterDoneListener(self._onWorkDone, self)

		if self._flow.status == WorkStatus.Running then
			self._flow:stop()
		end
	end
end

function FightCardHeDuoNieDisappearEffect:_onWorkDone()
	if self.context then
		gohelper.setActive(self.context.goHeDuoNieCardRemoveEffect, false)
	end

	self:onDone(true)
end

function FightCardHeDuoNieDisappearEffect:clearWork()
	if self.context then
		gohelper.setActive(self.context.goHeDuoNieCardRemoveEffect, false)
	end

	if self._flow then
		self._flow:unregisterDoneListener(self._onWorkDone, self)

		self._flow = nil
	end
end

return FightCardHeDuoNieDisappearEffect
