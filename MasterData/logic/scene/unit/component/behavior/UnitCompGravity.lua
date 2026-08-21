-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/behavior/UnitCompGravity.lua

module("logic.scene.unit.component.behavior.UnitCompGravity", package.seeall)

local M = class("UnitCompGravity", UnitComponentBase)
local Input = Astral.ToLuaFramework.AsInputSystem.InputSystemToLua
local SystemInfo = UnityEngine.SystemInfo
local AnimationState = HouseEnum.AnimationState
local RoomType = HouseEnum.RoomType
local framePerSec = 30
local speedXInterval = 1.6
local maxSpeedX = 2.4
local baseOffsetY = 2
local minOffsetY = 1
local maxOffsetY = 3
local speedYInterval = 0.03
local maxSpeedY = 0.024
local moveSelfOffset = 5
local moveSelfInterval = 2
local maxRotaZ = 10
local rotaZInterval = 0.2
local vec3Temp = Vector3.New()

local function _getScreenPos(angle, x, y)
	local A = math.cos(math.rad(angle))
	local B = math.sin(math.rad(angle))
	local screenPosX = x * A + y * B
	local screenPosY = y * A - x * B

	return screenPosX, screenPosY
end

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._isWeightless = nil
	self._isSupport = false
	self._weightlessSwitch = false
end

function M:onInit()
	self._isWeightless = false
	self._moveSelfTimer = SchedulerCtrl.New(self._moveSelf, self)
	self._isSupport = SystemInfo.supportsGyroscope

	HouseDispatcher:addEventListener(HouseEventType.CHANGE_HERO_GRAVITY, self._onChangeGravity, self)
	self._unit:addInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
end

function M:onReuse()
	self._isWeightless = false
	self._isSupport = SystemInfo.supportsGyroscope

	HouseDispatcher:addEventListener(HouseEventType.CHANGE_HERO_GRAVITY, self._onChangeGravity, self)
	self._unit:addInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
end

function M:onReset()
	self._moveSelfTimer:stop()
	HouseDispatcher:removeEventListener(HouseEventType.CHANGE_HERO_GRAVITY, self._onChangeGravity, self)
	self._unit:removeInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
end

function M:onDestroy()
	self._moveSelfTimer:clear()

	self._moveSelfTimer = nil

	HouseDispatcher:removeEventListener(HouseEventType.CHANGE_HERO_GRAVITY, self._onChangeGravity, self)
	self._unit:removeInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
end

function M:isWeightless()
	return self._isWeightless
end

function M:setWeightless(isWeightless)
	local types = {
		RoomType.Living
	}
	local isInLifeRoom = HouseSceneUtil.isPlayerInRoomWithType(self._unit, types)

	if isInLifeRoom and isWeightless == true then
		return
	end

	if self._isWeightless == isWeightless then
		return
	end

	self._isWeightless = isWeightless

	if self._isWeightless then
		self:_showWeightlessStatus()
	else
		self:_recoverStatus()
	end
end

function M:_showWeightlessStatus()
	local roomId = self._unit.navMesh:getCurZoneId()
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)

	if not self:_findRoomBorder(roomCO) then
		self._isWeightless = false

		return
	end

	self._unit.performCtrl:interrupt()
	self._unit.ai:stopCurrentAI()
	self._unit.navMesh:setNavMeshAgentStatus(true)
	self._unit.navMesh:stopNavMesh()
	self._unit.navMesh:setAgentSpeed(0)
	self._unit.meshModel:play(AnimationState.Loss, true)

	local meshGO = self._unit.meshModel:getInst()

	if meshGO then
		Astral.TransformUtil.SetLocalPos(meshGO.transform, 0, baseOffsetY, 0)
	end

	self._offsetY = baseOffsetY
	self._angle = roomCO.angle
	self._paramA = math.cos(math.rad(self._angle))
	self._paramB = math.sin(math.rad(self._angle))
	self._paramPow = self._paramA * self._paramA + self._paramB * self._paramB
	self._speedX = 0
	self._speedY = 0
	self._lastRotaZ = 0
	self._randomValue = math.random(80, 120) / 100

	self._unit.navMesh:resumeNavMesh()
	self:_startRandomMoveSelf()

	self._weightlessSwitch = true
end

function M:_recoverStatus()
	self._weightlessSwitch = false

	self:_endRandomMoveSelf()

	local meshGO = self._unit.meshModel:getInst()

	Astral.TransformUtil.SetLocalRotation(meshGO.transform, 0, 0, 0)
	Astral.TransformUtil.SetLocalPos(meshGO.transform, 0, 0, 0)
	self._unit.meshModel:play(AnimationState.Idle, true)
	self._unit.navMesh:setAgentSpeed(CommEnum.NavMeshAgentSpeed.HeroWalk)
	self._unit.navMesh:resumeNavMesh()
	self._unit.ai:setStop(false)

	self._paramA = nil
	self._paramB = nil
	self._paramPow = nil
	self._speedX = 0
	self._speedY = 0
	self._lastRotaZ = 0
	self._offsetY = 0
	self._leftBorderScreenPosX = nil
	self._rightBorderScreenPosX = nil
end

function M:_onChangeGravity(e, isOn)
	self:setWeightless(isOn)
end

function M:update()
	if self._isWeightless and self._weightlessSwitch then
		self:_updateMoveSpeed()
	end
end

function M:_updateMoveSpeed()
	if not self._isSupport then
		return
	end

	local accel = Input.acceleration

	self:_moveX(accel.x)
	self:_moveY(accel.y)
end

