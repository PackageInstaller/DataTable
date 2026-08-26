-- chunkname: @modules/configs/excel2json/lua_fight_monster_display_condition.lua

module("modules.configs.excel2json.lua_fight_monster_display_condition", package.seeall)

local lua_fight_monster_display_condition = {}
local fields = {
	id = 1,
	buffId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_monster_display_condition.onLoad(json)
	lua_fight_monster_display_condition.configList, lua_fight_monster_display_condition.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_monster_display_condition
