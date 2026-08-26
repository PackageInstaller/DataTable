-- chunkname: @modules/logic/versionactivity3_9/bird/model/V3a9BirdMO.lua

module("modules.logic.versionactivity3_9.bird.model.V3a9BirdMO", package.seeall)

local V3a9BirdMO = pureTable("V3a9BirdMO")

function V3a9BirdMO:ctor()
	self._gravity = 0
	self._flapVelocity = 0
	self._maxFallSpeed = 0
	self._posY = 0
	self._velocityY = 0
	self._birdSize = 150
end

function V3a9BirdMO:initMo()
	self._posY = 0
	self._velocityY = 0

	self:refreshParam()
end

function V3a9BirdMO:refreshParam()
	self._gravity = V3a9BirdModel.instance:getGameParam(V3a9BirdEnum.BirdConst.gravity)
	self._flapVelocity = V3a9BirdModel.instance:getGameParam(V3a9BirdEnum.BirdConst.flapVelocity)
	self._maxFallSpeed = V3a9BirdModel.instance:getGameParam(V3a9BirdEnum.BirdConst.maxFallSpeed)
end

function V3a9BirdMO:updateFrame(dt)
	self._velocityY = self._velocityY + self._gravity * dt

	if self._velocityY < -self._maxFallSpeed then
		self._velocityY = -self._maxFallSpeed
	end

	self._posY = self._posY - self._velocityY * dt
end

function V3a9BirdMO:flap()
	self._velocityY = self._flapVelocity
end

function V3a9BirdMO:getPosY()
	return self._posY
end

function V3a9BirdMO:setPosY(y)
	self._posY = y
end

function V3a9BirdMO:getPosX()
	return self._posX or 0
end

function V3a9BirdMO:setPosX(x)
	self._posX = x
end

function V3a9BirdMO:getBirdRect()
	self._birdRect = self._birdRect or {}

	local halfSize = self._birdSize * 0.5

	self._birdRect.left = self._posX - halfSize
	self._birdRect.right = self._posX + halfSize
	self._birdRect.top = self._posY + halfSize
	self._birdRect.bottom = self._posY - halfSize

	return self._birdRect
end

return V3a9BirdMO
