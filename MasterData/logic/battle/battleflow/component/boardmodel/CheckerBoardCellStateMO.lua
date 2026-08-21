-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/boardmodel/CheckerBoardCellStateMO.lua

module("logic.battle.battleflow.component.boardmodel.CheckerBoardCellStateMO", package.seeall)

local CheckerBoardCellStateMO = class("CheckerBoardCellStateMO", AbstractGlobalReusable)

function CheckerBoardCellStateMO:getCapacity()
	return BattleConst.ObjPoolCapacityMax
end

function CheckerBoardCellStateMO:ctor(entityId, skillCode, state)
	self._entityId = false
	self._skillCode = false
	self._state = false

	self:reuse(entityId, skillCode, state)
end

function CheckerBoardCellStateMO:reset()
	self._entityId = false
	self._skillCode = false
	self._state = false
end

function CheckerBoardCellStateMO:reuse(entityId, skillCode, state)
	self._entityId = entityId
	self._skillCode = skillCode
	self._state = state
end

function CheckerBoardCellStateMO:destroy()
	self:reset()
end

function CheckerBoardCellStateMO:getEntityId()
	return self._entityId
end

function CheckerBoardCellStateMO:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function CheckerBoardCellStateMO:getSkillCode()
	return self._skillCode
end

function CheckerBoardCellStateMO:setSkillCode(skillCode)
	self._skillCode = skillCode

	return self
end

function CheckerBoardCellStateMO:isTargetState(state)
	return self._state == state
end

function CheckerBoardCellStateMO:setState(state)
	self._state = state

	return self
end

function CheckerBoardCellStateMO:equals(stateMO)
	return self._entityId == stateMO:getEntityId() and self._skillCode == stateMO:getSkillCode() and stateMO:isTargetState(self._state)
end

return CheckerBoardCellStateMO
