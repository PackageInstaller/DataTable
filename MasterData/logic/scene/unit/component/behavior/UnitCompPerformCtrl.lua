-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/behavior/UnitCompPerformCtrl.lua

module("logic.scene.unit.component.behavior.UnitCompPerformCtrl", package.seeall)

local M = class("UnitCompPerformCtrl", UnitComponentBase)
local BehaviorStatus = HouseEnum.BehaviorStatus
local BehaviorType = HouseEnum.BehaviorType
local AnimationState = HouseEnum.AnimationState
local PerformForbidKey = HouseEnum.PerformForbidKey
local DOUBLE_PERFORM_CD = 30
local vec3Temp = Vector3.New()

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._enableContact = nil
	self._runningCtrl = nil
	self._isPlayingShelterInvalid = nil
	self._dictForbid = {}
	self._isForbid = false
	self._isUnitStop = false
	self._canTriggerFurn = true
end

function M:onInit()
	self._stopContactCdTimer = SchedulerCtrl.New(self._stopContactCd, self)

	self:_resetData()
	self:_setEvents(true)
end

function M:onReuse()
	self:_setEvents(true)
end

function M:onReset()
	self._stopContactCdTimer:stop()
	self:_setEvents(false)
	self:_resetData()
end

function M:onDestroy()
	self:onReset()
	self._stopContactCdTimer:clear()

	self._stopContactCdTimer = nil
end

function M:_resetData()
	self._enableContact = true
	self._runningCtrl = nil
	self._isPlayingShelterInvalid = false

	table.clear(self._dictForbid)

	self._isForbid = false
	self._isUnitStop = false
	self._canTriggerFurn = true
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.START_HERO_SHELTER_INVALID, self._onStartShelterInvalid, self)
		HouseDispatcher:addEventListener(HouseEventType.END_HERO_SHELTER_INVALID, self._onEndShelterInvalid, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_CLOTH_OPEN, self._onFurnitureEditStart, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_END, self._onFurnitureEditEnd, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.START_HERO_SHELTER_INVALID, self._onStartShelterInvalid, self)
		HouseDispatcher:removeEventListener(HouseEventType.END_HERO_SHELTER_INVALID, self._onEndShelterInvalid, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_CLOTH_OPEN, self._onFurnitureEditStart, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_END, self._onFurnitureEditEnd, self)
	end
end

function M:interrupt()
	if self._runningCtrl then
		self._runningCtrl:interruptPerform()
	end
end

function M:setRunningCtrl(ctrl)
	self._runningCtrl = ctrl
end

function M:getRunningCtrl()
	return self._runningCtrl
end

function M:setTriggerFurniture(canTrigger)
	self._canTriggerFurn = canTrigger
end

function M:canTriggerFurniture()
	return self._canTriggerFurn
end

function M:setForbid(key, isForbid)
	self._dictForbid[key] = isForbid
	self._isForbid = false

	for _, isForbid in pairs(self._dictForbid) do
		if isForbid == true then
			self._isForbid = true

			break
		end
	end
end

function M:getForbid()
	return self._isForbid
end

function M:enableContact()
	return self._enableContact
end

function M:startContactCd()
	self._enableContact = false

	self._stopContactCdTimer:restart(DOUBLE_PERFORM_CD, false)
end

function M:_stopContactCd()
	self._enableContact = true
end

