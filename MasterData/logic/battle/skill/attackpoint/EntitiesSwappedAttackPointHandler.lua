-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/EntitiesSwappedAttackPointHandler.lua

module("logic.battle.skill.attackpoint.EntitiesSwappedAttackPointHandler", package.seeall)

local M = class("EntitiesSwappedAttackPointHandler", AbstractGlobalReusable, ISkillAttackPointHandler)

function M:parseEventNO(entities)
	if #entities ~= 2 and BattleLog.enableError then
		BattleLog.error(string.format("unhandle EntitiesSwappedAttackPointHandler entity count[%s]", #entities))
	end

	local handler = M:createInstance()

	handler:setEntityIds(entities)

	return handler
end

function M:ctor()
	self._entityIds = {}

	self:reset()
end

function M:reset()
	BattleTableUtil.clearTable(self._entityIds)

	self._isExecuted = false
	self._executeTimes = 1

	if self._timelineTask then
		self._timelineTask:clear()
	end
end

function M:destroy()
	self:reset()
end

function M:build(context)
	return
end

function M:handleAttackPoint(context, attackPointIndex)
	self:_processAsTransport(context, attackPointIndex)
end

function M:_processAsTransport(context)
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

function M:_handleDisappearPoint(context)
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	for i = 1, #self._entityIds, 2 do
		local unitA = unitMgr:getUnit(self._entityIds[i])
		local unitB = unitMgr:getUnit(self._entityIds[i + 1])

		unitA:setVisible(false)
		unitB:setVisible(false)
	end
end

function M:_handleAppearPoint(context)
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	for i = 1, #self._entityIds, 2 do
		local unitA = unitMgr:getUnit(self._entityIds[i])
		local unitB = unitMgr:getUnit(self._entityIds[i + 1])

		unitA:setVisible(true)
		unitB:setVisible(true)
	end

	self:_handleTransportPoint(context)
end

function M:_handleTransportPoint(context)
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	for i = 1, #self._entityIds, 2 do
		local unitA = unitMgr:getUnit(self._entityIds[i])
		local unitB = unitMgr:getUnit(self._entityIds[i + 1])
		local unitBUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unitB.transform:getCoordinates())

		boardMgr:exchangeUnitToUnionIndex(unitA, unitBUnionIndex)
	end

	BattleDispatcher:dispatchEvent(BattleEventType.OnEntitySwapped)
end

function M:toString()
	return string.format("[EntitiesSwappedAttackPointHandler,swappedEntityIds = %s]", BattleTableUtil.arrayToString(self._entityIds))
end

function M:collectRefEntityIds(entityIdList)
	table.insertto(entityIdList, self._entityIds)
end

function M:collectEntityIds(entityIdList)
	return
end

function M:setEntityIds(entityIds)
	table.insertto(self._entityIds, entityIds)

	return self
end

return M
