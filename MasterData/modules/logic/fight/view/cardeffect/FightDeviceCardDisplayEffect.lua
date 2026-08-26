-- chunkname: @modules/logic/fight/view/cardeffect/FightDeviceCardDisplayEffect.lua

module("modules.logic.fight.view.cardeffect.FightDeviceCardDisplayEffect", package.seeall)

local FightDeviceCardDisplayEffect = class("FightDeviceCardDisplayEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033
local TipAnchorOffsetX = 80

function FightDeviceCardDisplayEffect:onStart(context)
	FightDeviceCardDisplayEffect.super.onStart(self, context)

	self._dt = dt / FightModel.instance:getUISpeed()

	gohelper.setActive(context.skillTipsGO, true)

	local tipsTr = context.skillTipsGO.transform
	local tipsWidth = recthelper.getWidth(tipsTr)
	local tipsPosX = FightViewWaitingAreaVersion1.getDeviceAnchorXByServerData()

	tipsPosX = tipsPosX - FightDeviceHelper.getDeviceAreaTotalWidth() - TipAnchorOffsetX

	recthelper.setAnchorX(tipsTr, 1100 + tipsWidth)

	self._flow = FlowParallel.New()

	if SettingsModel.instance:getFightCardDetail() then
		local tipsSequence = FlowSequence.New()

		tipsSequence:addWork(TweenWork.New({
			type = "DOAnchorPosX",
			tr = tipsTr,
			to = tipsPosX - 10,
			t = self._dt * 7
		}))
		tipsSequence:addWork(TweenWork.New({
			type = "DOAnchorPosX",
			tr = tipsTr,
			to = tipsPosX,
			t = self._dt * 3
		}))
		self._flow:addWork(tipsSequence)
	end

	local itemTr = context.skillItemGO.transform
	local itemAnchorSequence = FlowSequence.New()

	itemAnchorSequence:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tox = -15,
		toy = 22,
		tr = itemTr,
		t = self._dt * 6
	}))
	self._flow:addWork(itemAnchorSequence)

	local itemScaleSequence = FlowSequence.New()

	itemScaleSequence:addWork(TweenWork.New({
		to = 1.2,
		type = "DOScale",
		tr = itemTr,
		t = self._dt * 3
	}))
	self._flow:addWork(itemScaleSequence)
	self._flow:registerDoneListener(self._onWorkDone, self)
	self._flow:start()
end

function FightDeviceCardDisplayEffect:onStop()
	FightDeviceCardDisplayEffect.super.onStop(self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onWorkDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

function FightDeviceCardDisplayEffect:_onWorkDone()
	self:onDone(true)
end

return FightDeviceCardDisplayEffect
