-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/behavior/FurniturePerformCtrl.lua

module("logic.extensions.house.scene.behavior.FurniturePerformCtrl", package.seeall)

local M = class("FurniturePerformCtrl", AbstractGlobalReusable)
local PerformStatus = HouseEnum.PerformStatus
local kDelimiterJH = "#"
local kCharList = {
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G"
}
local vec3Temp = Vector3.New()

function M:ctor()
	self._performUnits = {}
	self._performInsts = {}
	self._performIdxs = {}
	self._pathTimer = SchedulerCtrl.New(self._isAllUnitReady, self)
	self._waitingTimer = SchedulerCtrl.New(self._endWaiting, self)

	self:_clearPerformData()
end

function M:getCapacity()
	return 50
end

function M:reuse()
	return
end

function M:reset()
	self:_clearPerformData()
end

function M:destroy()
	self:reset()
	self._pathTimer:clear()

	self._pathTimer = nil

	self._waitingTimer:clear()

	self._waitingTimer = nil
end

function M:_clearPerformData()
	self._pathTimer:stop()
	self._waitingTimer:stop()
	self:_clearUnits()
	self:_clearPerformInst()

	self._performStatus = PerformStatus.None
	self._performFurniture = nil
	self._currPerformCO = nil
	self._currPerformQueue = nil
	self._endCallback = nil
	self._endTarget = nil
end

function M:getCtrlType()
	return HouseEnum.PerformCtrlType.Furniture
end

function M:getFurniture()
	return self._performFurniture
end

function M:isWorking()
	return self._performStatus ~= PerformStatus.None
end

function M:isWaitingPlayer()
	if self._performStatus == PerformStatus.Waiting and #self._performUnits < self._currPerformCO:getTriggerCount() then
		return true
	end

	return false
end

function M:setEndCallback(callback, target)
	self._endCallback = callback
	self._endTarget = target
end

function M:_clearUnits()
	table.clear(self._performUnits)
	table.clear(self._performIdxs)
end

function M:_clearPerformInst()
	for _, performInst in ipairs(self._performInsts) do
		performInst:returnSelf()
	end

	table.clear(self._performInsts)
end

function M:showPerformance(performCO)
	self._performStatus = PerformStatus.Waiting

	self:setPerformUnits(performCO)
	self:_beforeStartPerform()
	self:_startPathTimer()
end

function M:showPerformanceImmediate(performCO)
	self._performStatus = PerformStatus.Running

	self:setPerformUnits(performCO)
	self:_beforeStartPerform()

	for i, unit in ipairs(self._performUnits) do
		self:_placeUnitInFurniture(i)
	end

	self:_startPerformQueue()
end

function M:setPerformUnits(performCO)
	self._currPerformCO = performCO

	local furniture, dictUnits = performCO:getCachePerformDatas()

	self._performFurniture = furniture

	self:_clearUnits()
	self:_clearPerformInst()

	for idx, unit in pairs(dictUnits) do
		table.insert(self._performUnits, unit)

		local inst = HousePerformInstance:createInstance()

		table.insert(self._performInsts, inst)
		table.insert(self._performIdxs, idx)
		inst:setUnit(unit)
		inst:setFurniture(furniture, idx)
		unit.model:setReadyFurniturePerform(false)
	end
end

function M:_beforeStartPerform()
	for i, unit in ipairs(self._performUnits) do
		local idx = self._performIdxs[i]

		self._performFurniture.perform:setTriggerUsed(idx, true)
		unit.performCtrl:interrupt()
		unit.ai:stopCurrentAI()
		unit.performCtrl:setRunningCtrl(self)
	end
end

function M:interruptPerform()
	if self:isWorking() then
		self:endPerformance(true)
	end
end

function M:endPerformance(isInterrput)
	self._performStatus = PerformStatus.None

	for _, performInst in ipairs(self._performInsts) do
		if isInterrput then
			performInst:interruptPerform()
		else
			performInst:endPerform()
		end
	end

	self:_beforeEndPerform(isInterrput)

	if self._endCallback then
		self._endCallback(self._endTarget)
	end

	self:_clearPerformData()
end

function M:_beforeEndPerform(isInterrput)
	for i, unit in ipairs(self._performUnits) do
		local idx = self._performIdxs[i]

		self._performFurniture.perform:setTriggerUsed(idx, false)

		if self._performFurniture.perform:hasPathToTrigger() then
			unit.navMesh:setNavAgentPos(self._performFurniture.perform:getPathTriggerPos())
		end

		unit.performCtrl:setRunningCtrl(nil)
		unit.navMesh:setNavMeshAgentStatus(true)
		unit.navMeshMover:setStopChangeAngle(false)
		unit.model:setReadyFurniturePerform(false)
		unit.ai:setStop(false)
	end
end

function M:_endWaiting()
	if self:isWaitingPlayer() then
		self._pathTimer:stop()
		self:endPerformance()
	end
end

