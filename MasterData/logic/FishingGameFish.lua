-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameFish.lua

module("logic.extensions.fishinggame.model.FishingGameFish", package.seeall)

local FishingGameFish = class("FishingGameFish", FishingGameUnit)
local ThrowGravity = 950
local ThrowSpeedY = 720

function FishingGameFish:ctor()
	FishingGameFish.super.ctor(self)

	self.rotationY = 0
	self.rotationZ = 0
	self.fishHorizontalDirect = FishingGameEnum.FishDirect.Left
	self._directChangeTimer = 0
	self._stunTimer = 0
	self._originPos = {
		x = 0,
		y = 0
	}
	self._throwSpeedX = 0
	self._throwSpeedY = 0
	self._hookBeforePos = {
		x = 0,
		y = 0
	}
	self._attackBeforePos = {
		x = 0,
		y = 0
	}
	self._canHook = true
	self.offsetX = 0
	self.offsetY = 0
	self._throwPeakY = 0
	self._hasReachedThrowPeak = false
end

function FishingGameFish:reset()
	FishingGameFish.super.reset(self)

	self.fishPlanId = 0
	self.fishId = 0
	self.score = 0
	self.effectNum = 0
	self.resPath = ""
	self.spinePath = ""
	self.spineScale = 0
	self.offsetX = 0
	self.offsetY = 0
	self.speed = 0
	self.rotationY = 0
	self.rotationZ = 0
	self.fishHorizontalDirect = FishingGameEnum.FishDirect.Left
	self._directChangeTimer = 0
	self._stunTimer = 0
	self._originPos.x = 0
	self._originPos.y = 0
	self._throwSpeedX = 0
	self._throwSpeedY = 0
	self._hookBeforePos.x = 0
	self._hookBeforePos.y = 0
	self._attackBeforePos.x = 0
	self._attackBeforePos.y = 0
	self._canHook = true
	self._throwPeakY = 0
	self._hasReachedThrowPeak = false

	self:_syncRect()
end

function FishingGameFish:setFishCfg(fishPlanId, cfg, unitType)
	self.fishPlanId = checknumber(fishPlanId)
	self.fishId = cfg and checknumber(cfg.fishId) or 0
	self._unitType = unitType or cfg and checknumber(cfg.type) or FishingGameEnum.FishType.Fish
	self.width = cfg and checknumber(cfg.width) or 100
	self.height = cfg and checknumber(cfg.height) or 100
	self.score = cfg and checknumber(cfg.score) or 0
	self.effectNum = cfg and checknumber(cfg.effectNum) or 0

	if cfg then
		self.resPath = cfg.resPath or ""
	end

	if cfg then
		self.spinePath = cfg.spinePath or ""
	end

	self.spineScale = cfg and checknumber(cfg.spineScale) or 0
	self.offsetX = cfg and checknumber(cfg.offsetX) or 0
	self.offsetY = cfg and checknumber(cfg.offsetY) or 0
	self.speed = cfg and checknumber(cfg.speed) or 0
	self.rotationY = 0
	self.rotationZ = 0
	self.fishHorizontalDirect = FishingGameEnum.FishDirect.Left
	self._directChangeTimer = 0
	self._isActive = true
	self._state = FishingGameEnum.UnitState.Idle
	self._canHook = true
	self._throwPeakY = 0
	self._hasReachedThrowPeak = false

	self:_syncRect()
end

function FishingGameFish:setFishId(fishPlanId, fishId)
	local fishCfg = FishingGameConfig.instance:getFishCfg(fishPlanId, fishId)

	self:setFishCfg(fishPlanId, fishCfg, (fishCfg or nil) and (fishCfg.type or nil))
end

function FishingGameFish:setState(state)
	FishingGameFish.super.setState(self, state)

	if self._state ~= FishingGameEnum.UnitState.Hooked then
		self.rotationZ = 0
	end
end

function FishingGameFish:setOriginPosition(posX, posY)
	self._originPos.x = checknumber(posX)
	self._originPos.y = checknumber(posY)

	self:setPosition(posX, posY)
end

function FishingGameFish:resetToOrigin()
	self:setState(FishingGameEnum.UnitState.Idle)
	self:setActive(true)
	self:setPosition(self._originPos.x, self._originPos.y)
