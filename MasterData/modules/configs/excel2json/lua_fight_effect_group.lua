-- chunkname: @modules/configs/excel2json/lua_fight_effect_group.lua

module("modules.configs.excel2json.lua_fight_effect_group", package.seeall)

local lua_fight_effect_group = {}
local fields = {
	id = 1,
	career = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_effect_group.onLoad(json)
	lua_fight_effect_group.configList, lua_fight_effect_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_effect_group
