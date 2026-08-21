-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattlePositionChangedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattlePositionChangedCommand", package.seeall)

local BattlePositionChangedCommand = class("BattlePositionChangedCommand", BattleCommandBase)
local kRepelSpeed = 2.5

function BattlePositionChangedCommand:parseServerCommand(cmdParser, positionChangedEventNO)
	local cmd = BattlePositionChangedCommand:createInstance()
	local entities = positionChangedEventNO.entities

	for _, entityNO in ipairs(entities) do
		local position = entityNO.cell

		cmd:addEntityId(entityNO.id)
		cmd:addTransportUnionIndex(BoardIndexConverter.coordinatesToUnionIndex(position.x, position.z))
	end

	cmd:setPositionChangingMethod(positionChangedEventNO.method)
	cmd:setPerformanceEnable(BattleCmdUtil.isEnablePerformance(cmdParser, true))
	cmdParser:addCommand(cmd)
	cmdParser:addCommand(BattleDelayCommand:create(BattleConst.DelayZeroPointFive))
end

function BattlePositionChangedCommand:onInit()
	self._entityIds = {}
	self._transportUnionIndexes = {}
	self._positionChangingMethod = false
	self._isEnablePerformance = false
	self._timelineTask = false
end

function BattlePositionChangedCommand:onClear()
	if self._timelineTask then
		self._timelineTask:clear()
	end

	self._positionChangingMethod = false
	self._isEnablePerformance = false

	BattleTableUtil.clearTable(self._entityIds)
	BattleTableUtil.clearTable(self._transportUnionIndexes)
end

function BattlePositionChangedCommand:execute(battleFlow, runningContext)
	local model = BattleMgr.instance:getModel()
	local isReadyPhase = model:getPhase() == BattleEnum.Phase.READY

	if not isReadyPhase and self._isEnablePerformance then
		if self._positionChangingMethod == BattleExtension_pb.PositionChangingMethod.POSITION_CHANGING_METHOD_SUDDEN then
			self:_processAsTransport(runningContext)
		elseif self._positionChangingMethod == BattleExtension_pb.PositionChangingMethod.POSITION_CHANGING_METHOD_SMOOTH then
			self:_processAsRepel()
		else
			self:_processAsDefault()
		end
	else
		self:_processAsDefault()
	end
end

function BattlePositionChangedCommand:_changeLogicPosition()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local boardModel = BattleMgr.instance:getBoardModel()

	for i, entityId in ipairs(self._entityIds) do
		local unit = unitMgr:getUnit(entityId)
		local transportUnionIndex = self._transportUnionIndexes[i]

		boardModel:exchangeUnitToUnionIndex(unit, transportUnionIndex)
	end
end

function BattlePositionChangedCommand:_processAsTransport(runningContext)
	self:_changeLogicPosition()

	self._timelineTask = self._timelineTask or TimelineTask.New()

	self._timelineTask:clear()
	self._timelineTask:addTask(0, self._tFocusUnit, self)
	self._timelineTask:addTask(0.5, self._tBeforeTransport, self)
	self._timelineTask:addTask(0.5, self._tFocusTransport, self)
	self._timelineTask:addTask(0.5, self._tTransport, self)
	self._timelineTask:addTask(0.5, self._tTransportFinish, self)
	self._timelineTask:addFinishListener(self._onFinishPerformance, self)
	self._timelineTask:start(runningContext)
end

function BattlePositionChangedCommand:_processAsDefault()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	for i, entityId in ipairs(self._entityIds) do
		local unit = unitMgr:getUnit(entityId)
		local transportUnionIndex = self._transportUnionIndexes[i]

		boardMgr:exchangeUnitToUnionIndex(unit, transportUnionIndex)
		unit.meshModel:lookAtDirVec3(BattleCampAdjustmentModel.instance:getBornDirectionOfUnionIndex(transportUnionIndex))
	end

	self:finish(true)
end

function BattlePositionChangedCommand:_processAsRepel()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local boardModel = BattleMgr.instance:getBoardModel()

	for i, entityId in ipairs(self._entityIds) do
		local unit = unitMgr:getUnit(entityId)
		local transportUnionIndex = self._transportUnionIndexes[i]
		local position = boardMgr:getCellPosition(transportUnionIndex)

		boardModel:setUnitToUnionIndex(unit, transportUnionIndex)
		unit.meshModelMover:setLockDirection(true)
		unit.mover:setTempSpeedFactor(kRepelSpeed)
		unit.mover:addWayPoint(position.x, position.z)
	end

	self._timelineTask = self._timelineTask or TimelineTask.New()

	self._timelineTask:clear()
	self._timelineTask:addTask(BattleConst.DelayOne)
	self._timelineTask:addFinishListener(self._onFinishRepel, self)
	self._timelineTask:start()
