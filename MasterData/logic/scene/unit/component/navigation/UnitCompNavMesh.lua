-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/navigation/UnitCompNavMesh.lua

module("logic.scene.unit.component.navigation.UnitCompNavMesh", package.seeall)

local NavMeshAreas = SceneEnum.NavMeshAreas
local M = class("UnitCompNavMesh", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._navMeshGo = self._unit.go
	self._navMeshAgent = false
	self._curAreaType = NavMeshAreas.Walkable
	self._curAreaName = ""
	self._destination = Vector3.New()
	self._enable = true
	self._curZoneId = 0
	self._usePatrolPoint = nil
	self._needResetNavMesh = false
	self._priority = 50
	self._isMainPlayer = false
	self._preMeshOwner = nil
	self._isManualWalkLink = false
	self._linkAgentStartPos = nil
	self._linkAgentEndPos = nil
	self._linkWalkStep = 0
	self._linkTotalTime = 0
	self._oldUpdateRotation = false
	self._oldUpdateUpAxis = false
	self._radius = CommEnum.NavMeshRadius.Common
end

function M:onInit()
	M.super.onInit(self)

	self._navMeshAgent = goutil.addComponentOnce(self._navMeshGo, ComponentType.NavMeshAgent)
	self._navMeshAgent.speed = CommEnum.NavMeshAgentSpeed.MasterWalk
	self._navMeshAgent.acceleration = 1000
	self._navMeshAgent.baseOffset = 0
	self._navMeshAgent.obstacleAvoidanceType = UnityEngine.AI.ObstacleAvoidanceType.LowQualityObstacleAvoidance
	self._navMeshAgent.avoidancePriority = self._priority
	self._navMeshAgent.autoTraverseOffMeshLink = false
	self._navMeshAgent.updateRotation = false
	self._navMeshAgent.radius = self._radius
	self._enable = true
	self._refreshAreaNameTimer = SchedulerCtrl.New(self._refreshAreaName, self)
	self._drawPathLineTimer = SchedulerCtrl.New(self._drawPathLine, self)

	self:_setEvents(true)
end

function M:onReuse()
	self:_setEvents(true)
end

function M:onReset()
	self:_setEvents(false)
	self._refreshAreaNameTimer:stop()
	self._drawPathLineTimer:stop()

	self._navMeshAgent.avoidancePriority = 0
	self._priority = 0
	self._isMainPlayer = false
	self._preMeshOwner = nil
	self._isManualWalkLink = false
	self._linkWalkStep = 0
	self._linkTotalTime = 0

	if self._needResetNavMesh then
		self:setNavMeshAgentStatus(false)
		self:setNavAgentPos(0, 0, 0)

		self._curAreaType = NavMeshAreas.Walkable
		self._curAreaName = ""
		self._curZoneId = 0
	end

	self:releaseUsePatrolPoint()
end

function M:onDestroy()
	self:_setEvents(false)
	self._refreshAreaNameTimer:clear()

	self._refreshAreaNameTimer = nil

	self._drawPathLineTimer:clear()

	self._drawPathLineTimer = nil

	self:releaseUsePatrolPoint()
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.GM_SHOW_HERO_PATH, self._onSwitchDrawPathLine, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.GM_SHOW_HERO_PATH, self._onSwitchDrawPathLine, self)
	end
end

function M:setIsMainPlayer(isMainPlayer)
	self._isMainPlayer = isMainPlayer
end

function M:getIsMainPlayer()
	return self._isMainPlayer
end

function M:getNavMeshGo()
	return self._navMeshGo
end

function M:getNavMeshGoPos()
	return Astral.TransformUtil.GetPos(self._navMeshGo.transform, 0, 0, 0)
end

function M:getNavMeshGoOriginPos()
	return self._unit.mountRoot:getRelativeWorldPosByLocalPos(0, self._navMeshAgent.baseOffset * -1, 0)
end

function M:setNavMeshAgentStatus(status)
	if self._enable ~= status then
		self._enable = status
		self._navMeshAgent.enabled = status

		if status then
			self._refreshAreaNameTimer:restart(0, false)
		end
	end

	if not status then
		self._unit.navMeshMover:resetIdleCount()
		self._unit.navMeshMover:clearFrameData()
	end
end

function M:_refreshAreaName()
	if self._navMeshAgent.navMeshOwner then
		self._curAreaName = self._navMeshAgent.navMeshOwner.name

		self:_refreshZoneId()
	end
end

function M:setNavAgentPos(x, y, z)
	Astral.TransformUtil.SetPos(self._navMeshGo.transform, x, y, z)
end

function M:setNavAgentRot(x, y, z)
	TransformUtils.SetEulerAngles(self._navMeshGo.transform, x, y, z)
