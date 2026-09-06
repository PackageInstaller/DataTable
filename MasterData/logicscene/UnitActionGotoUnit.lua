-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionGotoUnit.lua

module("logicscene.scene.unit.action.UnitActionGotoUnit", package.seeall)

local UnitActionGotoUnit = class("UnitActionGotoUnit", UnitActionPathTo)

function UnitActionGotoUnit:ctor(unit, distance)
	UnitActionGotoUnit.super.ctor(self)

	self._toUnit = unit

	if self._toUnit then
		self._distLimit = self:_calculateDistance(distance)
	end

	self._isDone = nil
	self._destOldX = nil
	self._destOldY = nil
end

function UnitActionGotoUnit:start(unit)
	self._scene = SceneMgr.instance:getCurScene()
	self._unit = unit

	if not self._toUnit then
		self._isDone = true
	else
		self._distLimit = self._distLimit or self:_calculateDistance()

		self:_findDest()
	end

	if self._isDone then
		self._elapsed = 0
		self._duration = 0
		self.isRunning = true

		return
	end

	UnitActionGotoUnit.super.start(self, unit)
end

function UnitActionGotoUnit:_calculateDistance(distance)
	distance = distance or self._toUnit.radius
	distance = distance + 0.005
	distance = distance - distance % 0.01

	if distance <= 0 then
		distance = 1
	end

	return distance
end

function UnitActionGotoUnit:stop()
	self._destOldX = nil
	self._destOldY = nil

	UnitActionGotoUnit.super.stop(self)
end

function UnitActionGotoUnit:update(deltaTime)
	if self._isDone then
		return
	end

	UnitActionGotoUnit.super.update(self, deltaTime)
	self:_checkFinished()
end

function UnitActionGotoUnit:isDone()
	if self._isDone then
		return true
	end

	return UnitActionGotoUnit.super.isDone(self)
end

function UnitActionGotoUnit:_checkFinished()
	if not self._unit then
		return
	end

	local destX, destY = self._toUnit.transform:getPos()

	if not destX or not destY or self._toUnit.isDestroyed then
		self._isDone = true

		return
	end

	local dist = self:_calculateDistance(self._unit.transform:dist(destX, destY))

	self._isDone = dist - self._distLimit <= 0.1 and self._unit:isUnderBridge() == self._toUnit:isUnderBridge() and true or nil

	if not self._isDone then
		if UnitActionGotoUnit.super.isDone(self) then
			self:_findDest()
			self:_startFindPath()
		else
			self:_checkReFindPath()
		end
	end
end

function UnitActionGotoUnit:_findDest()
	self._isDone = nil

	local destX, destY = self._toUnit.transform:getPos()

	self._destOldX = destX
	self._destOldY = destY

	local dist, dirX, dirY = self._unit.transform:distAndDir(destX, destY)

	dist = self:_calculateDistance(dist)

	if dist <= self._distLimit then
		if not self._unit.sceneUnit or not self._toUnit.sceneUnit or self._unit:isUnderBridge() == self._toUnit:isUnderBridge() then
			self._isDone = true
		end
	else
		destX = destX - dirX * self._distLimit
		destY = destY - dirY * self._distLimit
		self._fromX, self._fromY = self._unit.transform:getPos()

		if self._scene:isPositionReachable(self._unit.sceneUnit, destX, destY) then
			self._destX = destX
			self._destY = destY
		else
			local hasPos, destPosX, destPosY = self:_findRandomNotBerrierAround(self._destOldX, self._destOldY)

			self._destX = destPosX
			self._destY = destPosY
		end
	end
end

function UnitActionGotoUnit:_checkReFindPath()
	local destX, destY = self._toUnit.transform:getPos()

	if self._destOldX ~= destX or self._destOldY ~= destY then
		local preRow, preCol = self._scene:getCellRowAndColIndexByPosition(self._destOldX, self._destOldY)
		local row, col = self._scene:getCellRowAndColIndexByPosition(destX, destY)

		if preRow ~= row and preCol ~= col then
			self:_findDest()
			self:_startFindPath()
		end
	end
end

function UnitActionGotoUnit:_findRandomNotBerrierAround(destX, destY)
	local hasPos, destPosX, destPosY = self._scene:findRandomNotBerrierAround(self._unit.sceneUnit, destX, destY, false)

	return hasPos, destPosX, destPosY
end

function UnitActionGotoUnit:_startFindPath()
	self._bridgeState = not self._toUnit.sceneUnit and -1 or self._toUnit:isUnderBridge() and 1 or 0

	UnitActionGotoUnit.super._startFindPath(self)
end

return UnitActionGotoUnit
