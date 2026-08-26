-- chunkname: @modules/configs/excel2json/lua_fight_hudie_special_effect.lua

module("modules.configs.excel2json.lua_fight_hudie_special_effect", package.seeall)

local lua_fight_hudie_special_effect = {}
local fields = {
	path = 2,
	effect = 1
}
local primaryKey = {
	"effect"
}
local mlStringKey = {}

function lua_fight_hudie_special_effect.onLoad(json)
	lua_fight_hudie_special_effect.configList, lua_fight_hudie_special_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_hudie_special_effect
