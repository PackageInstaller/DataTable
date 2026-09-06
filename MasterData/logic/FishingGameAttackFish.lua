-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameAttackFish.lua

module("logic.extensions.fishinggame.model.FishingGameAttackFish", package.seeall)

local FishingGameAttackFish = class("FishingGameAttackFish", FishingGameFish)
local ThrowGravity = 950
local AttackStartRotationZ = -90
local AttackHitRotationZ = 90
local AttackHitStayTime = 1

function FishingGameAttackFish:ctor()
	FishingGameAttackFish.super.ctor(self)

	self._attackPeakY = 0
	self._hasReachedAttackPeak = false
	self._attackHitTimer = 0
end

function FishingGameAttackFish:reset()
	FishingGameAttackFish.super.reset(self)

	self._attackPeakY = 0
	self._hasReachedAttackPeak = false
	self._attackHitTimer = 0
end

function FishingGameAttackFish:setState(state)
	local oldState = self._state

	FishingGameAttackFish.super.setState(self, state)

	if oldState == self._state or not self._containerCom then
		return
	end

	if self._state == FishingGameEnum.UnitState.Attack then
		self._containerCom:playAttackAnim()
	elseif self._state == FishingGameEnum.UnitState.Idle then
		self._containerCom:playDefaultAnim()
	end
end

function FishingGameAttackFish:interruptAttack()
	if self._state ~= FishingGameEnum.UnitState.Attack then
		return
	end

	self:resetAfterAttackMiss()
end

function FishingGameAttackFish:startAttack(targetX, targetY)
	self._attackBeforePos.x = self.position.x
	self._attackBeforePos.y = self.position.y
	self._attackPeakY = checknumber(targetY)
	self._hasReachedAttackPeak = false

	if self.position.y > self._attackPeakY then
		self:setPosition(self.position.x, self._attackPeakY)

		self._attackBeforePos.y = self.position.y
	end

	local dx = checknumber(targetX) - self.position.x
	local dy = self._attackPeakY - self.position.y

	if dx > 0 then
		self:setFishHorizontalDirect(FishingGameEnum.FishDirect.Right)
	elseif dx < 0 then
		self:setFishHorizontalDirect(FishingGameEnum.FishDirect.Left)
	end

	self:setState(FishingGameEnum.UnitState.Attack)

	self.rotationZ = AttackStartRotationZ

	if self._containerCom then
		self._containerCom:updateDirection(self.rotationY, self.rotationZ)
	end

	self._throwSpeedX = Mathf.Clamp(dx * 1.2, -500, 500)
	self._throwSpeedY = math.sqrt(math.max(0, 2 * ThrowGravity * dy))
	self._hasReachedAttackPeak = self._throwSpeedY <= 0
end

function FishingGameAttackFish:isAttackBackToOrigin()
	return self._state == FishingGameEnum.UnitState.Attack and self._throwSpeedY <= 0 and self.position.y <= self._attackBeforePos.y
end

function FishingGameAttackFish:startAttackHit(posX, posY)
	self:setState(FishingGameEnum.UnitState.AttackHit)

	self.rotationZ = AttackHitRotationZ
	self._attackHitTimer = AttackHitStayTime

	if posX and posY then
		self:setPosition(posX, posY)
	end

	if self._containerCom then
		self._containerCom:updateDirection(self.rotationY, self.rotationZ)
	end
end

function FishingGameAttackFish:updateAttackTargetPosition(posX, posY)
	if self._state ~= FishingGameEnum.UnitState.Attack then
		return
	end

	local dx = checknumber(posX) - self.position.x
	local dy = checknumber(posY) - self.position.y

	if dx == 0 and dy == 0 then
		return
	end

	self.rotationZ = math.deg(math.atan2(dy, dx)) - 180

	if self._containerCom then
		self._containerCom:updateDirection(self.rotationY, self.rotationZ)
	end
end

function FishingGameAttackFish:hasReachedAttackPeak()
	return self._hasReachedAttackPeak
end

function FishingGameAttackFish:isAttackHitFinished()
	return self._state == FishingGameEnum.UnitState.AttackHit and self._attackHitTimer <= 0
end

function FishingGameAttackFish:resetAfterAttackMiss()
	self:setState(FishingGameEnum.UnitState.Idle)
	self:setCanHook(true)
	self:setPosition(self.position.x, self._attackBeforePos.y)
end

function FishingGameAttackFish:update(deltaTime)
	deltaTime = checknumber(deltaTime)

	if not self:isActive() then
		return
	end

	if self._state == FishingGameEnum.UnitState.Idle then
		self:_updateIdle(deltaTime)
	elseif self._state == FishingGameEnum.UnitState.Throwing then
		self:_updateThrow(deltaTime)
	elseif self._state == FishingGameEnum.UnitState.Attack then
		self:_updateAttack(deltaTime)
	elseif self._state == FishingGameEnum.UnitState.AttackHit then
		self:_updateAttackHit(deltaTime)
	end

	if self._containerCom then
		self._containerCom:updateUI()
	end
end

function FishingGameAttackFish:_updateAttack(deltaTime)
	local nextY = self.position.y + self._throwSpeedY * deltaTime
	local nextSpeedY = self._throwSpeedY - ThrowGravity * deltaTime

	if not self._hasReachedAttackPeak and self._throwSpeedY > 0 and nextSpeedY <= 0 then
		nextY = self._attackPeakY
		nextSpeedY = 0
		self._hasReachedAttackPeak = true
	elseif not self._hasReachedAttackPeak and self._throwSpeedY <= 0 then
		self._hasReachedAttackPeak = true
	end

	self.position.x = self.position.x + self._throwSpeedX * deltaTime
	self.position.y = nextY
	self._throwSpeedY = nextSpeedY

	self:_syncRect()
end

function FishingGameAttackFish:_updateAttackHit(deltaTime)
	self._attackHitTimer = math.max(0, checknumber(self._attackHitTimer) - checknumber(deltaTime))
end

return FishingGameAttackFish
