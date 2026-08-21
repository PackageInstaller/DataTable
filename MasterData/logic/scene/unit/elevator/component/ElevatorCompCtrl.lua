-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/elevator/component/ElevatorCompCtrl.lua

module("logic.scene.unit.elevator.component.ElevatorCompCtrl", package.seeall)

local M = class("ElevatorCompCtrl", UnitComponentBase)
local ElevatorMoveStatus = SceneEnum.ElevatorMoveStatus
local ElevatorAnim = SceneEnum.ElevatorAnim
local ElevatorHeroStatus = SceneEnum.ElevatorHeroStatus
local kExitElevatorTime = 2
local kOpenDoorTime = 6
local kWaitEnterTime = 2
local kNearDistance = 6
local vec3Temp = Vector3.New()

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self._unitsLeaveTimer = SchedulerCtrl.New(self._afterUnitsLeave, self)
	self._closeDoorTimer = SchedulerCtrl.New(self._tryCloseDoor, self)

	self:_setEvents(true)
end

function M:clear()
	self:_setEvents(false)
	self._unitsLeaveTimer:clear()

	self._unitsLeaveTimer = nil

	self._closeDoorTimer:clear()

	self._closeDoorTimer = nil
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.ELEAVTOR_PUSH_BTN, self._onPushBtn, self)
		HouseDispatcher:addEventListener(HouseEventType.ELEAVTOR_MAINPLAYER_BUTTON, self._onMainPlayerPushBtn, self)
		HouseDispatcher:addEventListener(HouseEventType.ELEAVTOR_MAINPLAYER_ENTER, self._onMainPlayerEnter, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.ELEAVTOR_PUSH_BTN, self._onPushBtn, self)
		HouseDispatcher:removeEventListener(HouseEventType.ELEAVTOR_MAINPLAYER_BUTTON, self._onMainPlayerPushBtn, self)
		HouseDispatcher:removeEventListener(HouseEventType.ELEAVTOR_MAINPLAYER_ENTER, self._onMainPlayerEnter, self)
	end
end

function M:_onMainPlayerPushBtn(e, levelId, num)
	local mainPlayer = HouseSceneUtil.getMainPlayer()

	if mainPlayer then
		local isUp = num == 1
		local moveDir = isUp and ElevatorMoveStatus.Up or ElevatorMoveStatus.Down
		local status = mainPlayer.controller:getElevatorStatus()

		if status == ElevatorHeroStatus.None then
			mainPlayer.controller:setElevatorTarget(levelId, moveDir)
			self:pushElevatorBtn(levelId, isUp)
		elseif self:_isMainPlayerCanEnter(levelId) then
			mainPlayer.controller:setElevatorTarget(levelId, moveDir)
			self:pushElevatorBtn(levelId, isUp)
		end
	end
end

function M:_onMainPlayerEnter(e, levelId)
	if self:_isMainPlayerCanEnter(levelId) then
		local mainPlayer = HouseSceneUtil.getMainPlayer()

		if mainPlayer then
			local pos = self._unit.posMgr:getMainPos()

			mainPlayer.controller:enterElevator(levelId, pos)
		end
	end
end

function M:_isMainPlayerCanEnter(levelId)
	local curLevelUnit = self._unit:getElevatorLevelByLevel(self._unit.mover:getCurrLevel())

	if curLevelUnit:getElevatorId() == levelId and not self._unit.mover:isMoving() and curLevelUnit.anim:isOpen() then
		return true
	end

	return false
end

function M:_blockMainPlayerExitEleavtor(block)
	if self._unit:isMainPlayerIn() then
		local mainPlayer = HouseSceneUtil.getMainPlayer()

		mainPlayer.controller:setCanLeftElevator(not block)
	end
end

function M:_onPushBtn(e, levelId, moveDir)
	local isUp = moveDir == ElevatorMoveStatus.Up

	self:pushElevatorBtn(levelId, isUp)
end

function M:pushElevatorBtn(elevatorLevelId, isUp)
	local levelUnit = self._unit:getElevatorLevelById(elevatorLevelId)

	if levelUnit then
		if isUp then
			levelUnit.status:setUpBtnOn(true)
		else
			levelUnit.status:setDownBtnOn(true)
		end

		self:_dispatchElevatorBtnUpdate(levelUnit)

		local currLevel = self._unit.mover:getCurrLevel()

		if levelUnit:getLevelNum() == currLevel then
			self:triggerLevelOpen()
		else
			self:triggerLobbyMove()
		end
	end
end