end

function FishingGameFish:setFishHorizontalDirect(horizontalDirect)
	self.fishHorizontalDirect = horizontalDirect
	self.rotationY = horizontalDirect == FishingGameEnum.FishDirect.Right and 180 or 0

	self:_syncRect()

	if self._containerCom then
		self._containerCom:updateDirection(self.rotationY, self.rotationZ)
	end

	if self._directChangeTimer <= 0 then
		self._directChangeTimer = math.random(3, 6)
	end
end

function FishingGameFish:setStunTimer(timer)
	self._stunTimer = math.max(checknumber(self._stunTimer), checknumber(timer))
end

function FishingGameFish:isStunned()
	return checknumber(self._stunTimer) > 0
end

function FishingGameFish:interruptAttack()
	return
end

function FishingGameFish:isCanHook()
	local var_12_0 = self:isActive()

	if var_12_0 then
		var_12_0 = self._canHook and self._state == FishingGameEnum.UnitState.Idle
	end

	return var_12_0
end

function FishingGameFish:setCanHook(canHook)
	self._canHook = canHook

	if self._containerCom then
		self._containerCom:setGray(not canHook)
	end
end

function FishingGameFish:setLimitTreasureTimer(openTimer, countDownTimer)
	return
end

function FishingGameFish:isLimitTreasureExpired()
	return false
end

function FishingGameFish:isMovingFish()
	return true
end

function FishingGameFish:getHookFreezeTimer()
	return 0
end

function FishingGameFish:shouldInterruptAttackOnHook()
	return false
end

function FishingGameFish:getReachWaterStunTimer()
	return 0
end

function FishingGameFish:shouldDestroyOnReachWater()
	return false
end

function FishingGameFish:shouldResetToOriginAfterThrow()
	return false
end

function FishingGameFish:getHookPriority()
	return 4000 - checknumber(self.fishId)
end

function FishingGameFish:isIdleOutOfScene(sceneMinX, sceneMaxX, sceneMaxY)
	return self.position.x < sceneMinX - self.width or self.position.x > sceneMaxX + self.width or self.position.y > sceneMaxY + self.height
end

function FishingGameFish:startHooked()
	self._hookBeforePos.x = self.position.x
	self._hookBeforePos.y = self.position.y

	self:setState(FishingGameEnum.UnitState.Hooked)
	self:setCanHook(false)
end

function FishingGameFish:getHookBeforeY()
	return self._hookBeforePos.y
end

function FishingGameFish:resetAfterThrowMiss()
	self:setState(FishingGameEnum.UnitState.Idle)
	self:setCanHook(true)
	self:setPosition(self.position.x, self._hookBeforePos.y)

	if self._throwSpeedX > 0 then
		self:setFishHorizontalDirect(FishingGameEnum.FishDirect.Right)
	elseif self._throwSpeedX < 0 then
		self:setFishHorizontalDirect(FishingGameEnum.FishDirect.Left)
	end
end

function FishingGameFish:updateHookedPosition(posX, posY, lineRotationZ, targetX)
	self:_updateHookRotation(posX, targetX, lineRotationZ)

	local centerX, centerY = self:_getHookedCenterPosition(posX, posY)

	self:setPosition(centerX, centerY)

	if self._containerCom then
		self._containerCom:updatePosition(self.position.x, self.position.y)
		self._containerCom:updateDirection(self.rotationY, self.rotationZ)
	end
end

function FishingGameFish:_updateHookRotation(posX, targetX, lineRotationZ)
	local dx = checknumber(targetX) - checknumber(posX)

	if dx > 0 then
		self.rotationY = 180
	elseif dx < 0 then
		self.rotationY = 0
	end

	self.rotationZ = checknumber(lineRotationZ)
end

function FishingGameFish:_getHookedCenterPosition(hookX, hookY)
	local halfWidth = checknumber(self.width) * 0.5
	local offsetX = self.rotationY == 180 and -checknumber(self.offsetX) or checknumber(self.offsetX)
	local mouthOffsetX = self.rotationY == 180 and halfWidth or -halfWidth
	local localMouthX = offsetX + mouthOffsetX
	local localMouthY = self.rotationY == 180 and checknumber(self.offsetY) or -checknumber(self.offsetY)
	local rotationZ = math.rad(checknumber(self.rotationZ))
	local centerX = checknumber(hookX) - (math.cos(rotationZ) * localMouthX - math.sin(rotationZ) * localMouthY)
	local centerY = checknumber(hookY) - (math.sin(rotationZ) * localMouthX + math.cos(rotationZ) * localMouthY)

	return centerX, centerY
