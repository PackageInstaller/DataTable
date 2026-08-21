-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_AddMonsterHp.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_AddMonsterHp", package.seeall)

local M = class("RogueBuffHandler_AddMonsterHp", RogueBaseBuffHandler)

function M:onAdd(entity, buffMO)
	entity.monsterProp:reduceHp(tonumber(buffMO:getParams()), false, true)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_HP_ANI, entity.monsterProp:getId(), 1)

	local msg = string.format("难度效果生效：%s血量增加%s", entity.monsterProp:getName(), buffMO:getParams())

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
end

function M:onRemove(entity, buffMO)
	return
end

return M
