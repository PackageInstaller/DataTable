-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleSkillRemovedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleSkillRemovedCommand", package.seeall)

local BattleSkillRemovedCommand = class("BattleSkillRemovedCommand", BattleCommandBase)

function BattleSkillRemovedCommand:parseServerCommand(cmdParser, skillChangedEventNO)
	local cmd = BattleSkillRemovedCommand:createInstance()

	cmd:setEntityId(skillChangedEventNO.entity)
	cmd:addFromSkillNO(skillChangedEventNO.skill)
	cmdParser:addCommand(cmd)
end

function BattleSkillRemovedCommand:onInit()
	self._entityId = 0
	self._skillInfoList = {}
end

function BattleSkillRemovedCommand:onClear()
	self._entityId = 0

	BattleTableUtil.clearReusableTable(self._skillInfoList)
end

function BattleSkillRemovedCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleSkillRemovedCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	for _, skillInfo in ipairs(self._skillInfoList) do
		unit.skill:removeSkill(skillInfo.skillCode)
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_BATTLE_UNIT_SKILL_MODIFY, unit.property:getEntityCode())
	self:finish(true)
end

function BattleSkillRemovedCommand:toString()
	return string.format("[skill removed command entityId = %s,skillInfoList = %s]", self._entityId, BattleTableUtil.arrayToString(self._skillInfoList))
end

function BattleSkillRemovedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleSkillRemovedCommand:addFromSkillNO(skillNO)
	local skillInfo = BattleEntityInfo.Skill:createFromSkillNO(skillNO)

	table.insert(self._skillInfoList, skillInfo)

	return self
end

return BattleSkillRemovedCommand
