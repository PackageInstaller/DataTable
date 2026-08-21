-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleClearAllDeadUnitCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleClearAllDeadUnitCommand", package.seeall)

local BattleClearAllDeadUnitCommand = class("BattleClearAllDeadUnitCommand", BattleCommandBase)

function BattleClearAllDeadUnitCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr

	unitMgr:internal_ClearAllDeadUnit()
	self:finish(true)
end

function BattleClearAllDeadUnitCommand:toString()
	return "[clear all dead unit command]"
end

return BattleClearAllDeadUnitCommand
