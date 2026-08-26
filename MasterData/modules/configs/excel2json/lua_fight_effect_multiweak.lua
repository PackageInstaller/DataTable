-- chunkname: @modules/configs/excel2json/lua_fight_effect_multiweak.lua

module("modules.configs.excel2json.lua_fight_effect_multiweak", package.seeall)

local lua_fight_effect_multiweak = {}
local fields = {
	id = 1,
	career = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_effect_multiweak.onLoad(json)
	lua_fight_effect_multiweak.configList, lua_fight_effect_multiweak.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_effect_multiweak
