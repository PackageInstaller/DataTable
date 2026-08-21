-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/prop/RogueBuffHandler_FightBigSuccessAddition.lua

module("logic.extensions.roguelike.buff.prop.RogueBuffHandler_FightBigSuccessAddition", package.seeall)

local M = class("RogueBuffHandler_FightBigSuccessAddition", RogueBaseBuffHandler)

function M:ctor()
	return
end

function M:onAdd(entity, buffMO)
	return
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		local msg = lang("tip_fight_success_up")

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		entity:setTrigger(true)
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
