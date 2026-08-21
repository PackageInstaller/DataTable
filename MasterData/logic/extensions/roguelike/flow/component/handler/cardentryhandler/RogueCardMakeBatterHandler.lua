-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/cardentryhandler/RogueCardMakeBatterHandler.lua

module("logic.extensions.roguelike.flow.component.handler.cardentryhandler.RogueCardMakeBatterHandler", package.seeall)

local M = class("RogueCardMakeBatterHandler", IRogueCardEntryHandler)

function M:onInit()
	self._effectTime = RoguelikeConst.CARD_ENTRY_EFFECT_TIME.AFTER_ACTION
end

function M:execEntry(entryCo, judgeHandler)
	local msg = entryCo.desc

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)

	return 1
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
