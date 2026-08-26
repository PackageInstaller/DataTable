-- chunkname: @modules/configs/excel2json/lua_odyssey_equip_suit_effect.lua

module("modules.configs.excel2json.lua_odyssey_equip_suit_effect", package.seeall)

local lua_odyssey_equip_suit_effect = {}
local fields = {
	addRule = 5,
	effect = 6,
	number = 3,
	id = 1,
	addSkill = 4,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	effect = 1
}

function lua_odyssey_equip_suit_effect.onLoad(json)
	lua_odyssey_equip_suit_effect.configList, lua_odyssey_equip_suit_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_equip_suit_effect
