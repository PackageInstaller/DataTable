-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/undo/BattleUndoMO.lua

module("logic.battle.battleflow.component.undo.BattleUndoMO", package.seeall)

local BattleUndoMO = class("BattleUndoMO", AbstractGlobalReusable)

function BattleUndoMO:createFromStepHistoryNO(stepHistoryNO)
	local undoMO = BattleUndoMO:createInstance()

	undoMO:setRound(stepHistoryNO.round)
	undoMO:setEntityId(stepHistoryNO.entityId)
	undoMO:setEntityCode(stepHistoryNO.entityCode)
	undoMO:setEntityType(stepHistoryNO.entityType)
	undoMO:setMoved(#stepHistoryNO.movement > 0)
	undoMO:setReleasingSkillCode(stepHistoryNO.releasingSkill)

	return undoMO
end

function BattleUndoMO:createRoundMO(round)
	local undoMO = BattleUndoMO:createInstance()

	undoMO:setRound(round)

	return undoMO
end

function BattleUndoMO:ctor()
	self._step = 0
	self._round = 0
	self._entityId = 0
	self._entityCode = 0
	self._entityType = 0
	self._isMoved = false
	self._releasingSkillCode = false
end

function BattleUndoMO:reset()
	self._step = 0
	self._round = 0
	self._entityId = 0
	self._entityCode = 0
	self._entityType = 0
	self._isMoved = false
	self._releasingSkillCode = false
end

function BattleUndoMO:getCapacity()
	return BattleConst.ObjPoolCapacityMax
end

function BattleUndoMO:destroy()
	self:reset()
end

function BattleUndoMO:setStep(step)
	self._step = step
end

function BattleUndoMO:getStep()
	return self._step
end

function BattleUndoMO:setRound(round)
	self._round = round
end

function BattleUndoMO:getRound()
	return self._round
end

function BattleUndoMO:setEntityId(entityId)
	self._entityId = entityId
end

function BattleUndoMO:getEntityId()
	return self._entityId
end

function BattleUndoMO:setEntityCode(entityCode)
	self._entityCode = entityCode
end

function BattleUndoMO:getEntityCode()
	return self._entityCode
end

function BattleUndoMO:setEntityType(entityType)
	self._entityType = entityType
end

function BattleUndoMO:getEntityType()
	return self._entityType
end

function BattleUndoMO:setMoved(isMoved)
	self._isMoved = isMoved
end

function BattleUndoMO:isRoundNode()
	return self._entityId <= 0
end

function BattleUndoMO:isMoved()
	return self._isMoved
end

function BattleUndoMO:isUsedSkill()
	return self._releasingSkillCode > 0
end

function BattleUndoMO:setReleasingSkillCode(skillCode)
	self._releasingSkillCode = skillCode
end

function BattleUndoMO:getReleasingSkillCode()
	return self._releasingSkillCode
end

function BattleUndoMO:equalsRoundAndStep(round, step)
	return self._round == round and self._step == step
end

return BattleUndoMO