function M:_startPathTimer()
	vec3Temp:Set(self._performFurniture:getCenterWorldPos())

	for i, unit in ipairs(self._performUnits) do
		unit.navMesh:setDestination(vec3Temp)
	end

	self._pathTimer:restart(0.2, true)
	self._waitingTimer:restart(25, false)
end

function M:_isAllUnitReady()
	if self._performStatus == PerformStatus.Waiting then
		local isAllReady = true

		for i, unit in ipairs(self._performUnits) do
			local isReady = unit.model:isReadyFurniturePerform()
			local arrived = unit.navMeshMover:isArrivedDestination()

			if arrived and not isReady then
				self:_placeUnitInFurniture(i)
			end

			isAllReady = isAllReady and isReady
		end

		if isAllReady and #self._performUnits == self._currPerformCO:getTriggerCount() then
			self._pathTimer:stop()

			self._performStatus = PerformStatus.Running

			self:_startPerformQueue()
		end
	end
end

function M:_placeUnitInFurniture(i)
	local unit = self._performUnits[i]
	local idx = self._performIdxs[i]

	unit.navMesh:setNavMeshAgentStatus(false)
	unit.navMeshMover:setStopChangeAngle(true)
	unit.model:setReadyFurniturePerform(true)

	local posX, posY, posZ = self._performFurniture.perform:getTriggerPos(idx)

	unit.navMesh:setNavAgentPos(posX, posY, posZ)

	local rotaX, rotaY, rotaZ, rotaW = self._performFurniture.perform:getTriggerRotation(idx)
	local go = unit.navMesh:getNavMeshGo()

	Astral.TransformUtil.SetRotation(go.transform, rotaX, rotaY, rotaZ, rotaW)
	unit.meshModel:play(self._currPerformCO:getWaitActionName(), true)
end

function M:findRemainPerformUnits(freeUnits, onlyJudge)
	local canPerform = false
	local remainIdxs = self:getRemainIdxs()

	if #remainIdxs > 0 and #freeUnits > 0 then
		local hasUsedUnits = {}

		for _, triggerIdx in ipairs(remainIdxs) do
			if self._performFurniture.perform:isTriggerFree(triggerIdx) then
				for _, freeUnit in ipairs(freeUnits) do
					if not table.indexof(hasUsedUnits, freeUnit.heroId) and self._currPerformCO:isPlayerMatch(triggerIdx, freeUnit.heroId) then
						table.insert(hasUsedUnits, freeUnit.heroId)

						if not onlyJudge then
							self:_addRemainPerformUnit(triggerIdx, freeUnit)
						end

						canPerform = true

						break
					end
				end
			end
		end
	end

	return canPerform
end

function M:getRemainIdxs()
	local remainIdxs = {}
	local datas = self._currPerformCO:getMatchDatas()

	for idx, data in pairs(datas) do
		if not table.indexof(self._performIdxs, idx) then
			table.insert(remainIdxs, idx)
		end
	end

	return remainIdxs
end

function M:_addRemainPerformUnit(idx, unit)
	table.insert(self._performUnits, unit)

	local inst = HousePerformInstance:createInstance()

	table.insert(self._performInsts, inst)
	table.insert(self._performIdxs, idx)
	inst:setUnit(unit)
	inst:setFurniture(self._performFurniture, idx)
	unit.model:setReadyFurniturePerform(false)
	self._performFurniture.perform:setTriggerUsed(idx, true)
	unit.performCtrl:interrupt()
	unit.ai:stopCurrentAI()
	unit.performCtrl:setRunningCtrl(self)
	vec3Temp:Set(self._performFurniture:getCenterWorldPos())
	unit.navMesh:setDestination(vec3Temp)
end

function M:_startPerformQueue()
	self._currPerformQueue = self._currPerformCO:getPerformQueueClone()

	for _, performInst in ipairs(self._performInsts) do
		performInst:setFinishCallback(self._finishOnePerform, self)
		performInst:setPerformCO(self._currPerformCO)
	end

	self:_showNextPerform()
end

function M:_showNextPerform()
	if self._currPerformQueue:size() == 0 then
		self:endPerformance()

		return
	end

	local performs = self._currPerformQueue:dequeue()

	self._parallelPFTotalNum = #performs
	self._parallelPFNum = 0

	for _, perform in ipairs(performs) do
		local type = tonumber(perform.arr[1])
		local paramlist = string.split(perform.arr[2], kDelimiterJH)
		local performInst = self._performInsts[1]

		if table.indexof(HousePerformInstance.LimitPlayerTypes, type) then
			local idx = table.indexof(kCharList, paramlist[2])

			if idx then
				local i = table.indexof(self._performIdxs, idx)

				if i then
					performInst = self._performInsts[i]
				end
			end
		end

		performInst:perform(type, paramlist)
	end
end

function M:_finishOnePerform()
	self._parallelPFNum = self._parallelPFNum + 1

	if self._parallelPFNum >= self._parallelPFTotalNum then
		self:_showNextPerform()
	end
end

return M
