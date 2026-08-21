-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleGlobalSkillPerformanceCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleGlobalSkillPerformanceCommand", package.seeall)

local BattleGlobalSkillPerformanceCommand = class("BattleGlobalSkillPerformanceCommand", BattleCommandBase)

function BattleGlobalSkillPerformanceCommand:onInit()
	self._entityId = false
	self._globalEffect = false
	self._unionIndex = false
	self._skillId = false
end

function BattleGlobalSkillPerformanceCommand:onClear()
	self._entityId = false
	self._globalEffect = false
	self._unionIndex = false
	self._skillId = false
end

function BattleGlobalSkillPerformanceCommand:execute(battleFlow, runningContext)
	if not self._unionIndex and self._entityId and self._entityId > 0 then
		local unitMgr = battleFlow.unitMgr
		local unit = unitMgr:getUnit(self._entityId)

		self._unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	end

	if self._unionIndex then
		local cmd = BattleAdjustFollowCenter2Command:create(self._unionIndex, self._unionIndex)

		cmd:setCommandHandler(self)
		cmd:execute(battleFlow, runningContext)
	else
		self:finish(true)
	end
end

function BattleGlobalSkillPerformanceCommand:onCommandFinish()
	local flow = BattleMgr.instance:getActiveBattleFlow()

	flow.effectPlayer:playUniqueEffect(self._globalEffect)
	self:finish(true)
end

function BattleGlobalSkillPerformanceCommand:toString()
	return string.format("[BattleGlobalSkillPerformanceCommand EntityId = %s,GlobalEffect = %s,UnionIndex = %s,SkillId = %s", self._entityId, self._globalEffect, self._unionIndex, self._skillId)
end

function BattleGlobalSkillPerformanceCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleGlobalSkillPerformanceCommand:setGlobalEffect(effect)
	self._globalEffect = effect

	return self
end

function BattleGlobalSkillPerformanceCommand:setUnionIndex(unionIndex)
	self._unionIndex = unionIndex

	return self
end

function BattleGlobalSkillPerformanceCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

return BattleGlobalSkillPerformanceCommand
