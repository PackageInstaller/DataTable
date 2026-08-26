-- chunkname: @modules/configs/excel2json/lua_fight_effect.lua

module("modules.configs.excel2json.lua_fight_effect", package.seeall)

local lua_fight_effect = {}
local fields = {
	career3 = 4,
	career2 = 3,
	career1 = 2,
	career8 = 9,
	career7 = 8,
	career6 = 7,
	id = 1,
	career5 = 6,
	career4 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_effect.onLoad(json)
	lua_fight_effect.configList, lua_fight_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_effect
