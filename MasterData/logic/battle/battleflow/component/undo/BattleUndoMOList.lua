-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/undo/BattleUndoMOList.lua

module("logic.battle.battleflow.component.undo.BattleUndoMOList", package.seeall)

local BattleUndoMOList = class("BattleUndoMOList")

function BattleUndoMOList:ctor()
	self._undoMOList = {}
end

function BattleUndoMOList:clear()
	BattleTableUtil.clearReusableTable(self._undoMOList)
end

function BattleUndoMOList:initializeUndoMOList()
	local model = BattleMgr.instance:getModel()
	local battleFieldInfo = model:getBattleFieldInfo()
	local initUndoes = battleFieldInfo.initUndoes

	BattleTableUtil.insertto(self._undoMOList, initUndoes)
	BattleTableUtil.clearTable(initUndoes)
end

function BattleUndoMOList:getUndoMOList()
	return self._undoMOList
end

function BattleUndoMOList:getLastUndoMO()
	local lastIndex = #self._undoMOList

	return self._undoMOList[lastIndex]
end

function BattleUndoMOList:recordEntitySteppedEvent(entitySteppedEventNO)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entitySteppedEventNO.entity)

	if not BattleCampRelationUtil.isSameOfOperateCamp(unit) then
		return
	end

	local model = BattleMgr.instance:getModel()
	local round = model:getCurrentRound()
	local step = self:_getLastStep() + 1
	local movedEventNO = entitySteppedEventNO.moved
	local undoMO = BattleUndoMO:createInstance()

	undoMO:setStep(step)
	undoMO:setRound(round)
	undoMO:setEntityId(entitySteppedEventNO.entity)
	undoMO:setEntityCode(unit.property:getEntityCode())
	undoMO:setEntityType(unit.property:getEntityType())
	undoMO:setMoved(#movedEventNO.movement > 0)
	undoMO:setReleasingSkillCode(entitySteppedEventNO.releasingSkill)
	table.insert(self._undoMOList, undoMO)
end

function BattleUndoMOList:recordRoundStartedEvent(round)
	local undoMO = BattleUndoMO:createInstance()

	undoMO:setRound(round)
	undoMO:setStep(0)
	undoMO:setEntityId(0)
	undoMO:setEntityCode(0)
	undoMO:setEntityType(0)
	undoMO:setMoved(false)
	undoMO:setReleasingSkillCode(0)
	table.insert(self._undoMOList, undoMO)
end

function BattleUndoMOList:_getLastStep()
	local undoMO = self._undoMOList[#self._undoMOList]

	return undoMO:getStep()
end

return BattleUndoMOList
