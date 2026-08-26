-- chunkname: @modules/configs/excel2json/lua_fight_hsy_effect.lua

module("modules.configs.excel2json.lua_fight_hsy_effect", package.seeall)

local lua_fight_hsy_effect = {}
local fields = {
	effect = 2,
	skin = 1,
	audio = 4,
	hangPoint = 3
}
local primaryKey = {
	"skin"
}
local mlStringKey = {}

function lua_fight_hsy_effect.onLoad(json)
	lua_fight_hsy_effect.configList, lua_fight_hsy_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_hsy_effect
