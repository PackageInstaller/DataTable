-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_ReduceHP.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_ReduceHP", package.seeall)

local M = class("RogueBuffHandler_ReduceHP", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_MONSTER_TAKE_DAMAGE
end

function M:onAdd(entity, buffMO)
	return
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		print("执行被动扣血", 1)

		local effectId = tonumber(buffMO:getBuffCO().params)

		self:execAttack(effectId)

		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
		local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
	end
end

function M:execAttack(effectId)
	if RogueMgr.instance:getIsClientMode() then
		RogueMgr.instance:getModel():attackAllRole(1)
	elseif effectId ~= nil and effectId ~= 0 then
		RoguelikeAgent.instance:sendTakeEffectRequest({
			effectId
		}, 0, -1)
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
