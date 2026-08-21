-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/cardentryhandler/RogueCardGetEffectHandler.lua

module("logic.extensions.roguelike.flow.component.handler.cardentryhandler.RogueCardGetEffectHandler", package.seeall)

local M = class("RogueCardGetEffectHandler", IRogueCardEntryHandler)

function M:execEntry(entryCo, judgeHandler)
	local params = string.split(entryCo.effect, "#")
	local effectId = tonumber(params[2])
	local count = tonumber(params[3])
	local roleId = RogueMgr.instance:getModel():getCurRoleMo():getRoleId()
	local msg = entryCo.desc

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	judgeHandler:execClientEffects({
		effectId
	}, count, roleId)
end

function M:getEffectParam(entryCo)
	return {
		3,
		entryCo.desc
	}
end

return M
