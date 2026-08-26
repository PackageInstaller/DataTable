-- chunkname: @modules/logic/fight/view/cardeffect/FightCardDisplayHideAllEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardDisplayHideAllEffect", package.seeall)

local FightCardDisplayHideAllEffect = class("FightCardDisplayHideAllEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033

function FightCardDisplayHideAllEffect:onStart(context)
	FightCardDisplayHideAllEffect.super.onStart(self, context)

	self._dt = dt / FightModel.instance:getUISpeed()

	local cardFlow = FlowParallel.New()

	for index, itemGO in ipairs(context.hideSkillItemGOs) do
		if itemGO.activeSelf then
			cardFlow:addWork(TweenWork.New({
				from = 1,
				type = "DOFadeCanvasGroup",
				to = 0,
				go = itemGO,
				t = self._dt * 10
			}))
			cardFlow:addWork(FunctionWork.New(self._hideLockObj, self, index))
		end
	end

	self._flow = FlowSequence.New()

	self._flow:addWork(WorkWaitSeconds.New(0.5))
	self._flow:addWork(cardFlow)
	self._flow:registerDoneListener(self._onWorkDone, self)
	self._flow:start()
end

function FightCardDisplayHideAllEffect:_hideLockObj(index)
	local obj = self.context.hideSkillItemGOs[index]

	if obj then
		local lock = gohelper.findChild(obj.transform.parent.gameObject, "lock")

		gohelper.setActive(lock, false)
	end
end

function FightCardDisplayHideAllEffect:onStop()
	FightCardDisplayHideAllEffect.super.onStop(self)
	self._flow:unregisterDoneListener(self._onWorkDone, self)

	if self._flow.status == WorkStatus.Running then
		self._flow:stop()
	end
end

function FightCardDisplayHideAllEffect:_onWorkDone()
	self:onDone(true)
end

return FightCardDisplayHideAllEffect
