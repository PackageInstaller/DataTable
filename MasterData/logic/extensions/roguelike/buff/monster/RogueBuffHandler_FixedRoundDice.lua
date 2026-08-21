-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_FixedRoundDice.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_FixedRoundDice", package.seeall)

local M = class("RogueBuffHandler_FixedRoundDice", RogueBaseBuffHandler)

function M:onAdd(entity, buffMO)
	print("执行被动 固定战斗力")

	local fighting = tonumber(buffMO:getBuffCO().params)

	RogueMgr.instance:getStateMgr():setFixedFighting(fighting)

	local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Skill_Effect")
	local msg = string.format(format, entity.monsterProp:getName(), entity.monsterProp:getPassiveEffectDesc())

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
end

function M:onTrigger(entity, buffMO)
	return
end

function M:onRemove(entity, buffMO)
	RogueMgr.instance:getStateMgr():setFixedFighting(nil)
end

return M
