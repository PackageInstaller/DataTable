-- chunkname: @modules/common/unit/UnitMoverMmo.lua

module("modules.common.unit.UnitMoverMmo", package.seeall)

local UnitMoverMmo = class("UnitMoverMmo", LuaCompBase)

function UnitMoverMmo:ctor(unit)
	self._speed = 0
	self._speedX = 0
	self._speedY = 0
	self._speedZ = 0
	self._posX = 0
	self._posY = 0
	self._posZ = 0
	self._wpPool = LuaObjPool.New(100, function()
		return {}
	end, function(a)
		return
	end, function(a)
		return
	end)
	self._wayPoints = {}
	self._curWayPoint = nil
	self._accerationTime = 0
	self._startMoveTime = 0

	LuaEventSystem.addEventMechanism(self)
end

function UnitMoverMmo:simpleMove(startX, startY, startZ, endX, endY, endZ, duration)
	local distance = math.sqrt((startX - endX)^2 + (startY - endY)^2 + (startZ - endZ)^2)

	if distance > 0 then
		if not (distance / duration) then
			local speed = 100000000

			self:setSpeed(speed)
			self:setPosDirectly(startX, startY, startZ)
			self:addWayPoint(endX, endY, endZ)
		end
	end
end

function UnitMoverMmo:setPosDirectly(x, y, z)
	self:clearWayPoints()

	self._posX = x
	self._posY = y
	self._posZ = z

	self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
end

function UnitMoverMmo:getCurWayPoint()
	return self._curWayPoint
end

function UnitMoverMmo:getPos()
	return self._posX, self._posY, self._posZ
end

function UnitMoverMmo:setSpeed(speed)
	self._speed = speed

	if not self._curWayPoint then
		self._speedX = 0
		self._speedY = 0
		self._speedZ = 0
	else
		local vx = self._curWayPoint.x - self._posX
		local vy = self._curWayPoint.y - self._posY
		local vz = self._curWayPoint.z - self._posZ
		local length = math.sqrt(vx * vx + vy * vy + vz * vz)

		vx = vx / length
		vy = vy / length
		vz = vz / length
		self._speedX = vx * self._speed
		self._speedY = vy * self._speed
		self._speedZ = vz * self._speed
	end
end

function UnitMoverMmo:setTimeScale(timeScale)
	if timeScale > 0 then
		self:setSpeed(self._speed * timeScale)
	else
		logError("argument illegal, timeScale = " .. timeScale)
	end
end

function UnitMoverMmo:setAccelerationTime(time)
	self._accerationTime = time
end

function UnitMoverMmo:getAccelerationTime()
	return self._accerationTime
end

function UnitMoverMmo:setWayPoint(x, y, z)
	if not self._wayPoints then
		return
	end

	local len = #self._wayPoints

	for i = 1, len do
		self._wpPool:putObject(self._wayPoints[i])

		self._wayPoints[i] = nil
	end

	local wp = self._wpPool:getObject()

	wp.x = x
	wp.y = y
	wp.z = z

	self:_setNewWayPoint(wp)
end

function UnitMoverMmo:addWayPoint(x, y, z, duration)
	if self._posX == x and self._posY == y and self._posZ == z then
		if not self._curWayPoint then
			return
		elseif self._curWayPoint.x == x and self._curWayPoint.y == y and self._curWayPoint.z == z then
			return
		end
	end

	local wp = self._wpPool:getObject()

	wp.x = x
	wp.y = y
	wp.z = z

	if duration then
		local distance = 0

		if self._curWayPoint and self._curWayPoint[1] then
			local lastPos = self._curWayPoint[#self._curWayPoint]

			distance = math.sqrt((lastPos.x - x)^2 + (lastPos.y - y)^2 + (lastPos.z - z)^2)
		else
			distance = math.sqrt((self._posX - x)^2 + (self._posY - y)^2 + (self._posZ - z)^2)
		end

		if distance > 0 then
			wp.speed = distance / duration or 100000000
		end
	end

	if not self._curWayPoint then
		self:_setNewWayPoint(wp)
	else
		table.insert(self._wayPoints, wp)
	end
end

function UnitMoverMmo:clearWayPoints()
	local len = #self._wayPoints

	for i = 1, len do
		self._wpPool:putObject(self._wayPoints[i])

		self._wayPoints[i] = nil
	end

	if self._curWayPoint then
		self:_setNewWayPoint(nil)
		self.dispatchEvent(self, UnitMoveEvent.Interrupt, self)
	end
end

function UnitMoverMmo:_setNewWayPoint(wp)
	local bStartMove = false

	if self._curWayPoint then
		self._wpPool:putObject(self._curWayPoint)
	elseif wp then
		bStartMove = true
	end

	self._curWayPoint = wp

	if not self._curWayPoint then
		self._speedX = 0
		self._speedY = 0
		self._speedZ = 0
	else
		if wp.speed then
			self._speed = wp.speed
		end

		local vx = self._curWayPoint.x - self._posX
		local vy = self._curWayPoint.y - self._posY
		local vz = self._curWayPoint.z - self._posZ
		local length = math.sqrt(vx * vx + vy * vy + vz * vz)

		vx = vx / length
		vy = vy / length
		vz = vz / length
		self._speedX = vx * self._speed
		self._speedY = vy * self._speed
		self._speedZ = vz * self._speed
	end

	if bStartMove then
		self._startMoveTime = Time.time

		self.dispatchEvent(self, UnitMoveEvent.StartMove, self)
	end
end

function UnitMoverMmo:onUpdate()
	if self._curWayPoint then
		local speedFactor = Time.deltaTime

		if self._accerationTime > 0 then
			local elapsedTime = Time.time - self._startMoveTime

			if elapsedTime < self._accerationTime then
				speedFactor = speedFactor * (elapsedTime / self._accerationTime)
			end
		end

		local nextPosX = self._posX + self._speedX * speedFactor
		local nextPosY = self._posY + self._speedY * speedFactor
		local nextPosZ = self._posZ + self._speedZ * speedFactor
		local vecNowNextX = nextPosX - self._posX
		local vecNowNextY = nextPosY - self._posY
		local vecNowNextZ = nextPosZ - self._posZ
		local vecNowDestX = self._curWayPoint.x - self._posX
		local vecNowDestY = self._curWayPoint.y - self._posY
		local vecNowDestZ = self._curWayPoint.z - self._posZ
		local distNext = vecNowNextX * vecNowNextX + vecNowNextY * vecNowNextY + vecNowNextZ * vecNowNextZ
		local distDest = vecNowDestX * vecNowDestX + vecNowDestY * vecNowDestY + vecNowDestZ * vecNowDestZ

		if distDest <= distNext then
			self._posX = self._curWayPoint.x
			self._posY = self._curWayPoint.y
			self._posZ = self._curWayPoint.z

			self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
			self:dispatchEvent(UnitMoveEvent.PassWayPoint, self._posX, self._posY, self._posZ)

			if #self._wayPoints > 0 then
				local newWp = self._wayPoints[1]

				table.remove(self._wayPoints, 1)
				self:_setNewWayPoint(newWp)
			else
				self:_setNewWayPoint(nil)
				self.dispatchEvent(self, UnitMoveEvent.Arrive, self)
			end
		else
			self._posX = nextPosX
			self._posY = nextPosY
			self._posZ = nextPosZ

			self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
		end
	end
end

function UnitMoverMmo:onDestroy()
	self:clearWayPoints()
	self._wpPool:dispose()

	self._wpPool = nil
	self._wayPoints = nil
	self._curWayPoint = nil
end

return UnitMoverMmo
