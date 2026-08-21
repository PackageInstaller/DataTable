-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AISleep.lua

module("logic.extensions.ai.impl.action.AISleep", package.seeall)

local M = class("AISleep", AINode)
local AnimationState = HouseEnum.AnimationState
local PlayerStatus = HouseEnum.PlayerStatus
local BehaviorStatus = HouseEnum.BehaviorStatus

function M:ctor(context)
	M.super.ctor(self, context)

	self._minWaitTime = 0
	self._maxWaitTime = 0
	self._endTime = 0
	self._sleeping = false
	self._bedUnit = nil
	self._triggerIdx = nil
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._minWaitTime = aiConfigData.minTime
	self._maxWaitTime = aiConfigData.maxTime
end

function M:onStart()
	M.super.onStart(self)

	self._sleeping = false

	if self._endTime <= 0 then
		local waitTime = 0

		if self._minWaitTime == self._maxWaitTime then
			waitTime = self._minWaitTime
		else
			waitTime = math.random(self._minWaitTime, self._maxWaitTime)
		end

		self._endTime = Time.time + waitTime
	end

	if Time.time >= self._endTime then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	local unit = self:getContext():getUnit()
	local roomUnit = HouseSceneUtil.getHouseRoomUnit(unit.navMesh:getCurZoneId())
	local zoneMO, bunkInfo = LivingFacilitiesZoneController.instance:findZoneByHeroId(unit.heroId)

	if zoneMO and roomUnit then
		local bedUnit = roomUnit.furnitureMgr:getFurnitureByUUId(bunkInfo.furnitureUUId)

		if bedUnit then
			local idx = bunkInfo.index
			local posX = bedUnit.perform:getTriggerPos(idx)

			if bedUnit.perform:isTriggerFree(idx) and bedUnit.perform:hasPathToTrigger() and posX then
				self:_startSleepAction(bedUnit, idx)

				return self
			end
		end
	end

	return self:onEnd(AIConst.AIStatus.FAILD)
end

function M:onUpdate()
	if Time.time >= self._endTime then
		self:_endSleepAction()

		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self
end

function M:handleEnd()
	self._endTime = 0
	self._sleeping = false
	self._bedUnit = nil
	self._triggerIdx = nil
end

function M:_startSleepAction(bedUnit, triggerIdx)
	self._sleeping = true
	self._bedUnit = bedUnit
	self._triggerIdx = triggerIdx

	local unit = self:getContext():getUnit()

	unit.model:setStatus(PlayerStatus.Sleeping)
	unit.model:setBehaviorStatus(BehaviorStatus.Sleep)
	unit.navMesh:setNavMeshAgentStatus(false)
	unit.navMeshMover:setStopChangeAngle(true)

	self._unitPosX, self._unitPosY, self._unitPosZ = unit.navMesh:getNavMeshGoPos()

	bedUnit.perform:setTriggerUsed(triggerIdx, true)

	local posX, posY, posZ = bedUnit.perform:getTriggerPos(triggerIdx)

	unit.navMesh:setNavAgentPos(posX, posY, posZ)

	local rotaX, rotaY, rotaZ, rotaW = bedUnit.perform:getTriggerRotation(triggerIdx)
	local go = unit.navMesh:getNavMeshGo()

	Astral.TransformUtil.SetRotation(go.transform, rotaX, rotaY, rotaZ, rotaW)
	unit.meshModel:play(AnimationState.Sleep, true)
end

function M:_endSleepAction()
	self._sleeping = false

	local unit = self:getContext():getUnit()

	unit.navMesh:setNavAgentPos(self._unitPosX, self._unitPosY, self._unitPosZ)
	unit.navMesh:setNavMeshAgentStatus(true)
	unit.navMeshMover:setStopChangeAngle(false)
	unit.model:clearStatus(PlayerStatus.Sleeping)
	unit.model:clearBehaviorStatus(BehaviorStatus.Sleep)
	unit.meshModel:play(AnimationState.Idle, true)

	if self._bedUnit:isEffective() then
		self._bedUnit.perform:setTriggerUsed(self._triggerIdx, false)
	end
end

function M:onReset()
	if self._sleeping then
		self:_endSleepAction()
	end

	M.super.onReset(self)

	self._sleeping = false
	self._bedUnit = nil
	self._triggerIdx = nil
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	if self._sleeping then
		self:_endSleepAction()
	end

	M.super.onRecycle(self)

	self._endTime = 0
	self._sleeping = false
	self._bedUnit = nil
	self._triggerIdx = nil
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._endTime = 0
	self._sleeping = false
	self._bedUnit = nil
	self._triggerIdx = nil
end

return M
