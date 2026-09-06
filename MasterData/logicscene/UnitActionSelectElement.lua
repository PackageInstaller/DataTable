-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionSelectElement.lua

module("logicscene.scene.unit.action.UnitActionSelectElement", package.seeall)

local UnitActionSelectElement = class("UnitActionSelectElement", UnitActionPathTo)

function UnitActionSelectElement:ctor(elementId)
	self._elementId = elementId
	self._scene = SceneMgr.instance:getCurScene()

	local x, y, radius = self._scene:getElementTriggerParams(elementId)

	self._distLimit = self:_calculateDistance(radius)
	self._isDone = nil

	UnitActionSelectElement.super.ctor(self, x, y)
end

function UnitActionSelectElement:start(unit)
	self._unit = unit

	self:_findDest()

	if self._isDone then
		self._elapsed = 0
		self._duration = 0
		self.isRunning = true

		return
	end

	UnitActionSelectElement.super.start(self, unit)
end

function UnitActionSelectElement:_calculateDistance(distance)
	distance = distance + 0.005
	distance = distance - distance % 0.01

	if distance <= 0 then
		distance = 1
	end

	return distance
end

function UnitActionSelectElement:stop()
	self._elementId = nil
	self._distLimit = nil

	UnitActionSelectElement.super.stop(self)
end

function UnitActionSelectElement:update(deltaTime)
	UnitActionSelectElement.super.update(self, deltaTime)

	if self:isDone() then
		GlobalDispatcher:dispatch(GlobalNotify.SelectElement, self._elementId)
	end
end

function UnitActionSelectElement:isDone()
	if self._isDone then
		return true
	end

	return UnitActionSelectElement.super.isDone(self)
end

function UnitActionSelectElement:_findDest()
	self._isDone = nil

	local destX = self._destX
	local destY = self._destY
	local dist, dirX, dirY = self._unit.transform:distAndDir(destX, destY)

	dist = self:_calculateDistance(dist)

	if dist <= self._distLimit then
		self._isDone = true
	else
		destX = destX - dirX * self._distLimit
		destY = destY - dirY * self._distLimit
		self._fromX, self._fromY = self._unit.transform:getPos()

		if self._scene:isPositionReachable(self._unit.sceneUnit, destX, destY) then
			self._destX = destX
			self._destY = destY
		else
			local hasPos, destPosX, destPosY = self:_findRandomNotBerrierAround(destX, destY)

			self._destX = destPosX
			self._destY = destPosY
		end
	end
end

function UnitActionSelectElement:_findRandomNotBerrierAround(destX, destY)
	local hasPos, destPosX, destPosY = self._scene:findRandomNotBerrierAround(self._unit.sceneUnit, destX, destY, false)

	return hasPos, destPosX, destPosY
end

return UnitActionSelectElement
