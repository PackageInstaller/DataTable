-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/battleflow/command/BattleRecordForceExitCommand.lua

module("logic.extensions.battlerecord.battleflow.command.BattleRecordForceExitCommand", package.seeall)

local BattleRecordForceExitCommand = class("BattleRecordForceExitCommand", BattleCommandBase)

function BattleRecordForceExitCommand:execute(battleFlow)
	BattleMgr.instance:exit()
	self:finish(true)
end

function BattleRecordForceExitCommand:toString()
	return "[record force exit command]"
end

return BattleRecordForceExitCommand