function M:_dispatchElevatorBtnUpdate(levelUnit)
	local dispatchToPush = {}
	local units = levelUnit.lineMgr:getWaitList()

	for _, unit in ipairs(units) do
		local unitDir = unit.model:getTowardDirection()

		if unitDir ~= ElevatorMoveStatus.Hold then
			local isUp = unitDir == ElevatorMoveStatus.Up

			if levelUnit.status:isBtnOn(isUp) then
				HouseDispatcher:dispatchEvent(HouseEventType.ELEAVTOR_TRIGGER_HERO_STATUS, unit, ElevatorHeroStatus.Wait)
			elseif not table.indexof(dispatchToPush, unitDir) then
				table.insert(dispatchToPush, unitDir)
				HouseDispatcher:dispatchEvent(HouseEventType.ELEAVTOR_TRIGGER_HERO_STATUS, unit, ElevatorHeroStatus.PushBtn)
			end
		end
	end
end

function M:triggerLevelOpen()
	if self:_isLobbyCanMove() then
		local curLevelUnit = self._unit:getElevatorLevelByLevel(self._unit.mover:getCurrLevel())

		curLevelUnit.anim:play(ElevatorAnim.Open, self._onLevelAnimEnd, self)
	end
end

function M:_onLevelAnimEnd(levelUnit, animState)
	local currLevel = self._unit.mover:getCurrLevel()

	if levelUnit:getLevelNum() == currLevel then
		if animState == ElevatorAnim.Open then
			self:_onLevelAnimOpen()
			self:_blockMainPlayerExitEleavtor(false)
		elseif animState == ElevatorAnim.Close then
			self:_onLevelAnimClose()
		end
	end
end

function M:_onLevelAnimOpen()
	local currLevel = self._unit.mover:getCurrLevel()
	local rideUnits = self._unit.posMgr:getRideUnitsByTargetLevel(currLevel)

	if #rideUnits > 0 then
		for _, unit in ipairs(rideUnits) do
			unit.navMesh:setNavMeshAgentStatus(true)
			unit.navMeshMover:setStopChangeAngle(false)

			local posX, posY, posZ = unit.navMesh:getNavMeshGoPos()

			vec3Temp:Set(posX, posY, posZ - 2)
			unit.navMesh:setDestination(vec3Temp)
			unit.navMesh:resumeNavMesh()
			unit.followRobot:setNavMeshAgentStatus(true)

			local robot = unit.followRobot:getFollowUnit()

			if robot then
				robot.navMeshMover:setStopChangeAngle(false)
			end

			unit.followRobot:setDestination(vec3Temp, -0.5)
		end

		self._unitsLeaveTimer:restart(kExitElevatorTime, false)
	else
		self._unitsLeaveTimer:restart(0, false)
	end
end

function M:_afterUnitsLeave()
	local currLevel = self._unit.mover:getCurrLevel()
	local curLevelUnit = self._unit:getElevatorLevelByLevel(currLevel)
	local moveDir = self._unit.mover:getMoveDirection()
	local rideUnits = self._unit.posMgr:getRideUnitsByTargetLevel(currLevel)

	for _, unit in ipairs(rideUnits) do
		self._unit.posMgr:removeRideUnit(unit)
		HouseDispatcher:dispatchEvent(HouseEventType.ELEAVTOR_TRIGGER_HERO_STATUS, unit, ElevatorHeroStatus.MoveOutEleavtor)
	end

	local waitUnits = curLevelUnit.lineMgr:getWaitListWithMoveDir(moveDir)

	for _, unit in ipairs(waitUnits) do
		if self._unit.posMgr:isUnitNear(unit, kNearDistance) and self._unit.posMgr:addRideUnit(unit) then
			curLevelUnit.lineMgr:removeWaitUnit(unit)
			HouseDispatcher:dispatchEvent(HouseEventType.ELEAVTOR_TRIGGER_HERO_STATUS, unit, ElevatorHeroStatus.MoveInEleavtor)
		end
	end

	self._closeDoorTimer:restart(kOpenDoorTime, false)
end

function M:_tryCloseDoor()
	if self:_isDoorCanClose() then
		local curLevelUnit = self._unit:getElevatorLevelByLevel(self._unit.mover:getCurrLevel())

		curLevelUnit.anim:play(ElevatorAnim.Close, self._onLevelAnimEnd, self)
		self:_blockMainPlayerExitEleavtor(true)
	else
		self._closeDoorTimer:restart(kWaitEnterTime, false)
	end
end

function M:_isDoorCanClose()
	local isRideUnitIn = false
	local isMainPlayerNotMove = false
	local isMainPlayerNotKeepOpen = false

	if not self._unit.mover:isMoving() then
		local curLevelUnit = self._unit:getElevatorLevelByLevel(self._unit.mover:getCurrLevel())

		if curLevelUnit.anim:isOpen() then
			isRideUnitIn = self._unit.posMgr:isAllRideUnitInEvlavtor()
			isMainPlayerNotMove = not self._unit:isMainPlayerMoveIn() and not self._unit:isMainPlayerMoveOut()
			isMainPlayerNotKeepOpen = not self:_isMainPlayerKeepOpen()
		end
	end

	return isRideUnitIn and isMainPlayerNotMove and isMainPlayerNotKeepOpen
