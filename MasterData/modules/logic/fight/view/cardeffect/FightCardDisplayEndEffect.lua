-- chunkname: @modules/logic/fight/view/cardeffect/FightCardDisplayEndEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardDisplayEndEffect", package.seeall)

local FightCardDisplayEndEffect = class("FightCardDisplayEndEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033

function FightCardDisplayEndEffect:onStart(context)
	FightCardDisplayEndEffect.super.onStart(self, context)

	self._dt = dt / FightModel.instance:getUISpeed()
	self._flow = FlowSequence.New()

	if context.skillItemGO then
		local canFade = true
		local param = context.param

		if param then
			if param.noCardFade then
				canFade = false
			end

			local skillId = param.skillId

			if skillId and FightHelper.checkIsDevicePowerCard(skillId) then
				canFade = false
			end
		end

		if canFade then
			local fadeWork = TweenWork.New({
				from = 1,
				type = "DOFadeCanvasGroup",
				to = 0,
				go = context.skillItemGO,
				t = self._dt * 5
			})

			self._flow:addWork(fadeWork)
		end
	end

	if SettingsModel.instance:getFightCardDetail() then
		local waitTr = context.waitingAreaGO.transform
		local tipsTr = context.skillTipsGO.transform
		local width = recthelper.getWidth(waitTr) + recthelper.getWidth(tipsTr)
		local tipsWork = TweenWork.New({
			type = "DOAnchorPosX",
			tr = tipsTr,
			to = width,
			t = self._dt * 3
		})

		self._flow:addWork(tipsWork)
	end

	local hideWork = FunctionWork.New(function()
		gohelper.setActive(context.skillItemGO, false)
		gohelper.setActive(context.skillTipsGO, false)
	end)

	self._flow:addWork(hideWork)
	self._flow:registerDoneListener(self._onWorkDone, self)
	self._flow:start()
end

function FightCardDisplayEndEffect:onStop()
	FightCardDisplayEndEffect.super.onStop(self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onWorkDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

function FightCardDisplayEndEffect:_onWorkDone()
	self:onDone(true)
end

return FightCardDisplayEndEffect