end

function M:getRemainingDistance()
	if self._enable and self._navMeshAgent.isOnNavMesh and not self._navMeshAgent.pathPending then
		return self._navMeshAgent.remainingDistance
	end

	return false
end

function M:stopNavMesh()
	if self._navMeshAgent.isOnNavMesh then
		self._navMeshAgent.isStopped = true
	else
		printWarn("the agent is not bound to the navmesh currently", debug.traceback())
	end
end

function M:resumeNavMesh()
	if self._navMeshAgent.isOnNavMesh then
		self._navMeshAgent.isStopped = false
	else
		printWarn("the agent is not bound to the navmesh currently", debug.traceback())
	end
end

function M:getIsStopped()
	return self._navMeshAgent.isStopped
end

function M:setAgentSpeed(speed)
	self._navMeshAgent.speed = speed
end

function M:getAgentSpeed()
	return self._navMeshAgent.speed
end

function M:getAgentVelocity()
	return self._navMeshAgent.velocity
end

function M:setAgentBaseOffset(offset)
	self._navMeshAgent.baseOffset = offset
end

function M:setRadius(radius)
	self._radius = radius or CommEnum.NavMeshRadius.Common

	self:setAgentRadius(self._radius)
end

function M:getRadius()
	return self._radius
end

function M:setAgentRadius(radius)
	self._navMeshAgent.radius = radius
end

function M:getAgentRadius()
	return self._navMeshAgent.radius
end

function M:setUpdateUpAxis(updateUpAxis)
	self._navMeshAgent.updateUpAxis = updateUpAxis
end

function M:resetPath()
	self._navMeshAgent:ResetPath()
end

function M:setAgentDestination(destination)
	self._navMeshAgent:SetDestination(destination)
end

function M:isOnNavMesh()
	return self._navMeshAgent.isOnNavMesh
end

function M:activateCurrentOffMeshLink(isActive)
	self._navMeshAgent:ActivateCurrentOffMeshLink(isActive)
end

function M:calculatePath(dstPoint, kNavMeshPath)
	return self._navMeshAgent:CalculatePath(dstPoint, kNavMeshPath)
end

function M:setDestination(destination)
	if self._navMeshAgent.isOnNavMesh then
		self._destination:Set(destination.x, destination.y, destination.z)
		self._navMeshAgent:SetDestination(destination)
		self:releaseUsePatrolPoint()
		self._unit.navMeshMover:resetIdleCount()
	else
		printWarn("the agent is not bound to the navmesh currently", debug.traceback())
	end
end

function M:refreshDestination()
	self:setDestination(self._destination)
end

function M:getDestination()
	return self._destination
end

function M:getIsEnable()
	return self._enable
end

function M:_areaChange(curAreaType, preAreaType, areaName)
	self._curAreaType = curAreaType
	self._curAreaName = areaName

	self:_refreshZoneId()
	self._unit:dispatchInnerEvent(UnitActionType.NavMeshAreaChange, curAreaType, preAreaType, areaName)
end

function M:getCurAreaType()
	return self._curAreaType
end

function M:getCurAreaName()
	return self._curAreaName
end

function M:_refreshZoneId()
	local oldZoneId = self._curZoneId
	local zoneId, ringType = NavMeshUtil.surfaceGoNameToZoneId(self._curAreaName)

	if zoneId > 0 then
		self._curZoneId, self._curRingType = zoneId, ringType

		if oldZoneId ~= self._curZoneId then
			self._unit:dispatchInnerEvent(UnitActionType.ZoneIdChange, self._curZoneId, oldZoneId)
		end
	end
end

function M:getCurZoneId()
	return self._curZoneId
end

function M:getCurRingType()
	return self._curRingType
end

function M:movetoRandomPosInTargetZone(targetZoneId)
	local zoneId = targetZoneId or self._curZoneId
	local mo = HouseNavigationModel.instance:getMOByZoneId(zoneId)
	local destination, idx = mo:getRandomPoint()

	if destination then
		self:releaseUsePatrolPoint()
		self:setDestination(destination)

		self._usePatrolPoint = {}
		self._usePatrolPoint.zoneId = zoneId
		self._usePatrolPoint.pointIdx = idx

		mo:usePoint(idx, self._unit.heroId)

		return true, destination
	end

	return false
end

function M:releaseUsePatrolPoint()
	if self._usePatrolPoint then
		local mo = HouseNavigationModel.instance:getMOByZoneId(self._usePatrolPoint.zoneId)

		if mo then
			mo:releasePoint(self._usePatrolPoint.pointIdx, self._unit.heroId)
		end
	end

	self._usePatrolPoint = nil
