-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/elevator/component/ElevatorCompMover.lua

module("logic.scene.unit.elevator.component.ElevatorCompMover", package.seeall)

local M = class("ElevatorCompMover", UnitComponentBase)
local ElevatorMoveStatus = SceneEnum.ElevatorMoveStatus
local kStaticStopPosY = {
	33.8,
	58.7,
	75,
	91.2
}
local kMoveSpeed = 0.07

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._isMoving = false
	self._direction = ElevatorMoveStatus.Hold
	self._curLevel = 3
	self._targetLevel = 0
	self._lobbyStopCallback = nil
	self._lobbyStopTarget = nil
end

function M:onInit()
	self:_refreshPosByLevel()
end

function M:clear()
	self._isMoving = false
	self._direction = ElevatorMoveStatus.Hold
	self._curLevel = 3
	self._targetLevel = 0
	self._lobbyStopCallback = nil
	self._lobbyStopTarget = nil
end

function M:_refreshPosByLevel()
	local posY = kStaticStopPosY[self._curLevel]

	Astral.TransformUtil.SetLocalPosY(self._unit.go.transform, posY)
end

function M:isCurrLevelTop()
	local eleavtorUnit = self._unit:getTopLevelUnit()

	return eleavtorUnit:getLevelNum() == self._curLevel
end

function M:isCurrLevelBottom()
	local eleavtorUnit = self._unit:getBottomLevelUnit()

	return eleavtorUnit:getLevelNum() == self._curLevel
end

function M:getMoveDirection()
	return self._direction
end

function M:setTargetLevel(level)
	if self._unit:isLevelLegal(level) then
		self._targetLevel = level

		if self._targetLevel == self._curLevel then
			self._direction = ElevatorMoveStatus.Hold
		elseif self._targetLevel < self._curLevel then
			self._direction = ElevatorMoveStatus.Up
		elseif self._targetLevel > self._curLevel then
			self._direction = ElevatorMoveStatus.Down
		end
	end

	self:_refreshAllLevelShow()
end

function M:_refreshAllLevelShow()
	local levelUnits = self._unit:getElevatorLevels()

	for _, unit in ipairs(levelUnits) do
		unit.status:resumeShowStatus()
		unit.status:refreshShowStatus()
	end
end

function M:_pauseAllLevelShow()
	local levelUnits = self._unit:getElevatorLevels()

	for _, unit in ipairs(levelUnits) do
		unit.status:pauseShowStatus()
	end
end

function M:getCurrLevel()
	return self._curLevel
end

function M:setLobbyStopCallback(callback, target)
	self._lobbyStopCallback = callback
	self._lobbyStopTarget = target
end

function M:isMoving()
	return self._isMoving
end

function M:moveLobby(callback, target)
	self:setLobbyStopCallback(callback, target)

	if self._targetLevel > 0 and self._targetLevel ~= self._curLevel then
		self._isMoving = true
	end
end

function M:_stopLobby()
	self._isMoving = false
	self._curLevel = self._targetLevel

	self:_pauseAllLevelShow()

	if self._lobbyStopCallback then
		self._lobbyStopCallback(self._lobbyStopTarget)
	end
end

function M:update()
	if self._isMoving then
		local function _setPosY(y)
			Astral.TransformUtil.SetLocalPosY(self._unit.go.transform, y)
			self._unit.posMgr:refreshRideUnitPos()
		end

		local currentLocalPosY = Astral.TransformUtil.GetLocalPosY(self._unit.go.transform)
		local targetPosY = kStaticStopPosY[self._targetLevel]

		if currentLocalPosY < targetPosY then
			if targetPosY - currentLocalPosY > kMoveSpeed then
				_setPosY(currentLocalPosY + kMoveSpeed)
			else
				_setPosY(targetPosY)
				self:_stopLobby()
			end
		elseif targetPosY < currentLocalPosY then
			if currentLocalPosY - targetPosY > kMoveSpeed then
				_setPosY(currentLocalPosY - kMoveSpeed)
			else
				_setPosY(targetPosY)
				self:_stopLobby()
			end
		else
			self:_stopLobby()
		end
	end
end

return M
