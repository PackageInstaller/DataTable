-- chunkname: @modules/configs/excel2json/lua_fight_entity_summoned_replace_by_skin.lua

module("modules.configs.excel2json.lua_fight_entity_summoned_replace_by_skin", package.seeall)

local lua_fight_entity_summoned_replace_by_skin = {}
local fields = {
	keyForEntiySummon = 1,
	keyForEntiySummonSkinId = 3,
	skinId = 2
}
local primaryKey = {
	"keyForEntiySummon",
	"skinId"
}
local mlStringKey = {}

function lua_fight_entity_summoned_replace_by_skin.onLoad(json)
	lua_fight_entity_summoned_replace_by_skin.configList, lua_fight_entity_summoned_replace_by_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_entity_summoned_replace_by_skin