end

function BattlePositionChangedCommand:_onFinishRepel()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	for i, entityId in ipairs(self._entityIds) do
		local unit = unitMgr:getUnit(entityId)

		unit.mover:resetTempSpeedFactor()
		unit.meshModelMover:setLockDirection(false)
		BattleDispatcher:dispatchEvent(BattleEventType.OnEntityMove, entityId)
	end

	self:finish(true)
end

function BattlePositionChangedCommand:_tFocusUnit(runningContext)
	local entityId = self:_getMainEntityId()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)
	local x, y, z = unit.meshModelMover:getPosXYZ()

	if not runningContext:getParam(BattleCmdRunningContext.Param_CameraLocked) then
		BattleCameraUtil.doFollowPosition(x, y, z, BattleConst.DelayZeroPointFive)
	end
end

function BattlePositionChangedCommand:_tBeforeTransport()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	for _, entityId in ipairs(self._entityIds) do
		local unit = unitMgr:getUnit(entityId)

		unit.effectPlayer:playEffect(BattleCampAdjustmentUtil.getPlaceEffectId(unit))
	end
end

function BattlePositionChangedCommand:_tFocusTransport(runningContext)
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local transportUnionIndex = self:_getMainTransportUnionIndex()
	local position = boardMgr:getCellPosition(transportUnionIndex)

	if not runningContext:getParam(BattleCmdRunningContext.Param_CameraLocked) then
		BattleCameraUtil.doFollowPosition(position.x, position.y, position.z, BattleConst.DelayZeroPointFive)
	end

	local unitMgr = BattleMgr.instance:getUnitMgr()

	for _, entityId in ipairs(self._entityIds) do
		local unit = unitMgr:getUnit(entityId)

		unit.material:setAlphaEnable(true)
		unit.material:doMainAlpha(0, 0.2)
		unit:setProxyVisible(false)
	end
end

function BattlePositionChangedCommand:_tTransport()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local boardMgr = BattleMgr.instance:getBoardMgr()

	for i, entityId in ipairs(self._entityIds) do
		local unit = unitMgr:getUnit(entityId)
		local transportUnionIndex = self._transportUnionIndexes[i]

		unit.material:setAlphaEnable(true)
		unit.material:doMainAlpha(1, BattleConst.DelayZeroPointFive)
		unit.effectPlayer:playEffect(BattleCampAdjustmentUtil.getPlaceEffectId(unit))
		boardMgr:exchangeUnitToUnionIndex(unit, transportUnionIndex)
	end
end

function BattlePositionChangedCommand:_tTransportFinish()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local boardMgr = BattleMgr.instance:getBoardMgr()

	for _, entityId in ipairs(self._entityIds) do
		local unit = unitMgr:getUnit(entityId)

		unit.material:doMainAlpha(1, 0)
		unit.material:setAlphaEnable(false)
		unit:setProxyVisible(true)
	end
end

function BattlePositionChangedCommand:_getMainEntityId()
	return self._entityIds[1]
end

function BattlePositionChangedCommand:_getMainTransportUnionIndex()
	return self._transportUnionIndexes[1]
end

function BattlePositionChangedCommand:_onFinishPerformance()
	self:finish(true)
end

function BattlePositionChangedCommand:addEntityId(entityId)
	table.insert(self._entityIds, entityId)

	return self
end

function BattlePositionChangedCommand:addTransportUnionIndex(unionIndex)
	table.insert(self._transportUnionIndexes, unionIndex)

	return self
end

function BattlePositionChangedCommand:setPerformanceEnable(isEnable)
	self._isEnablePerformance = isEnable

	return self
end

function BattlePositionChangedCommand:setPositionChangingMethod(positionChangingMethod)
	self._positionChangingMethod = positionChangingMethod

	return self
end

function BattlePositionChangedCommand:toString()
	return string.format("[position changed command entityIds = %s, transportUnionIndexes = %s, positionChangingMethod = %s, enablePerformance = %s]", BattleTableUtil.arrayToString(self._entityIds), BattleTableUtil.arrayToString(self._transportUnionIndexes), self._positionChangingMethod, tostring(self._isEnablePerformance))
end

return BattlePositionChangedCommand
