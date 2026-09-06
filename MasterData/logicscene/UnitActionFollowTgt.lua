-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionFollowTgt.lua

module("logicscene.scene.unit.action.UnitActionFollowTgt", package.seeall)

local UnitActionFollowTgt = class("UnitActionFollowTgt", UnitActionGotoUnit)

function UnitActionFollowTgt:ctor(unit)
	UnitActionFollowTgt.super.ctor(self, unit)

	self._isPlayingIdle = nil
end

function UnitActionFollowTgt:start(unit)
	local scene = SceneMgr.instance:getCurScene()

	self._pathFinder = scene.pathFinder
	self._scene = scene

	if self.distanceConfig and self.distanceConfig[1] then
		self._minDistance = self.distanceConfig[1] or 0
	end

	if self.distanceConfig and self.distanceConfig[2] then
		self._maxDistance = self.distanceConfig[2] or 1.8
	end

	if self.distanceConfig and self.distanceConfig[3] then
		self._distLimit = self.distanceConfig[3] or self:_calculateDistance(math.random(self._minDistance, self._maxDistance))
	end

	self._unit = unit

	self:_findDest()
	UnitActionPathTo.super.start(self, unit)

	if not self._isDone then
		self:_startFindPath()
	end
end

function UnitActionFollowTgt:update(deltaTime)
	UnitActionFollowTgt.super.update(self, deltaTime)

	if UnitActionFollowTgt.super.isDone(self) then
		self:_refinePath()
	end
end

function UnitActionFollowTgt:isDone()
	return nil
end

function UnitActionFollowTgt:_refinePath()
	local destX, destY = self._toUnit.transform:getPos()
	local dist = self:_calculateDistance(self._unit.transform:dist(destX or 0, destY or 0))

	if destX and (dist < self._minDistance or dist > self._maxDistance) then
		if self.distanceConfig and self.distanceConfig[3] then
			self._distLimit = self.distanceConfig[3] or self:_calculateDistance(math.random(self._minDistance, self._maxDistance))
		end

		self._elapsed = 0
		self._isDone = nil
		self._fromX, self._fromY = self._unit.transform:getPos()

		self:_findDest()
		self:_startFindPath()

		self._isPlayingIdle = nil
	else
		self._fromX, self._fromY = self._unit.transform:getPos()

		if not self._isPlayingIdle then
			self._isPlayingIdle = true

			self._spineMover:playIdleAnim()
		end
	end
end

function UnitActionFollowTgt:_findDest()
	self._isDone = nil

	local destX, destY = self._toUnit.transform:getPos()

	self._destOldX = destX
	self._destOldY = destY

	local dist, dirX, dirY = self._unit.transform:distAndDir(destX, destY)

	dist = self:_calculateDistance(dist)

	if (dist == 0 or dist >= self._minDistance and dist <= self._maxDistance) and self._unit:isUnderBridge() == self._toUnit:isUnderBridge() then
		self._fromX, self._fromY = self._unit.transform:getPos()
		self._isDone = true
	else
		destX = destX - dirX * self._distLimit
		destY = destY - dirY * self._distLimit
		self._fromX, self._fromY = self._unit.transform:getPos()

		if self._scene:isPositionReachable(self._unit.sceneUnit, destX, destY) then
			self._destX = destX
			self._destY = destY
		else
			local hasPos, destPosX, destPosY = self._scene:findRandomNotBerrierAround(self._unit.sceneUnit, self._destOldX, self._destOldY, false)

			self._destX = destPosX
			self._destY = destPosY
		end
	end
end

return UnitActionFollowTgt