function M:_tryStopUnitWhenEditStart()
	local roomId = LivingFacilitiesZoneController.instance:getCurrentZoneId()
	local navMO = HouseNavigationModel.instance:getMOByZoneId(roomId)
	local roomNavName = navMO:getSurfaceGoName()
	local roomLeftLinkName = ""
	local leftLink = navMO:getLeftLink()

	if leftLink then
		roomLeftLinkName = leftLink.gameObject.name
	end

	local roomRightLinkName = ""
	local rightLink = navMO:getRightLink()

	if rightLink then
		roomRightLinkName = rightLink.gameObject.name
	end

	local unitNavName = self._unit.navMesh:getCurAreaName()
	local roomUnit = HouseSceneUtil.getHouseRoomUnit(roomId)

	self._isUnitStop = false

	if unitNavName == roomNavName then
		self._isUnitStop = true

		vec3Temp:Set(roomUnit.furnitureMap:getLeftDoorInsidePos())
	elseif unitNavName == roomLeftLinkName then
		self._isUnitStop = true

		vec3Temp:Set(roomUnit.furnitureMap:getLeftDoorOutsidePos())
	elseif unitNavName == roomRightLinkName then
		self._isUnitStop = true

		vec3Temp:Set(roomUnit.furnitureMap:getRightDoorOutsidePos())
	end

	local targetPos = vec3Temp

	if self._isUnitStop then
		self._unit.ai:stopCurrentAI()
		self._unit.navMesh:setNavMeshAgentStatus(false)
		self._unit.meshModel:play(AnimationState.Idle, true)
		self._unit.navMesh:setNavAgentPos(targetPos.x, targetPos.y, targetPos.z)

		local robotUnit = self._unit.followRobot:getFollowUnit()

		if robotUnit then
			self._unit.followRobot:switchFollow(false)
			robotUnit.navMesh:setNavMeshAgentStatus(false)
			robotUnit.navMesh:setNavAgentPos(targetPos.x, targetPos.y, targetPos.z)
		end
	else
		local robotUnit = self._unit.followRobot:getFollowUnit()

		if robotUnit then
			local robotNavName = robotUnit.navMesh:getCurAreaName()

			if robotNavName == roomNavName or robotNavName == roomLeftLinkName or robotNavName == roomRightLinkName then
				self._unit.followRobot:switchFollow(false)
				robotUnit.navMesh:setNavMeshAgentStatus(false)
				robotUnit.navMesh:setNavAgentPos(self._unit.navMesh:getNavMeshGoPos())
				robotUnit.navMesh:setNavMeshAgentStatus(true)
				self._unit.followRobot:switchFollow(true)
			end
		end
	end
end

function M:_recoverUnitWhenEditEnd()
	if self._isUnitStop then
		self._isUnitStop = false

		self._unit.navMesh:setNavMeshAgentStatus(true)
		self._unit.ai:setStop(false)

		local robotUnit = self._unit.followRobot:getFollowUnit()

		if robotUnit then
			self._unit.followRobot:switchFollow(true)
			robotUnit.navMesh:setNavMeshAgentStatus(true)
		end
	end
end

function M:_onStartShelterInvalid(e, roomId)
	if self._unit.navMesh:getCurZoneId() == roomId then
		self._isPlayingShelterInvalid = true

		self._unit.model:setBehaviorStatus(BehaviorStatus.ShelterInvalid)
		self._unit.performCtrl:interrupt()
		self._unit.behaviorMgr:createBehaviorInFirst(BehaviorType.ShelterInvalid)
		self._unit.ai:restartCurrAI()
		self._unit.navMesh:setAgentSpeed(CommEnum.NavMeshAgentSpeed.HeroRun)
	end
end

function M:_onEndShelterInvalid(e, roomId)
	if self._isPlayingShelterInvalid then
		self._isPlayingShelterInvalid = false

		self._unit.model:clearBehaviorStatus(BehaviorStatus.ShelterInvalid)
		self._unit.behaviorMgr:removeFirstBehavior()
		self._unit.ai:restartCurrAI()
		self._unit.navMesh:setAgentSpeed(CommEnum.NavMeshAgentSpeed.HeroWalk)
		self._unit.navMeshMover:resetActionName()
	end
end

function M:_onFurnitureEditStart()
	self:setForbid(PerformForbidKey.EditFurniture, true)
	self:interrupt()
	self:_tryStopUnitWhenEditStart()
	self._unit.bubble:endBubble()
	self._unit.progressBar:setVisible(false)
end

function M:_onFurnitureEditEnd()
	self:setForbid(PerformForbidKey.EditFurniture, false)
	self:_recoverUnitWhenEditEnd()
	self._unit.progressBar:setVisible(true)
end

return M
