-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleClearEntityStepSignsCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleClearEntityStepSignsCommand", package.seeall)

local BattleClearEntityStepSignsCommand = class("BattleClearEntityStepSignsCommand", BattleCommandBase)

function BattleClearEntityStepSignsCommand:create(entityId)
	local cmd = BattleClearEntityStepSignsCommand:createInstance()

	cmd:setEntityId(entityId)

	return cmd
end

function BattleClearEntityStepSignsCommand:onInit()
	self._entityId = false
end

function BattleClearEntityStepSignsCommand:onClear()
	self._entityId = false
end

function BattleClearEntityStepSignsCommand:execute(battleFlow)
	local unitOperator = battleFlow.unitOperator
	local campOperator = battleFlow.campOperator

	unitOperator:endOperateUnit()
	self:finish(true)
end

function BattleClearEntityStepSignsCommand:toString()
	return string.format("[clear entity step signs command entityId = %s]", self._entityId)
end

function BattleClearEntityStepSignsCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

return BattleClearEntityStepSignsCommand
