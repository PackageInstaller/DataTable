-- chunkname: @modules/configs/excel2json/lua_fight_effect_follow_entity_visible.lua

module("modules.configs.excel2json.lua_fight_effect_follow_entity_visible", package.seeall)

local lua_fight_effect_follow_entity_visible = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_effect_follow_entity_visible.onLoad(json)
	lua_fight_effect_follow_entity_visible.configList, lua_fight_effect_follow_entity_visible.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_effect_follow_entity_visible
