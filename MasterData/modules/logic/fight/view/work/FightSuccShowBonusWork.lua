-- chunkname: @modules/logic/fight/view/work/FightSuccShowBonusWork.lua

module("modules.logic.fight.view.work.FightSuccShowBonusWork", package.seeall)

local FightSuccShowBonusWork = class("FightSuccShowBonusWork", BaseWork)
local BONUS_TWEEN_TIME_OFFSET = 0.2

function FightSuccShowBonusWork:ctor(bonusGOList, containerGODict, delayTime, itemDelay)
	self:initParam(bonusGOList, containerGODict, delayTime, itemDelay)
end

function FightSuccShowBonusWork:initParam(bonusGOList, containerGODict, delayTime, itemDelay)
	self._bonusGOList = bonusGOList

	if self._bonusGOList then
		self._bonusGOCount = #self._bonusGOList or 0
	end

	self._containerGODict = containerGODict
	self._delayTime = delayTime
	self._itemDelay = itemDelay
end

function FightSuccShowBonusWork:onStart()
	if self._bonusGOCount <= 0 then
		self:onDone(true)

		return
	end

	local time = (self._bonusGOCount - 1) * self._delayTime + self._itemDelay + BONUS_TWEEN_TIME_OFFSET

	self._bonusTweenId = ZProj.TweenHelper.DOTweenFloat(0, time, time, self._bonusTweenFrame, self._bonusTweenFinish, self, nil, EaseType.Linear)
end

function FightSuccShowBonusWork:_bonusTweenFrame(value)
	for i, bonusGO in ipairs(self._bonusGOList) do
		if value >= (i - 1) * self._delayTime then
			gohelper.setActive(bonusGO, true)
		end
	end

	for time, containerGO in pairs(self._containerGODict) do
		if time <= value then
			gohelper.setActive(containerGO, true)
		end
	end
end

function FightSuccShowBonusWork:_bonusTweenFinish()
	for _, bonusGO in ipairs(self._bonusGOList) do
		gohelper.setActive(bonusGO, true)
	end

	for _, containerGO in pairs(self._containerGODict) do
		gohelper.setActive(containerGO, true)
	end

	self:onDone(true)
end

function FightSuccShowBonusWork:clearWork()
	if self._bonusTweenId then
		ZProj.TweenHelper.KillById(self._bonusTweenId)
	end

	self:initParam()
end

return FightSuccShowBonusWork
