-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/navigation/UnitCompPlayerController.lua

module("logic.scene.unit.component.navigation.UnitCompPlayerController", package.seeall)

local RingType = HouseEnum.RingType
local NavMeshAreas = SceneEnum.NavMeshAreas
local ElevatorHeroStatus = SceneEnum.ElevatorHeroStatus
local ElevatorMoveStatus = SceneEnum.ElevatorMoveStatus
local kDefaultPosZ = -23
local vec3Temp = Vector3.New()
local M = class("UnitCompPlayerController", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._moveStatus = MainPlayerAction.MoveStatus.STOP
	self._lastMoveStatus = MainPlayerAction.MoveStatus.STOP
	self._canLeftElevator = true
	self._elevatorStatus = ElevatorHeroStatus.None
	self._currElevatorLevelId = 0
	self._elevatorDir = ElevatorMoveStatus.Hold
	self._exploreModeOpenMap = false
	self._leftDestination = Vector3.New()
	self._rightDestination = Vector3.New()
end

function M:onInit()
	M.super.onInit(self)
	self:onReuse()
end

function M:onReuse()
	self._unit.navMesh:setNavMeshAgentStatus(true)
	self._unit:addInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
	self._unit:addInnerEventListener(UnitActionType.ZoneIdChange, self._onZoneIdChange, self)
	HouseDispatcher:addEventListener(HouseEventType.GM_CHANGE_FOCUS_HERO, self._onGmFocusHeroChange, self)
	HouseDispatcher:addEventListener(HouseEventType.HOUSE_EXPLORE_OPEN_MAP, self._handleExploreModeOpenMap, self)
	GlobalDispatcher:addEventListener(EventType.INPUT_MOVE_STATUS_CHANGE, self._onMoveStatusChange, self)
end

function M:onReset()
	self:clearElevatorData()

	self._exploreModeOpenMap = false

	self._unit:removeInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
	self._unit:removeInnerEventListener(UnitActionType.ZoneIdChange, self._onZoneIdChange, self)
	HouseDispatcher:removeEventListener(HouseEventType.GM_CHANGE_FOCUS_HERO, self._onGmFocusHeroChange, self)
	HouseDispatcher:removeEventListener(HouseEventType.HOUSE_EXPLORE_OPEN_MAP, self._handleExploreModeOpenMap, self)
	GlobalDispatcher:removeEventListener(EventType.INPUT_MOVE_STATUS_CHANGE, self._onMoveStatusChange, self)

	self._moveStatus = MainPlayerAction.MoveStatus.STOP
	self._lastMoveStatus = MainPlayerAction.MoveStatus.STOP
end

function M:onDestroy()
	M.super.onDestroy(self)
	self:onReset()

	self._leftDestination = nil
	self._rightDestination = nil
end

function M:clearElevatorData()
	self._canLeftElevator = true
	self._elevatorStatus = ElevatorHeroStatus.None
	self._currElevatorLevelId = 0
	self._elevatorDir = ElevatorMoveStatus.Hold
end

function M:_handleExploreModeOpenMap(e, open)
	self._exploreModeOpenMap = open
end

function M:_onMoveStatusChange(e, moveStatus)
	if self._exploreModeOpenMap then
		moveStatus = MainPlayerAction.MoveStatus.STOP
	end

	if moveStatus == MainPlayerAction.MoveStatus.STOP or moveStatus == MainPlayerAction.MoveStatus.LEFT or moveStatus == MainPlayerAction.MoveStatus.RIGHT then
		self._moveStatus = moveStatus
	end

	if (moveStatus == MainPlayerAction.MoveStatus.LEFT or moveStatus == MainPlayerAction.MoveStatus.RIGHT) and self._canLeftElevator then
		self:exitElevator()
	end
end

function M:_dealAreaChange(e, actionType, curAreaType, preAreaType, areaName)
	if preAreaType < 0 then
		self:_updateMoveData(false)
	end
end

function M:_onZoneIdChange(e, actionType, currZoneId, oldZoneId)
	self:_updateDestination()
end

function M:_updateFlowPos(x, y)
	VirtualCameraMgr.instance:setFollowPosition(x, y, 0)
end

function M:_calculateMoveAngle(posX, posY)
	return NavMeshUtil.calculateMoveAngle(posX, posY, self._unit.navMesh:getCurAreaType(), self._unit.navMesh:getCurZoneId())
end

function M:_updateMoveData(isDuration)
	local gmFocusHero = HouseGMController.instance:getFocusHero()

	if gmFocusHero then
		return
	end

	local posX, posY, posZ = self._unit.navMesh:getNavMeshGoPos()

	self:_updateFlowPos(posX, posY)

	local roomId, ringType = NavMeshUtil.surfaceGoNameToZoneId(self._unit.navMesh:getCurAreaName())

	if roomId > 0 then
		self:_calculCamContrastAngle(posX, posY, ringType)
	end

	local angle = self:_calculateMoveAngle(posX, posY)

	if isDuration then
		VirtualCameraMgr.instance:doCameraRotationZ(angle, 4)
	else
		VirtualCameraMgr.instance:setCameraRotation(0, 0, angle)
	end
end

function M:_calculCamContrastAngle(x, y, ringType)
	local camRadius = math.sqrt(x * x + y * y)
	local camContrastAngle = math.deg(math.acos(x / camRadius))

	camContrastAngle = y > 0 and camContrastAngle or camContrastAngle * -1
	camContrastAngle = camContrastAngle + 90
	camContrastAngle = MathUtil.normalizeAngle(camContrastAngle)

	HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CAMERA_REFRESH, ringType, camContrastAngle)
