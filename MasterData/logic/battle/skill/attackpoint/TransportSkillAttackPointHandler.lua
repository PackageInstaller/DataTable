-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/TransportSkillAttackPointHandler.lua

module("logic.battle.skill.attackpoint.TransportSkillAttackPointHandler", package.seeall)

local TransportSkillAttackPointHandler = class("TransportSkillAttackPointHandler", AbstractGlobalReusable, ISkillAttackPointHandler)
local kRepelSpeed = 10

function TransportSkillAttackPointHandler:parseEventNO(positionChangedEventNO)
	local entities = positionChangedEventNO.entities

	if #entities > 1 and BattleLog.enableError then
		BattleLog.error(string.format("unhandle position changed entity count[%s]", #entities))
	end

	local entity = entities[1]
	local position = entity.cell
	local handler = TransportSkillAttackPointHandler:createInstance()

	handler:setEntityId(entity.id)
	handler:setPositionChangingMethod(positionChangedEventNO.method)
	handler:setTransportUnionIndex(BoardIndexConverter.coordinatesToUnionIndex(position.x, position.z))

	local refCell = positionChangedEventNO.refCell

	if refCell then
		handler:setRefUnionIndex(BoardIndexConverter.coordinatesToUnionIndex(refCell.x, refCell.z))
	end

	return handler
end

function TransportSkillAttackPointHandler:ctor()
	self:reset()
end

function TransportSkillAttackPointHandler:reset()
	self:_clearUnitMoveListener()

	self._entityId = false
	self._transportUnionIndex = false
	self._isExecuted = false
	self._refUnionIndex = false
	self._executeTimes = 1
	self._positionChangingMethod = false

	if self._timelineTask then
		self._timelineTask:clear()
	end
end

function TransportSkillAttackPointHandler:_onPosChanged()
	BattleDispatcher:dispatchEvent(BattleEventType.OnEntityMove, self._unit.property:getEntityId())
end

function TransportSkillAttackPointHandler:_AddUnitMoveListener(unit)
	unit:addInnerEventListener(UnitActionType.PosChanged, self._onPosChanged, self)

	self._unit = unit
end

function TransportSkillAttackPointHandler:_clearUnitMoveListener()
	if self._unit then
		self._unit:removeInnerEventListener(UnitActionType.PosChanged, self._onPosChanged, self)

		self._unit = false
	end
end

function TransportSkillAttackPointHandler:destroy()
	self:reset()
end

function TransportSkillAttackPointHandler:build(context)
	return
end

function TransportSkillAttackPointHandler:handleAttackPoint(context, attackPointIndex)
	if self._positionChangingMethod == BattleExtension_pb.PositionChangingMethod.POSITION_CHANGING_METHOD_SUDDEN then
		self:_processAsTransport(context, attackPointIndex)
	elseif self._positionChangingMethod == BattleExtension_pb.PositionChangingMethod.POSITION_CHANGING_METHOD_SMOOTH then
		self:_processAsRepel(context, attackPointIndex)
	end
end

function TransportSkillAttackPointHandler:_processAsRepel()
	if self._executeTimes == 1 then
		local unitMgr = BattleMgr.instance:getUnitMgr()
		local boardMgr = BattleMgr.instance:getBoardMgr()
		local boardModel = BattleMgr.instance:getBoardModel()
		local unit = unitMgr:getUnit(self._entityId)
		local transportUnionIndex = self._transportUnionIndex
		local position = boardMgr:getCellPosition(transportUnionIndex)

		self:_AddUnitMoveListener(unit)
		boardModel:setUnitToUnionIndex(unit, transportUnionIndex)
		unit.meshModelMover:setLockDirection(true)
		unit.mover:setTempSpeedFactor(kRepelSpeed)
		unit.mover:addWayPoint(position.x, position.z)

		self._timelineTask = self._timelineTask or TimelineTask.New()

		self._timelineTask:clear()
		self._timelineTask:addTask(BattleConst.DelayOne)
		self._timelineTask:addFinishListener(self._onFinishRepel, self)
		self._timelineTask:start()

		self._executeTimes = self._executeTimes + 1
	end
end

function TransportSkillAttackPointHandler:_onFinishRepel()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	unit.meshModelMover:setLockDirection(false)
	unit.mover:resetTempSpeedFactor()
	BattleDispatcher:dispatchEvent(BattleEventType.OnEntityMove, self._entityId)
end

function TransportSkillAttackPointHandler:_processAsTransport(context)
	local pointTimeList = context:getPointTimeList()

	if #pointTimeList == 1 then
		self:_handleTransportPoint(context)
	elseif #pointTimeList == 2 then
		if self._executeTimes == 1 then
			self:_handleDisappearPoint(context)
		else
			self:_handleAppearPoint(context)
		end
	elseif enableErrorLog then
		local unitMgr = BattleMgr.instance:getUnitMgr()
		local unit = unitMgr:getUnit(self._entityId)

		printError("传送技能爆点数量大于2", unit.property:getName(), #pointTimeList)
	end

	self._executeTimes = self._executeTimes + 1
end

function TransportSkillAttackPointHandler:_handleDisappearPoint(context)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("Cannot find unit[%s]", self._entityId))
		end

		return
	end

	unit:setVisible(false)
end

function TransportSkillAttackPointHandler:_handleAppearPoint(context)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("Cannot find unit[%s]", self._entityId))
		end

		return
	end

	unit:setVisible(true)
	self:_handleTransportPoint(context)
end

function TransportSkillAttackPointHandler:_handleTransportPoint(context)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("Cannot find unit[%s]", self._entityId))
		end

		return
	end

	local boardMgr = BattleMgr.instance:getBoardMgr()
	local transportPosition = boardMgr:getCellPosition(self._transportUnionIndex)
	local goRightRoot = GameObjectUtils.FindChildRecursively(context:getTimelineGameObject(), 10, SkillTimelineContext.VictimRoot)

	if not goRightRoot and enableErrorLog then
		printError("缺少beattackmove")

		return
	end

	Astral.TransformUtil.SetPos(goRightRoot.transform, transportPosition:Get())
	boardMgr:exchangeUnitToUnionIndex(unit, self._transportUnionIndex)

	local adjustCameraCmd = BattleAdjustFollowCenter2Command:create(self._transportUnionIndex, self._transportUnionIndex)

	adjustCameraCmd:execute(BattleMgr.instance:getActiveBattleFlow())
