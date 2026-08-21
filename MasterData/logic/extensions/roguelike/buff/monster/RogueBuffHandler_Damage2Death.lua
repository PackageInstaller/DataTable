-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_Damage2Death.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_Damage2Death", package.seeall)

local M = class("RogueBuffHandler_Damage2Death", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_REFRESH_MONSTER_HP
end

function M:onAdd(entity, buffMO)
	self._originHp = entity.monsterProp:getOriginHp()
	self._triggerTime = 0
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		local curHp = entity.monsterProp:getHp()
		local originHp = entity.monsterProp:getOriginHp()

		if curHp < originHp and curHp ~= 0 then
			entity.monsterProp:setHp(0)

			local format = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
			local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		end
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