function M:_moveX(inputAccelX)
	local unitPosX, unitPosY, unitPosZ = self._unit.navMesh:getNavMeshGoPos()
	local unitScreenPosX = unitPosX * self._paramA + unitPosY * self._paramB
	local unitScreenPosY = unitPosY * self._paramA - unitPosX * self._paramB
	local meshGO = self._unit.meshModel:getInst()
	local middleInputX = 0
	local deltaX = 2

	self._speedX = (inputAccelX - middleInputX) * speedXInterval * self._randomValue + self._speedX

	local maxSpeedX = maxSpeedX * self._randomValue
	local adjustSpeed = math.min(maxSpeedX, math.abs(self._speedX))

	self._speedX = self._speedX < 0 and adjustSpeed * -1 or adjustSpeed

	local interval = self._speedX > 0 and rotaZInterval * -1 or rotaZInterval
	local rotaZ = self._lastRotaZ + interval * self._randomValue * (adjustSpeed / maxSpeedX)
	local adjustRotaZ = math.min(maxRotaZ, math.abs(rotaZ))

	rotaZ = rotaZ < 0 and adjustRotaZ * -1 or adjustRotaZ

	Astral.TransformUtil.SetLocalRotation(meshGO.transform, 0, 0, rotaZ)

	self._lastRotaZ = rotaZ

	local borderInterval = 0.5

	if self._speedX > 0 then
		unitScreenPosX = math.min(unitScreenPosX + deltaX, self._rightBorderScreenPosX - borderInterval)
	elseif self._speedX < 0 then
		unitScreenPosX = math.max(unitScreenPosX - deltaX, self._leftBorderScreenPosX + borderInterval)
	end

	local posX = (self._paramA * unitScreenPosX - self._paramB * unitScreenPosY) / self._paramPow
	local posY = (self._paramB * unitScreenPosX + self._paramA * unitScreenPosY) / self._paramPow

	vec3Temp:Set(posX, posY, unitPosZ)
	self._unit.navMesh:setDestination(vec3Temp)
	self._unit.navMesh:setAgentSpeed(adjustSpeed)
end

function M:_findRoomBorder(roomCO)
	self._leftBorderScreenPosX = nil
	self._rightBorderScreenPosX = nil

	if not roomCO then
		printWarn("no roomCO")

		return false
	end

	local navMO = HouseNavigationModel.instance:getMOByZoneId(roomCO.id)

	if not navMO then
		printWarn("no navMO wiht room id:", roomCO.id)

		return false
	end

	local leftBorderPos = navMO:getLeftBorderPos()
	local leftScreenPosX, leftScreenPosY = _getScreenPos(roomCO.angle, leftBorderPos.x, leftBorderPos.y)

	self._leftBorderScreenPosX = leftScreenPosX

	local rightBorderPos = navMO:getRightBorderPos()
	local rightScreenPosX, rightScreenPosY = _getScreenPos(roomCO.angle, rightBorderPos.x, rightBorderPos.y)

	self._rightBorderScreenPosX = rightScreenPosX

	return true
end

function M:_moveY(inputAccelY)
	local middleInputY, maxInputY = -0.5, 0

	inputAccelY = math.min(inputAccelY, maxInputY)
	self._speedY = (inputAccelY - middleInputY) * speedYInterval * self._randomValue + self._speedY

	local maxSpeedY = maxSpeedY * self._randomValue
	local adjustSpeed = math.min(maxSpeedY, math.abs(self._speedY))

	self._speedY = self._speedY < 0 and adjustSpeed * -1 or adjustSpeed

	local meshGO = self._unit.meshModel:getInst()

	if meshGO then
		local totalCount = moveSelfInterval * framePerSec

		self._offsetY = self._offsetY + self._speedY
		self._offsetY = math.max(minOffsetY, math.min(maxOffsetY, self._offsetY))
		self._moveCount = self._moveCount or 0

		local originX = self._originMoveX or 0
		local targetX = self._targetMoveX or 0
		local moveX = originX + (targetX - originX) / totalCount * self._moveCount
		local originY = self._originMoveY or 0
		local targetY = self._targetMoveY or 0
		local moveY = originY + (targetY - originY) / totalCount * self._moveCount

		Astral.TransformUtil.SetLocalPos(meshGO.transform, moveX, self._offsetY + moveY, 0)

		self._moveCount = math.min(self._moveCount + 1, totalCount)
	end
end

function M:_startRandomMoveSelf()
	self:_endRandomMoveSelf()

	local sec = math.random(20, 25) / 10

	self._moveSelfTimer:restart(sec, false)
end

function M:_endRandomMoveSelf()
	self._moveSelfTimer:stop()

	local meshGO = self._unit.meshModel:getInst()

	if meshGO then
		meshGO.transform:DOKill()
	end

	self._moveCount = 0
	self._originMoveX = 0
	self._targetMoveX = 0
	self._originMoveY = 0
	self._targetMoveY = 0
end

function M:_moveSelf()
	local meshGO = self._unit.meshModel:getInst()

	if meshGO then
		meshGO.transform:DOKill()

		self._originMoveX = self._targetMoveX or 0
		self._originMoveY = self._targetMoveY or 0
		self._targetMoveX = math.random(moveSelfOffset * -1, moveSelfOffset) / 10
		self._targetMoveY = math.random(moveSelfOffset * -1, moveSelfOffset) / 10
		self._moveCount = 0

		local sec = math.random(15, 25) / 10

		self._moveSelfTimer:restart(sec, false)
	end
end

function M:_dealAreaChange(unitUID, actionType, curAreaType, preAreaType, areaName)
	if curAreaType == SceneEnum.NavMeshAreas.Room then
		local switch = HouseModel.instance:getGravitySwitch()

		self:setWeightless(switch)
	end
end

return M
