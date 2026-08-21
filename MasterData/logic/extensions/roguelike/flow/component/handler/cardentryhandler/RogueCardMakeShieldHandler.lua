-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/cardentryhandler/RogueCardMakeShieldHandler.lua

module("logic.extensions.roguelike.flow.component.handler.cardentryhandler.RogueCardMakeShieldHandler", package.seeall)

local M = class("RogueCardMakeShieldHandler", IRogueCardEntryHandler)

function M:execEntry(entryCo, judgeHandler)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local params = string.split(entryCo.effect, "#")
	local diceWallCount = tonumber(params[2])

	if diceWallCount > 0 then
		judgeModel:addRoleDiceWall(diceWallCount)

		local msg = entryCo.desc

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	end
end

function M:getEffectParam(entryCo)
	local params = string.split(entryCo.effect, "#")

	return {
		2,
		params[1],
		tonumber(params[2])
	}
end

return M