end

function M:_isMainPlayerKeepOpen()
	if self._unit:isMainPlayerIn() then
		local mainPlayer = HouseSceneUtil.getMainPlayer()
		local levelId, moveDir = mainPlayer.controller:getElevatorTarget()
		local isNoDir = moveDir == ElevatorMoveStatus.Hold
		local isRideEmpty = self._unit.posMgr:isRideQueueEmpty()
		local noBtnOn = true

		for _, levelUnit in ipairs(self._unit:getElevatorLevels()) do
			noBtnOn = noBtnOn and not levelUnit.status:hasBtnOn()
		end

		return isNoDir and isRideEmpty and noBtnOn
	end

	return false
end

function M:_onLevelAnimClose()
	self:triggerLobbyMove()
end

function M:triggerLobbyMove()
	if self:_isLobbyCanMove() then
		local currLevel = self._unit.mover:getCurrLevel()
		local curLevelUnit = self._unit:getElevatorLevelByLevel(currLevel)
		local targetLevel = self:_getTargetLevel()

		targetLevel = targetLevel == 0 and currLevel or targetLevel

		self._unit.mover:setTargetLevel(targetLevel)
		self._unit.mover:moveLobby(self._onLobbyStop, self)

		local moveDir = self._unit.mover:getMoveDirection()

		if moveDir == ElevatorMoveStatus.Up then
			curLevelUnit.status:setUpBtnOn(false)
		elseif moveDir == ElevatorMoveStatus.Down then
			curLevelUnit.status:setDownBtnOn(false)
		else
			curLevelUnit.status:setUpBtnOn(false)
			curLevelUnit.status:setDownBtnOn(false)
		end

		local units = curLevelUnit.lineMgr:getWaitList()

		if #units == 0 then
			curLevelUnit.status:setUpBtnOn(false)
			curLevelUnit.status:setDownBtnOn(false)
		end

		self:_dispatchElevatorBtnUpdate(curLevelUnit)
	end
end

function M:_onLobbyStop()
	self:triggerLevelOpen()

	if self:_getMainPlayerTargetLevel() == self._unit.mover:getCurrLevel() then
		local mainPlayer = HouseSceneUtil.getMainPlayer()

		mainPlayer.controller:setElevatorTarget(nil, ElevatorMoveStatus.Hold)
	end
end

function M:_isLobbyCanMove()
	if not self._unit.mover:isMoving() then
		local curLevelUnit = self._unit:getElevatorLevelByLevel(self._unit.mover:getCurrLevel())

		if curLevelUnit.anim:isClose() then
			return true
		end
	end

	return false
end

function M:_getTargetLevel()
	local targetLevel = 0
	local moveDir = self._unit.mover:getMoveDirection()
	local findDir = moveDir == ElevatorMoveStatus.Hold and ElevatorMoveStatus.Up or moveDir
	local offset = findDir == ElevatorMoveStatus.Up and -1 or 1

	targetLevel = self:_getTargetLevelByDir(offset)

	if targetLevel == 0 then
		offset = -1 * offset
		targetLevel = self:_getTargetLevelByDir(offset)
	end

	return targetLevel
end

function M:_getTargetLevelByDir(offset)
	local currLevel = self._unit.mover:getCurrLevel()
	local nextLevel = currLevel + offset
	local targetLevel = 0

	while self._unit:isLevelLegal(nextLevel) do
		local levels = self._unit.posMgr:getRideHeroTargetLevels()

		if table.indexof(levels, nextLevel) then
			targetLevel = nextLevel

			break
		end

		if nextLevel == self:_getMainPlayerTargetLevel() then
			targetLevel = nextLevel

			break
		end

		local levelUnit = self._unit:getElevatorLevelByLevel(nextLevel)

		if levelUnit.status:hasBtnOn() and not self._unit.posMgr:isRideQueueFull() then
			targetLevel = nextLevel

			break
		end

		nextLevel = nextLevel + offset
	end

	return targetLevel
end

function M:_getMainPlayerTargetLevel()
	local targetLevel = 0

	if self._unit:isMainPlayerIn() then
		local mainPlayer = HouseSceneUtil.getMainPlayer()
		local levelId, moveDir = mainPlayer.controller:getElevatorTarget()

		if levelId > 0 then
			local levelCO = HouseConfig.instance:getElevatorCoById(levelId)
			local level = 0

			if moveDir == ElevatorMoveStatus.Up then
				level = levelCO.ringType - 1
			elseif moveDir == ElevatorMoveStatus.Down then
				level = levelCO.ringType + 1
			end

			if self._unit:isLevelLegal(level) then
				return level
			end
		end
	end

	return 0
end

return M
