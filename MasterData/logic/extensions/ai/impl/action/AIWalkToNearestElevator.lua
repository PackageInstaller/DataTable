-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIWalkToNearestElevator.lua

module("logic.extensions.ai.impl.action.AIWalkToNearestElevator", package.seeall)

local M = class("AIWalkToNearestElevator", AINode)
local AnimationState = HouseEnum.AnimationState
local BehaviorStatus = HouseEnum.BehaviorStatus
local vec3Temp = Vector3.New()

function M:ctor(context)
	M.super.ctor(self, context)

	self._needChangeProSuit = false
	self._wearSuitStatus = 0
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)
end

function M:onStart()
	M.super.onStart(self)

	self._needChangeProSuit = false
	self._targetElevatorId = nil
	self._targetElevatorUnit = nil

	local unit = self:getContext():getUnit()
	local targetZoneId = self:getContext():getTargetRoomId()

	if not targetZoneId or targetZoneId and targetZoneId <= 0 then
		printWarn(string.format("角色%s目标区域id错误，区域id：%s", unit.heroId, targetZoneId))

		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	unit.performCtrl:setTriggerFurniture(false)
	unit.performCtrl:setForbid(HouseEnum.PerformForbidKey.HousePerform, true)
	self:_findTargetElevator(true)

	if self:_moveToTargetElevator() then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self
end

function M:onUpdate()
	local unit = self:getContext():getUnit()
	local hasArrived = unit.navMeshMover:isArrivedDestination()

	if self._needChangeProSuit then
		-- block empty
	else
		if math.fmod(Time.frameCount, 40) == 0 then
			self:_findTargetElevator(true)
		end

		if self:_moveToTargetElevator() then
			return self:onEnd(AIConst.AIStatus.SUCCESS)
		end
	end

	return self
end

function M:handleEnd()
	local unit = self:getContext():getUnit()

	unit.performCtrl:setTriggerFurniture(true)
	unit.performCtrl:setForbid(HouseEnum.PerformForbidKey.HousePerform, false)
end

function M:_findTargetElevator(withQueue)
	local unit = self:getContext():getUnit()
	local ringType = unit.navMesh:getCurRingType()
	local posX, posY, posZ = unit.navMesh:getNavMeshGoPos()
	local targetZoneId = self:getContext():getTargetRoomId()

	vec3Temp:Set(posX, posY, posZ)

	self._targetElevatorId, self._targetElevatorUnit = HouseSceneUtil.getNearestElevatorId(vec3Temp, ringType, targetZoneId, withQueue)
end

function M:_moveToTargetElevator()
	if self._targetElevatorId then
		local unit = self:getContext():getUnit()

		if self._targetElevatorUnit.lineMgr:addWaitUnit(unit) then
			local targetZoneId = self:getContext():getTargetRoomId()
			local targetRingType = NavMeshUtil.getRingTypeByZoneId(targetZoneId)
			local adjustRingType = HouseSceneUtil.adjustRingType(self._targetElevatorId, targetRingType)

			unit.model:setLevelIdAndRingType(self._targetElevatorId, adjustRingType)

			return true
		end
	end

	return false
end

function M:onReset()
	local unit = self:getContext():getUnit()

	M.super.onReset(self)

	self._needChangeProSuit = false
	self._wearSuitStatus = 0
	self._targetElevatorId = nil
	self._targetElevatorUnit = nil
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	self:_removeUnitSpineEvent()
	M.super.onRecycle(self)

	self._needChangeProSuit = false
	self._wearSuitStatus = 0
	self._targetElevatorId = nil
	self._targetElevatorUnit = nil
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._needChangeProSuit = false
	self._wearSuitStatus = 0
	self._targetElevatorId = nil
	self._targetElevatorUnit = nil
end

function M:_removeUnitSpineEvent()
	return
end

return M
