-- chunkname: @modules/configs/excel2json/lua_fight_hsy_effect.lua

module("modules.configs.excel2json.lua_fight_hsy_effect", package.seeall)

local lua_fight_hsy_effect = {}
local fields = {
	audio = 4,
	effect = 2,
	duration = 5,
	hangPoint = 3,
	skin = 1
}
local primaryKey = {
	"skin"
}
local mlStringKey = {}

function lua_fight_hsy_effect.onLoad(json)
	lua_fight_hsy_effect.configList, lua_fight_hsy_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_hsy_effect
