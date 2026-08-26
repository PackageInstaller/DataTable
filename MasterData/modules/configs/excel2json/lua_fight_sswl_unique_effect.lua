-- chunkname: @modules/configs/excel2json/lua_fight_sswl_unique_effect.lua

module("modules.configs.excel2json.lua_fight_sswl_unique_effect", package.seeall)

local lua_fight_sswl_unique_effect = {}
local fields = {
	id = 1,
	timeline = 3,
	energy = 2
}
local primaryKey = {
	"id",
	"energy"
}
local mlStringKey = {}

function lua_fight_sswl_unique_effect.onLoad(json)
	lua_fight_sswl_unique_effect.configList, lua_fight_sswl_unique_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sswl_unique_effect
