-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleTriggeringCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleTriggeringCommand", package.seeall)

local M = class("BattleTriggeringCommand", BattleCommandBase)

function M:parseServerCommand(cmdParser, triggeringNOList)
	if #triggeringNOList > 0 then
		for _, triggeringNO in ipairs(triggeringNOList) do
			self:_parseTriggeringNO(cmdParser, triggeringNO)
		end
	end
end

function M:_parseTriggeringNO(cmdParser, triggeringNO)
	if BattleLog.enableLog then
		cmdParser:addCommand(BattleTriggeringCommand:createInstance())
	end

	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, triggeringNO.events))
end

function M:execute(battleFlow)
	self:finish(true)
end

function M:toString()
	return "[battle triggering command]"
end

return M
