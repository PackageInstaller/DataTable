-- chunkname: @modules/common/unit/UnitMoverParabola.lua

module("modules.common.unit.UnitMoverParabola", package.seeall)

local UnitMoverParabola = class("UnitMoverParabola", LuaCompBase)

function UnitMoverParabola:ctor(unit)
	self._speed = 0
	self._speedX = 0
	self._speedY = 0
	self._speedZ = 0
	self._gravity = 0
	self._posX = 0
	self._posY = 0
	self._posZ = 0
	self._wayPoint = nil
	self._getFrameFunction = nil
	self._getFrameObject = nil
	self._timeScale = 1

	LuaEventSystem.addEventMechanism(self)
end

function UnitMoverParabola:setPosDirectly(x, y, z)
	self:clearWayPoints()

	self._posX = x
	self._posY = y
	self._posZ = z

	self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
end

function UnitMoverParabola:setGetFrameFunction(getFrameFunction, getFrameObject)
	self._getFrameFunction = getFrameFunction
	self._getFrameObject = getFrameObject
	self._frame = 0
end

function UnitMoverParabola:getCurWayPoint()
	return self._wayPoint
end

function UnitMoverParabola:getPos()
	return self._posX, self._posY, self._posZ
end

function UnitMoverParabola:setWayPoint(x, y, z, horiSpeed, maxHeight)
	self._wayPoint = {
		x = x,
		y = y,
		z = z
	}

	self:_setHoriSpeed(horiSpeed)
	self:_calcSpeedYAndGravity(maxHeight)

	self._startMoveTime = Time.time

	self.dispatchEvent(self, UnitMoveEvent.StartMove, self)
end

function UnitMoverParabola:simpleMove(startX, startY, startZ, endX, endY, endZ, duration, height)
	self._duration = duration

	local distance = math.sqrt((startX - endX)^2 + (startY - endY)^2 + (startZ - endZ)^2)

	if distance <= 0 then
		logError(string.format("抛物线起始点和终点不能相等: startPos : (%s, %s, %s), endPos : (%s, %s, %s)", startX, startY, startZ, endX, endY, endZ))

		distance = 0.1
	end

	if distance > 0 then
		if not (distance / duration) then
			local speed = 100000000

			self:setPosDirectly(startX, startY, startZ)
			self:setWayPoint(endX, endY, endZ, speed, height)
		end
	end
end

function UnitMoverParabola:clearWayPoints()
	if self._wayPoint then
		self._wayPoint = nil

		self.dispatchEvent(self, UnitMoveEvent.Interrupt, self)
	end
end

function UnitMoverParabola:setTimeScale(timeScale)
	if timeScale > 0 then
		self._timeScale = timeScale
	else
		logError("argument illegal, timeScale = " .. timeScale)
	end
end

function UnitMoverParabola:_setHoriSpeed(speed)
	self._speed = speed

	if not self._wayPoint then
		self._speedX = 0
		self._speedZ = 0
	else
		local vx = self._wayPoint.x - self._posX
		local vz = self._wayPoint.z - self._posZ
		local length = math.sqrt(vx * vx + vz * vz)

		if length == 0 then
			logError("length is zero!")

			length = length + 0.1
		end

		vx = vx / length
		vz = vz / length
		self._speedX = vx * self._speed
		self._speedZ = vz * self._speed
	end
end

function UnitMoverParabola:_calcSpeedYAndGravity(maxHeight)
	maxHeight = ((self._posY >= self._wayPoint.y or nil) and (self._posY or self._wayPoint.y)) + maxHeight

	local horiDist = math.sqrt((self._posX - self._wayPoint.x)^2 + (self._posZ - self._wayPoint.z)^2)
	local t = horiDist / self._speed
	local s1 = maxHeight - self._posY
	local s2 = maxHeight - self._wayPoint.y
	local t1 = t / (1 + math.sqrt(s2 / s1))

	self._gravity = 2 * s1 / t1^2
	self._speedY = self._gravity * t1
end

function UnitMoverParabola:getDeltaTime()
	local curFrame, previousFrame, totalFrame = self._getFrameFunction(self._getFrameObject)

	if curFrame <= previousFrame then
		return 0
	end

	if totalFrame <= 0 then
		return self._duration
	end

	local deltaFrame = curFrame - math.max(previousFrame, self._frame)

	self._frame = curFrame

	return deltaFrame / totalFrame * (self._duration or 0)
end

function UnitMoverParabola:onUpdate()
	if self._wayPoint then
		local deltaTime = 0

		deltaTime = self._getFrameFunction and self:getDeltaTime() or Time.deltaTime * self._timeScale

		if deltaTime <= 0 then
			return
		end

		local newSpeed = self._speedY - self._gravity * deltaTime

		self._posY = self._posY + (newSpeed + self._speedY) / 2 * deltaTime

		if self._posY < self._wayPoint.y then
			self._posY = self._wayPoint.y or self._posY
		end

		self._speedY = newSpeed

		local nextPosX = self._posX + self._speedX * deltaTime
		local nextPosZ = self._posZ + self._speedZ * deltaTime
		local vecNowNextX = nextPosX - self._posX
		local vecNowNextZ = nextPosZ - self._posZ
		local vecNowDestX = self._wayPoint.x - self._posX
		local vecNowDestZ = self._wayPoint.z - self._posZ
		local distNext = vecNowNextX * vecNowNextX + vecNowNextZ * vecNowNextZ
		local distDest = vecNowDestX * vecNowDestX + vecNowDestZ * vecNowDestZ

		if distDest <= distNext then
			self._posX = self._wayPoint.x
			self._posZ = self._wayPoint.z
			self._wayPoint = nil

			self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
			self.dispatchEvent(self, UnitMoveEvent.Arrive, self)
		else
			self._posX = nextPosX
			self._posZ = nextPosZ

			self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
		end
	end
end

function UnitMoverParabola:onDestroy()
	self._wayPoint = nil
end

return UnitMoverParabola
