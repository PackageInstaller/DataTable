-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleTagTriggerEndedCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleTagTriggerEndedCommand", package.seeall)

local BattleTagTriggerEndedCommand = class("BattleTagTriggerEndedCommand", BattleCommandBase)

function BattleTagTriggerEndedCommand:execute(battleFlow, runningContext)
	runningContext:clearParam(BattleCmdRunningContext.Param_TagId)
	self:finish(true)
end

function BattleTagTriggerEndedCommand:toString()
	return "battle tag trigger ended"
end

return BattleTagTriggerEndedCommand
