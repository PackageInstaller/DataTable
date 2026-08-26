-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgDragging_EditEnergyWork.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgDragging_EditEnergyWork", package.seeall)

local kMaxWidth = 756
local CSTweenHelper = ZProj.TweenHelper
local ChgDragging_EditEnergyWork = class("ChgDragging_EditEnergyWork", GaoSiNiaoWorkBase)

function ChgDragging_EditEnergyWork.s_create(fromEnergy, toEnergy, durationSec)
	local work = ChgDragging_EditEnergyWork.New()

	work._fromEnergy = fromEnergy
	work._toEnergy = toEnergy
	work._durationSec = durationSec or 0.3

	return work
end

function ChgDragging_EditEnergyWork:onStart()
	self:clearWork()

	if not self._fromEnergy or not self._toEnergy then
		self:onSucc()

		return
	end

	if self._fromEnergy == self._toEnergy then
		self:_displayEnergy(self._toEnergy)
		self:onSucc()
	else
		self._fromEnergy = self._fromEnergy or self:_getUIEnergy()

		self:_tweenEnergy()
	end
end

function ChgDragging_EditEnergyWork:_getUIEnergy()
	local toFillAmount = recthelper.getWidth(self.root:Image_SliderFGTran()) / kMaxWidth

	return self.root:calcEnergy(toFillAmount)
end

function ChgDragging_EditEnergyWork:_displayEnergy(toEnergy)
	local toFillAmount = self.root:calcEnergy01(toEnergy)

	self.root:setText_txtCount(toEnergy)

	local width = toFillAmount * kMaxWidth

	recthelper.setWidth(self.root:Image_SliderFGTran(), width)
end

local eEaseType = EaseType.Linear

function ChgDragging_EditEnergyWork:_tweenEnergy()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")

	self._tweenId = CSTweenHelper.DOTweenFloat(self._fromEnergy, self._toEnergy, self._durationSec, self._onTweenTick, self._onTweenFinished, self, nil, eEaseType)
end

function ChgDragging_EditEnergyWork:_onTweenTick(energy)
	local toFillAmount = self.root:calcEnergy01(energy)

	self.root:setText_txtCount(math.floor(energy))

	local width = toFillAmount * kMaxWidth

	recthelper.setWidth(self.root:Image_SliderFGTran(), width)
end

function ChgDragging_EditEnergyWork:_onTweenFinished()
	self:_displayEnergy(self._toEnergy)
	self:onSucc()
end

function ChgDragging_EditEnergyWork:clearWork()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
end

return ChgDragging_EditEnergyWork
