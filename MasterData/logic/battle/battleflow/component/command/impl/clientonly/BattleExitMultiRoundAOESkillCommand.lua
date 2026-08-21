-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleExitMultiRoundAOESkillCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleExitMultiRoundAOESkillCommand", package.seeall)

local BattleExitMultiRoundAOESkillCommand = class("BattleExitMultiRoundAOESkillCommand", BattleCommandBase)

function BattleExitMultiRoundAOESkillCommand:create(entityId)
	local cmd = BattleExitMultiRoundAOESkillCommand:createInstance()

	cmd:setEntityId(entityId)

	return cmd
end

function BattleExitMultiRoundAOESkillCommand:onInit()
	self._entityId = 0
end

function BattleExitMultiRoundAOESkillCommand:onClear()
	self._entityId = 0
end

function BattleExitMultiRoundAOESkillCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleExitMultiRoundAOESkillCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.skillAreaWarning:clearSkillArea()
	self:finish(true)
end

function BattleExitMultiRoundAOESkillCommand:toString()
	return string.format("[exit multi round aoe skill command entityId = %s]", self._entityId)
end

function BattleExitMultiRoundAOESkillCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

return BattleExitMultiRoundAOESkillCommand