end

function TransportSkillAttackPointHandler:toString()
	return string.format("[transport skill handler entityId = %s,transportUnionIndex = %s]", self._entityId, self._transportUnionIndex)
end

function TransportSkillAttackPointHandler:collectEntityIds(entityIdList)
	table.insert(entityIdList, self._entityId)
end

function TransportSkillAttackPointHandler:collectRefEntityIds(entityIdList)
	if self._refUnionIndex then
		local unitMgr = BattleMgr.instance:getUnitMgr()
		local unit = unitMgr:getUnitOnUnionIndex(self._refUnionIndex)

		if unit then
			table.insert(entityIdList, unit.property:getEntityId())
		end
	end
end

function TransportSkillAttackPointHandler:setEntityId(entityId)
	self._entityId = entityId

	local campOperator = BattleMgr.instance:getCampOperator()

	campOperator:setNextOperateEntityId(entityId)
end

function TransportSkillAttackPointHandler:setTransportUnionIndex(transportUnionIndex)
	self._transportUnionIndex = transportUnionIndex

	return self
end

function TransportSkillAttackPointHandler:setRefUnionIndex(refUnionIndex)
	self._refUnionIndex = refUnionIndex

	return self
end

function TransportSkillAttackPointHandler:setPositionChangingMethod(positionChangingMethod)
	self._positionChangingMethod = positionChangingMethod

	return self
end

return TransportSkillAttackPointHandler
