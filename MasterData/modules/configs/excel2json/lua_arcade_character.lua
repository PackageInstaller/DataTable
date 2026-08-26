-- chunkname: @modules/configs/excel2json/lua_arcade_character.lua

module("modules.configs.excel2json.lua_arcade_character", package.seeall)

local lua_arcade_character = {}
local fields = {
	defense = 5,
	name = 2,
	collection = 9,
	hpCap = 4,
	icon2Offset = 18,
	icon = 15,
	id = 1,
	desc = 20,
	icon2Offset2 = 19,
	skill = 7,
	attack = 3,
	bomb = 8,
	resPath = 11,
	hpPos = 13,
	skillCost = 6,
	icon2Scale = 17,
	lockTip = 21,
	category = 14,
	icon2 = 16,
	shape = 10,
	scale = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	lockTip = 3,
	name = 1,
	desc = 2
}

function lua_arcade_character.onLoad(json)
	lua_arcade_character.configList, lua_arcade_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_character
