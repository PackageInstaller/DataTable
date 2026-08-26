-- chunkname: @modules/logic/fight/view/cardeffect/FightDeviceCardDisplayEndEffect.lua

module("modules.logic.fight.view.cardeffect.FightDeviceCardDisplayEndEffect", package.seeall)

local FightDeviceCardDisplayEndEffect = class("FightDeviceCardDisplayEndEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033

function FightDeviceCardDisplayEndEffect:onStart(context)
	FightDeviceCardDisplayEndEffect.super.onStart(self, context)

	self._dt = dt / FightModel.instance:getUISpeed()
	self._flow = FlowSequence.New()

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

	local hideWork = FunctionWork.New(FightDeviceCardDisplayEndEffect.hideFunc, self)

	self._flow:addWork(hideWork)

	local hideFrameWork = FunctionWork.New(FightDeviceCardDisplayEndEffect.onSingleSkillDone, self)

	self._flow:addWork(hideFrameWork)
	self._flow:registerDoneListener(self._onWorkDone, self)
	self._flow:start()
end

function FightDeviceCardDisplayEndEffect:hideFunc()
	gohelper.setActive(self.context.skillTipsGO, false)
end

function FightDeviceCardDisplayEndEffect:onSingleSkillDone()
	FightController.instance:dispatchEvent(FightEvent.OnDevice_SingleSkillDone)
end

function FightDeviceCardDisplayEndEffect:onStop()
	FightDeviceCardDisplayEndEffect.super.onStop(self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onWorkDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

function FightDeviceCardDisplayEndEffect:_onWorkDone()
	self:onDone(true)
end

return FightDeviceCardDisplayEndEffect
