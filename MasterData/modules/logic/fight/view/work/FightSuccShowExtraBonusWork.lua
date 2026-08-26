-- chunkname: @modules/logic/fight/view/work/FightSuccShowExtraBonusWork.lua

module("modules.logic.fight.view.work.FightSuccShowExtraBonusWork", package.seeall)

local FightSuccShowExtraBonusWork = class("FightSuccShowExtraBonusWork", BaseWork)
local START_SHOW_TIME = 0.05
local SHOW_EFFECT_TIME = 0.05
local MOVE_TIME = 0.45
local BONUS_WIDTH = 175
local BONUS_TWEEN_TIME_OFFSET = 0.5

function FightSuccShowExtraBonusWork:ctor(bonusGOList, containerGODict, showEffectCb, showEffectCbObj, moveBonusGOList, bonusItemContainer, delayTime, itemDelay)
	self:initParam(bonusGOList, containerGODict, showEffectCb, showEffectCbObj, moveBonusGOList, bonusItemContainer, delayTime, itemDelay)
end

function FightSuccShowExtraBonusWork:initParam(bonusGOList, containerGODict, showEffectCb, showEffectCbObj, moveBonusGOList, bonusItemContainer, delayTime, itemDelay)
	self._bonusGOList = bonusGOList

	if self._bonusGOList then
		self._bonusGOCount = #self._bonusGOList or 0
	end

	self._containerGODict = containerGODict
	self._showEffectCb = showEffectCb
	self._showEffectCbObj = showEffectCbObj
	self._moveBonusGOList = moveBonusGOList
	self._delayTime = delayTime
	self._itemDelay = itemDelay
	self._bonusItemContainer = bonusItemContainer
end

function FightSuccShowExtraBonusWork:onStart()
	if self._bonusGOCount <= 0 then
		self:onDone(true)

		return
	end

	self:_moveBonus()
end

function FightSuccShowExtraBonusWork:_moveBonus()
	for _, bonusGO in ipairs(self._moveBonusGOList) do
		local t = bonusGO.transform

		t.parent = t.parent.parent

		local curX = recthelper.getAnchorX(t)
		local targetX = curX + self._bonusGOCount * BONUS_WIDTH

		ZProj.TweenHelper.DOAnchorPosX(t, targetX, MOVE_TIME, nil, nil, nil, EaseType.InOutCubic)
	end

	TaskDispatcher.runDelay(self._startShowBonus, self, START_SHOW_TIME)

	if self._showEffectCb then
		TaskDispatcher.runDelay(self._showEffectCb, self._showEffectCbObj, SHOW_EFFECT_TIME)
	end
end

function FightSuccShowExtraBonusWork:_startShowBonus()
	local time = (self._bonusGOCount - 1) * self._delayTime + self._itemDelay + BONUS_TWEEN_TIME_OFFSET

	self._bonusTweenId = ZProj.TweenHelper.DOTweenFloat(0, time, time, self._bonusTweenFrame, self._bonusTweenFinish, self, nil, EaseType.Linear)
end

function FightSuccShowExtraBonusWork:_bonusTweenFrame(value)
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

function FightSuccShowExtraBonusWork:_bonusTweenFinish()
	local copyList = {}

	for _, bonusGO in ipairs(self._bonusGOList) do
		gohelper.setActive(bonusGO, true)
		table.insert(copyList, bonusGO)
	end

	for _, containerGO in pairs(self._containerGODict) do
		gohelper.setActive(containerGO, true)
	end

	for _, bonusGO in ipairs(self._moveBonusGOList) do
		table.insert(copyList, bonusGO)
	end

	self._moveBonusGOList = copyList

	self:_moveBonusDone()
	self:onDone(true)
end

function FightSuccShowExtraBonusWork:_moveBonusDone()
	for _, bonusGO in ipairs(self._moveBonusGOList) do
		local t = bonusGO.transform

		t.parent = self._bonusItemContainer.transform
	end
end

function FightSuccShowExtraBonusWork:clearWork()
	if self._bonusTweenId then
		ZProj.TweenHelper.KillById(self._bonusTweenId)
	end

	TaskDispatcher.cancelTask(self._startShowBonus, self)

	if self._showEffectCb then
		TaskDispatcher.cancelTask(self._showEffectCb, self._showEffectCbObj)
	end

	self:initParam()
end

return FightSuccShowExtraBonusWork
