-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIPlayWorkToolAction.lua

module("logic.extensions.ai.impl.action.AIPlayWorkToolAction", package.seeall)

local M = class("AIPlayWorkToolAction", AINode)
local AnimationState = HouseEnum.AnimationState
local kRandomActions = {
	AnimationState.Speak,
	AnimationState.Happy,
	AnimationState.Sad,
	AnimationState.Jump,
	AnimationState.Shock,
	AnimationState.Nod,
	AnimationState.Shake
}
local ActionStatus = {
	RemoveTool = 4,
	CreateTools = 2,
	GoToWorkPoint = 1,
	WorkingAni = 3
}
local kMaxWorkCount = 4

function M:ctor(context)
	M.super.ctor(self, context)

	self._minWaitTime = 0
	self._maxWaitTime = 0
	self._endTime = 0
	self._isPlaying = false
	self._playWorkActionCount = 0
	self._allWorkActionCount = 0
	self._zoneId = 0
	self._workPoint = nil
	self._workPointIdx = -1
	self._actionStatus = nil
	self._nextActionTime = 0
	self._removeToolTimer = SchedulerCtrl.New(self._removeTool, self)
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._minWaitTime = aiConfigData.minTime
	self._maxWaitTime = aiConfigData.maxTime
end

function M:onStart()
	M.super.onStart(self)

	if self._isPlaying then
		self._removeToolTimer:stop()
	end

	self._isPlaying = false
	self._playWorkActionCount = 0
	self._allWorkActionCount = math.random(1, kMaxWorkCount)
	self._zoneId = self:getContext():getTargetRoomId()

	local unit = self:getContext():getUnit()

	if not unit.meshModel:containsAnimation(AnimationState.Call) or not unit.meshModel:containsAnimation(AnimationState.Work) then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	if self._endTime <= 0 then
		local waitTime = 0

		waitTime = math.random(self._minWaitTime, self._maxWaitTime)

		if waitTime <= 0 then
			return self:onEnd(AIConst.AIStatus.SUCCESS)
		else
			self._endTime = Time.time + waitTime
		end
	end

	if Time.time >= self._endTime then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	self:_startAction()

	return self
end

function M:handleEnd()
	self._endTime = 0
end

function M:onUpdate()
	local unit = self:getContext():getUnit()

	if Time.time >= self._endTime then
		if self._actionStatus == ActionStatus.CreateTools or self._actionStatus == ActionStatus.WorkingAni then
			self._actionStatus = ActionStatus.RemoveTool

			self._removeToolTimer:restart(0.6, false)

			self._nextActionTime = Time.time + unit.meshModel:getAnimationDuration(AnimationState.Call)

			unit.meshModel:play(AnimationState.Call, false)
		elseif self._actionStatus == ActionStatus.GoToWorkPoint then
			self._nextActionTime = 0
		end

		if Time.time >= self._nextActionTime then
			unit.navMesh:setNavMeshAgentStatus(true)
			unit.navMeshMover:setStopChangeAngle(false)

			local navMO = HouseNavigationModel.instance:getMOByZoneId(self._zoneId)

			navMO:releaseWorkPoint(self._workPointIdx)

			return self:onEnd(AIConst.AIStatus.SUCCESS)
		end
	elseif self._actionStatus == ActionStatus.GoToWorkPoint and unit.navMeshMover:isArrivedDestination() then
		self._actionStatus = ActionStatus.CreateTools

		unit.workTool:createWorkTool(0.6, self._workPoint)
		unit.navMesh:setNavMeshAgentStatus(false)
		unit.navMeshMover:setStopChangeAngle(true)

		local rot = self._workPoint.rot

		unit.navMesh:setNavAgentRot(rot.x, rot.y, rot.z)
		unit.meshModel:play(AnimationState.Call, false)

		self._nextActionTime = Time.time + unit.meshModel:getAnimationDuration(AnimationState.Call)
	elseif self._actionStatus >= ActionStatus.CreateTools and Time.time >= self._nextActionTime then
		self:_playWorkActionLoop()
	end

	return self
end

function M:_startAction()
	self._isPlaying = true
	self._actionStatus = ActionStatus.GoToWorkPoint

	local navMO = HouseNavigationModel.instance:getMOByZoneId(self._zoneId)

	self._workPoint, self._workPointIdx = navMO:rollUsableWorkPoint()

	local unit = self:getContext():getUnit()

	unit.navMesh:setNavMeshAgentStatus(true)
	unit.navMesh:setDestination(self._workPoint.pos)
	unit.navMesh:resumeNavMesh()
	unit.navMeshMover:setStopChangeAngle(false)
end

function M:_playWorkActionLoop()
	self._actionStatus = ActionStatus.WorkingAni

	local unit = self:getContext():getUnit()
	local actionName = AnimationState.Work

	if self._playWorkActionCount >= self._allWorkActionCount then
		actionName = self:_getRandomAction()
	end

	self._nextActionTime = Time.time + unit.meshModel:getAnimationDuration(actionName)

	unit.meshModel:play(actionName, false, true)

	if actionName == AnimationState.Work then
		self._playWorkActionCount = self._playWorkActionCount + 1
	else
		self._playWorkActionCount = 0
		self._allWorkActionCount = math.random(1, kMaxWorkCount)
	end
end

function M:_getRandomAction()
	local actions = {}
	local unit = self:getContext():getUnit()

	for _, action in ipairs(kRandomActions) do
		if unit.meshModel:containsAnimation(action) then
			table.insert(actions, action)
		end
	end

	if #actions > 0 then
		return actions[math.random(1, #actions)]
	end

	return AnimationState.Work
end

function M:_removeTool()
	local unit = self:getContext():getUnit()

	unit.workTool:removeWorkTool()

	self._isPlaying = false
end

function M:onReset()
	local unit = self:getContext():getUnit()

	if self._isPlaying then
		unit.navMesh:setNavMeshAgentStatus(true)
		unit.navMeshMover:setStopChangeAngle(false)
		unit.workTool:removeWorkTool()

		local remainTime = self._endTime - Time.time

		if remainTime > 0 then
			self._removeToolTimer:restart(remainTime, false)
		end

		local navMO = HouseNavigationModel.instance:getMOByZoneId(self._zoneId)

		if navMO then
			navMO:releaseWorkPoint(self._workPointIdx)
		end
	end

	M.super.onReset(self)
	self._removeToolTimer:clear()

	self._zoneId = 0
	self._workPoint = nil
	self._workPointIdx = -1
	self._actionStatus = nil
	self._nextActionTime = 0
end

function M:onRecycle()
	local unit = self:getContext():getUnit()

	if self._isPlaying then
		self._removeToolTimer:stop()
		unit.workTool:removeWorkTool()
	end

	M.super.onRecycle(self)

	self._endTime = 0
	self._isPlaying = false
	self._playWorkActionCount = 0
	self._allWorkActionCount = 0
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._removeToolTimer = nil
	self._endTime = nil
	self._isPlaying = nil
	self._playWorkActionCount = nil
	self._allWorkActionCount = nil
end

return M