end

function M:getIsManualWalk()
	return NavMeshAreas.Link == self._curAreaType
end

function M:setNeedResetNavMesh(need)
	self._needResetNavMesh = need
end

function M:setAvoidancePriority(priority)
	self._navMeshAgent.avoidancePriority = priority
end

function M:setAvoidanceType(avoidanceType)
	self._navMeshAgent.obstacleAvoidanceType = avoidanceType
end

function M:getAvoidancePriority()
	return self._navMeshAgent.avoidancePriority
end

function M:_dealAreaChange(areaType, obj)
	local preArea = -1

	if self._preMeshOwner ~= nil then
		if NavigationUtils.IsNavMeshLink(self._preMeshOwner) then
			local meshLink = NavigationUtils.ToNavMeshLink(self._preMeshOwner)

			preArea = meshLink.area
		else
			local surface = NavigationUtils.ToNavMeshSurface(self._preMeshOwner)

			preArea = surface.defaultArea
		end
	end

	if preArea ~= areaType then
		self:_areaChange(areaType, preArea, obj.name)

		self._preMeshOwner = obj
	end
end

function M:update()
	if self._navMeshAgent.enabled then
		if self._navMeshAgent.isOnOffMeshLink then
			local link = NavigationUtils.ToNavMeshLink(self._navMeshAgent.navMeshOwner)

			self:_dealAreaChange(link.area, self._navMeshAgent.navMeshOwner)

			if self._isManualWalkLink then
				self:_updateWalkNavMeshLink()
			end
		else
			local curSurface = NavigationUtils.ToNavMeshSurface(self._navMeshAgent.navMeshOwner)

			if curSurface then
				self:_dealAreaChange(curSurface.defaultArea, self._navMeshAgent.navMeshOwner)
			end
		end
	end
end

function M:setIsManualWalkLink(isManualWalkLink)
	self._isManualWalkLink = isManualWalkLink
end

function M:getIsManualWalkLink()
	return _isManualWalkLink
end

function M:startManualNavMeshLink()
	local link = NavigationUtils.ToNavMeshLink(self._navMeshAgent.navMeshOwner)

	if link then
		self._oldUpdateRotation = self._navMeshAgent.updateRotation
		self._oldUpdateUpAxis = self._navMeshAgent.updateUpAxis
		self._navMeshAgent.updateRotation = false
		self._navMeshAgent.updateUpAxis = false
		self._linkAgentStartPos = self._navMeshAgent.transform.position
		self._linkAgentEndPos = self._navMeshAgent.currentOffMeshLinkData.endPos

		local duration = Vector3.Magnitude(self._linkAgentEndPos - self._linkAgentStartPos) / self._navMeshAgent.speed

		self._linkWalkStep = 1 / duration
		self._linkTotalTime = 0

		self._navMeshAgent:ActivateCurrentOffMeshLink(false)
		self:setIsManualWalkLink(true)
	end
end

function M:getLinkEndPos()
	return self._linkAgentEndPos
end

function M:stopManualNavMeshLink(isCompleteOffMeshLink)
	self:setIsManualWalkLink(false)

	if isCompleteOffMeshLink then
		self._navMeshAgent:CompleteOffMeshLink()
	end
end

function M:_updateWalkNavMeshLink()
	self._linkTotalTime = self._linkTotalTime + self._linkWalkStep * Time.deltaTime

	local pos = Vector3.Lerp(self._linkAgentStartPos, self._linkAgentEndPos, self._linkTotalTime)

	Astral.TransformUtil.SetPos(self._navMeshAgent.transform, pos.x, pos.y, pos.z)

	if self._linkTotalTime >= 1 then
		self._linkTotalTime = 0
		self._isManualWalkLink = false
		self._navMeshAgent.updateRotation = self._oldUpdateRotation
		self._navMeshAgent.updateUpAxis = self._oldUpdateUpAxis

		self._navMeshAgent:ActivateCurrentOffMeshLink(true)
		self._navMeshAgent:CompleteOffMeshLink()
	end
end

function M:_onSwitchDrawPathLine(e, isOn)
	if Astral.OSDef.isEditor and isOn then
		self._drawPathLineTimer:restart(1, true)
	else
		self._drawPathLineTimer:stop()
	end
end

function M:_drawPathLine()
	if self._enable and Astral.OSDef.isEditor then
		local path = self._navMeshAgent.path

		if path and path.corners and path.corners.Length > 1 then
			for i = 1, path.corners.Length - 1 do
				UnityEngine.Debug.DrawLine(path.corners[i - 1], path.corners[i], Color.New(0.9, 0.1, 0.1, 255), 1)
			end
		end
	end
end

return M
