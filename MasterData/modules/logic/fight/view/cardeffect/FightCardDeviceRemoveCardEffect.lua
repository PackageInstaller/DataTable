-- chunkname: @modules/logic/fight/view/cardeffect/FightCardDeviceRemoveCardEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardDeviceRemoveCardEffect", package.seeall)

local FightCardDeviceRemoveCardEffect = class("FightCardDeviceRemoveCardEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033

function FightCardDeviceRemoveCardEffect:onStart(context)
	FightCardDeviceRemoveCardEffect.super.onStart(self, context)

	local handCardItem = self.context.handCardItem

	if handCardItem:checkDeviceEffectLoadDone() then
		self:startEffect()
	else
		handCardItem:loadDeviceEffectGo(self.startEffect, self)
	end
end

function FightCardDeviceRemoveCardEffect:startEffect()
	local handCardItem = self.context.handCardItem

	handCardItem:playDeviceAnim("close")
	self:doCanvasGroupWork()
end

function FightCardDeviceRemoveCardEffect:doCanvasGroupWork()
	local _dt = dt / FightModel.instance:getUISpeed()
	local foranimGo = self.context.handCardItem:getForAnimGo()
	local cardFlow = FlowParallel.New()

	cardFlow:addWork(TweenWork.New({
		from = 1,
		type = "DOFadeCanvasGroup",
		to = 0,
		go = foranimGo,
		t = _dt * 10
	}))

	self._flow = FlowSequence.New()

	self._flow:addWork(WorkWaitSeconds.New(0.5))
	self._flow:addWork(cardFlow)
	self._flow:registerDoneListener(self._onWorkDone, self)
	self._flow:start()
end

function FightCardDeviceRemoveCardEffect:clearWork()
	if self._flow then
		self._flow:unregisterDoneListener(self._onWorkDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

function FightCardDeviceRemoveCardEffect:onStop()
	FightCardDeviceRemoveCardEffect.super.onStop(self)
	self:clearWork()
end

function FightCardDeviceRemoveCardEffect:_onWorkDone()
	self:clearWork()
	self:onDone(true)
end

return FightCardDeviceRemoveCardEffect
