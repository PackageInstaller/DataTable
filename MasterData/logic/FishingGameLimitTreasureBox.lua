-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameLimitTreasureBox.lua

module("logic.extensions.fishinggame.model.FishingGameLimitTreasureBox", package.seeall)

local FishingGameLimitTreasureBox = class("FishingGameLimitTreasureBox", FishingGameFish)

function FishingGameLimitTreasureBox:ctor()
	FishingGameLimitTreasureBox.super.ctor(self)

	self._openTimer = 0
	self._countDownTimer = 0
	self._isLimitTreasureOpened = true
end

function FishingGameLimitTreasureBox:reset()
	FishingGameLimitTreasureBox.super.reset(self)

	self._openTimer = 0
	self._countDownTimer = 0
	self._isLimitTreasureOpened = true
end

function FishingGameLimitTreasureBox:setFishCfg(fishPlanId, cfg, unitType)
	FishingGameLimitTreasureBox.super.setFishCfg(self, fishPlanId, cfg, unitType)

	self._isLimitTreasureOpened = true
end

function FishingGameLimitTreasureBox:isMovingFish()
	return false
end

function FishingGameLimitTreasureBox:getHookPriority()
	return 3000
end

function FishingGameLimitTreasureBox:isIdleOutOfScene(sceneMinX, sceneMaxX, sceneMaxY, waterY)
	return false
end

function FishingGameLimitTreasureBox:setLimitTreasureTimer(openTimer, countDownTimer)
	self._openTimer = checknumber(openTimer)
	self._countDownTimer = checknumber(countDownTimer)
	self._isLimitTreasureOpened = self._openTimer <= 0

	self:setCanHook(self._isLimitTreasureOpened)

	if self._containerCom then
		self._containerCom:updateUI()
	end
end

function FishingGameLimitTreasureBox:isLimitTreasureExpired()
	return self._isLimitTreasureOpened and self._countDownTimer <= 0
end

function FishingGameLimitTreasureBox:update(deltaTime)
	deltaTime = checknumber(deltaTime)

	if not self:isActive() then
		return
	end

	self:_updateLimitTreasure(deltaTime)

	if self._state == FishingGameEnum.UnitState.Throwing then
		self:_updateThrow(deltaTime)
	end

	if self._containerCom then
		self._containerCom:updateUI()
	end
end

function FishingGameLimitTreasureBox:_updateIdle(deltaTime)
	return
end

function FishingGameLimitTreasureBox:_updateLimitTreasure(deltaTime)
	if not self._isLimitTreasureOpened then
		self._openTimer = self._openTimer - deltaTime

		if self._openTimer <= 0 then
			self._isLimitTreasureOpened = true

			self:setCanHook(true)
		end
	elseif self._countDownTimer > 0 then
		self._countDownTimer = self._countDownTimer - deltaTime
	end
end

return FishingGameLimitTreasureBox