end

function M:_joystickMove()
	self:_updateDesWithInterval()

	if self._elevatorStatus == ElevatorHeroStatus.MoveInEleavtor then
		if self._unit.navMeshMover:isArrivedDestination() then
			self._elevatorStatus = ElevatorHeroStatus.InEleavtor
		end

		self:_updateMoveData(true)
	elseif self._elevatorStatus == ElevatorHeroStatus.InEleavtor then
		self:_updateMoveData(true)
	elseif self._elevatorStatus == ElevatorHeroStatus.MoveOutEleavtor then
		if self._unit.navMeshMover:isArrivedDestination() then
			self._unit.navMesh:setRadius()

			self._elevatorStatus = ElevatorHeroStatus.None
		end
	elseif not self._unit.navMesh:getIsManualWalk() then
		if self._moveStatus == MainPlayerAction.MoveStatus.STOP then
			if self._lastMoveStatus ~= self._moveStatus then
				self:_onStopStatus()
			end
		else
			self:_onMovingStatus()
		end

		self._lastMoveStatus = self._moveStatus
	end
end

function M:_onStopStatus()
	if self._unit.navMesh:isOnNavMesh() then
		self._unit.navMesh:activateCurrentOffMeshLink(true)
		self._unit.navMesh:resetPath()
		self._unit.navMesh:stopManualNavMeshLink(false)
		self._unit.meshModel:play(HouseEnum.AnimationState.Idle, true)
	end
end

function M:_onMovingStatus()
	local destination = self._rightDestination

	if self._moveStatus == MainPlayerAction.MoveStatus.LEFT then
		destination = self._leftDestination
	end

	if not self._unit.navMesh:getIsManualWalk() then
		self._unit.navMesh:setDestination(destination)
		self:_updateMoveData(true)
	elseif self._lastMoveStatus == MainPlayerAction.MoveStatus.STOP then
		self._unit.navMesh:setDestination(destination)
		self._unit.navMesh:startManualNavMeshLink()
		self._unit.navMeshMover:lookAtPos(self._unit.navMesh:getLinkEndPos())
		self:_updateMoveData(true)
	end
end

function M:update()
	local gmFocusHero = HouseGMController.instance:getFocusHero()

	if not gmFocusHero then
		self:_joystickMove()
	else
		self:_tryFollowGMHero(gmFocusHero)
	end
end

function M:_tryFollowGMHero(gmFocusHero)
	if gmFocusHero then
		local gmUnit = HouseSceneUtil.getHousePlayerUnit(gmFocusHero)

		if gmUnit then
			local posX, posY, posZ = gmUnit.navMesh:getNavMeshGoPos()

			self:_updateFlowPos(posX, posY)

			local roomId, ringType = NavMeshUtil.surfaceGoNameToZoneId(gmUnit.navMesh:getCurAreaName())

			if roomId > 0 then
				self:_calculCamContrastAngle(posX, posY, ringType)
			end

			local angle = NavMeshUtil.calculateMoveAngle(posX, posY, gmUnit.navMesh:getCurAreaType(), gmUnit.navMesh:getCurZoneId())

			VirtualCameraMgr.instance:setCameraRotation(0, 0, angle)
		end
	end
end

