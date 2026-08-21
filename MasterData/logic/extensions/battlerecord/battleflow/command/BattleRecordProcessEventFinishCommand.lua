-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/battleflow/command/BattleRecordProcessEventFinishCommand.lua

module("logic.extensions.battlerecord.battleflow.command.BattleRecordProcessEventFinishCommand", package.seeall)

local BattleRecordProcessEventFinishCommand = class("BattleRecordProcessEventFinishCommand", BattleCommandBase)

function BattleRecordProcessEventFinishCommand:execute(battleFlow)
	local localLogic = battleFlow.localLogic

	if localLogic:checkBattleEnded() then
		self:finish(true)

		return
	end

	local netEventMgr = battleFlow.netEventMgr

	netEventMgr:processNextEvent()
	self:finish(true)
end

function BattleRecordProcessEventFinishCommand:toString()
	return "[record process event finish command]"
end

return BattleRecordProcessEventFinishCommand
