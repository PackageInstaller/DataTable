-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_Damage2HP.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_Damage2HP", package.seeall)

local M = class("RogueBuffHandler_Damage2HP", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_MONSTER_TAKE_DAMAGE
end

function M:onAdd(entity, buffMO)
	return
end

function M:onTrigger(triggerEvent, entity, buffMO, params)
	if M.super.onTrigger(self, triggerEvent) then
		entity.monsterProp:reduceHp(-1)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_HP_ANI, entity.monsterProp:getId(), 1)

		local format = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
		local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