end

function FishingGameFish:startThrow(targetX, targetY)
	self:setState(FishingGameEnum.UnitState.Throwing)

	local dx = checknumber(targetX) - self.position.x

	self._throwPeakY = targetY and checknumber(targetY) or self.position.y + ThrowSpeedY * ThrowSpeedY / (2 * ThrowGravity)
	self._hasReachedThrowPeak = false

	if self.position.y > self._throwPeakY then
		self:setPosition(self.position.x, self._throwPeakY)
	end

	local dy = self._throwPeakY - self.position.y

	self._throwSpeedX = Mathf.Clamp(dx * 1.2, -700, 700)
	self._throwSpeedY = math.sqrt(math.max(0, 2 * ThrowGravity * dy))
	self._hasReachedThrowPeak = self._throwSpeedY <= 0
end

function FishingGameFish:isThrowFalling()
	return self._state == FishingGameEnum.UnitState.Throwing and self._throwSpeedY <= 0
end

function FishingGameFish:startAttack(targetX, targetY)
	return
end

function FishingGameFish:isAttackBackToOrigin()
	return false
end

function FishingGameFish:startAttackHit(posX, posY)
	return
end

function FishingGameFish:updateAttackTargetPosition(posX, posY)
	return
end

function FishingGameFish:hasReachedAttackPeak()
	return false
end

function FishingGameFish:isAttackHitFinished()
	return false
end

function FishingGameFish:resetAfterAttackMiss()
	return
end

function FishingGameFish:update(deltaTime)
	deltaTime = checknumber(deltaTime)

	if not self:isActive() then
		return
	end

	if self._state == FishingGameEnum.UnitState.Idle then
		self:_updateIdle(deltaTime)
	elseif self._state == FishingGameEnum.UnitState.Throwing then
		self:_updateThrow(deltaTime)
	end

	if self._containerCom then
		self._containerCom:updateUI()
	end
end

function FishingGameFish:_updateIdle(deltaTime)
	if self._stunTimer > 0 then
		self._stunTimer = math.max(0, self._stunTimer - deltaTime)

		return
	end

	self._directChangeTimer = self._directChangeTimer - deltaTime

	if self._directChangeTimer <= 0 then
		self._directChangeTimer = math.random(3, 6)

		if math.random(1, 2) == 1 then
			self:setFishHorizontalDirect(FishingGameEnum.FishDirect.Left)
		else
			self:setFishHorizontalDirect(FishingGameEnum.FishDirect.Right)
		end
	end

	self.position.x = self.position.x + self.fishHorizontalDirect * self.speed * deltaTime

	self:_syncRect()
end

function FishingGameFish:_updateThrow(deltaTime)
	local nextY = self.position.y + self._throwSpeedY * deltaTime
	local nextSpeedY = self._throwSpeedY - ThrowGravity * deltaTime

	if not self._hasReachedThrowPeak and self._throwSpeedY > 0 and nextSpeedY <= 0 then
		nextY = self._throwPeakY
		nextSpeedY = 0
		self._hasReachedThrowPeak = true
	elseif not self._hasReachedThrowPeak and self._throwSpeedY <= 0 then
		self._hasReachedThrowPeak = true
	end

	self.position.x = self.position.x + self._throwSpeedX * deltaTime
	self.position.y = nextY
	self._throwSpeedY = nextSpeedY

	self:_syncRect()
end

function FishingGameFish:_syncRect()
	local offsetX = self.rotationY == 180 and -checknumber(self.offsetX) or checknumber(self.offsetX)
	local offsetY = self.rotationY == 180 and checknumber(self.offsetY) or -checknumber(self.offsetY)

	self.rect.x = self.position.x + offsetX - self.width * 0.5
	self.rect.y = self.position.y + offsetY - self.height * 0.5
	self.rect.w = self.width
	self.rect.h = self.height
end

return FishingGameFish