function M:_onGmFocusHeroChange()
	self:_updateMoveData()
end

function M:_updateDesWithInterval()
	local count = Time.frameCount

	if math.fmod(count, UnityEngine.Application.targetFrameRate / 3) == 0 then
		self:_updateDestination()
	end
end

function M:_updateDestination()
	local posX, posY, posZ = self._unit.navMesh:getNavMeshGoPos()
	local ringType = self._unit.navMesh:getCurRingType()
	local areaType = self._unit.navMesh:getCurAreaType()
	local radius = HouseEnum.RingType2Radius[ringType]

	if radius then
		local angle = math.deg(math.atan2(posX, -posY))
		local leftX, leftY = HouseSceneUtil.calculCirclePos(radius, angle - 10)
		local rightX, rightY = HouseSceneUtil.calculCirclePos(radius, angle + 10)

		self._leftDestination:Set(leftX, leftY, kDefaultPosZ)
		self._rightDestination:Set(rightX, rightY, kDefaultPosZ)
	end

	if ringType == RingType.Fourth and areaType == NavMeshAreas.Room then
		local zoneId = self._unit.navMesh:getCurZoneId()
		local mo = HouseNavigationModel.instance:getMOByZoneId(zoneId)

		if mo then
			if math.fmod(zoneId, 2) == 1 then
				local leftBorder = mo:getLeftBorderPos()

				self._leftDestination:Set(leftBorder.x, leftBorder.y, kDefaultPosZ)
			else
				local rightBorder = mo:getRightBorderPos()

				self._rightDestination:Set(rightBorder.x, rightBorder.y, kDefaultPosZ)
			end
		end
	end
end

function M:enterElevator(levelId, pos)
	local gmFocusHero = HouseGMController.instance:getFocusHero()

	if self._elevatorStatus == ElevatorHeroStatus.None and not gmFocusHero then
		local posX, posY, posZ = self._unit:getAgentPos()
		local levelUnit = HouseSceneUtil.getElevatorUnit(levelId)

		if levelUnit then
			local waitPos = levelUnit.lineMgr:getWaitPos(1)

			posX, posY, posZ = waitPos.x, waitPos.y, waitPos.z
		end

		GlobalDispatcher:dispatchEvent(EventType.SCENE_CACHE_MAIN_PLAYER_POS, posX, posY, posZ)

		if levelId ~= self._currElevatorLevelId then
			self:setElevatorTarget(levelId, ElevatorMoveStatus.Hold)
		end

		self._unit.navMesh:setRadius(CommEnum.NavMeshRadius.EnterElevator)
		self._unit.navMesh:setDestination(pos)

		self._elevatorStatus = ElevatorHeroStatus.MoveInEleavtor
	end
end

function M:exitElevator()
	local gmFocusHero = HouseGMController.instance:getFocusHero()

	if self._elevatorStatus == ElevatorHeroStatus.InEleavtor and not gmFocusHero then
		local posX, posY, posZ = self._unit.navMesh:getNavMeshGoPos()

		vec3Temp:Set(posX, posY, posZ - 2)
		self._unit.navMesh:setNavMeshAgentStatus(true)
		self._unit.navMeshMover:setStopChangeAngle(false)
		self._unit.navMesh:setDestination(vec3Temp)

		self._elevatorStatus = ElevatorHeroStatus.MoveOutEleavtor
	end
end

function M:setElevatorTarget(levelId, dir)
	self._currElevatorLevelId = levelId or self._currElevatorLevelId
	self._elevatorDir = dir or self._elevatorDir
end

function M:getElevatorTarget()
	return self._currElevatorLevelId, self._elevatorDir
end

function M:getElevatorStatus()
	return self._elevatorStatus
end

function M:setCanLeftElevator(canLeft)
	self._canLeftElevator = canLeft
end

function M:interruptElevator()
	if self._elevatorStatus ~= ElevatorHeroStatus.None then
		self._unit.navMesh:setNavMeshAgentStatus(false)
		self:clearElevatorData()

		local pos = HouseModel.instance:getCacheMainPlayerPos()

		self._unit.navMesh:setNavAgentPos(pos.x, pos.y, pos.z)
		self._unit.navMesh:setNavMeshAgentStatus(true)
		self._unit.navMeshMover:setStopChangeAngle(false)
		self._unit.navMeshMover:setDirection(HouseEnum.UnitDirection.Forward)
	end
end

function M:getMoveStatus()
	return self._moveStatus
end

return M
