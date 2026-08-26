-- chunkname: @modules/configs/excel2json/lua_dice_character.lua

module("modules.configs.excel2json.lua_dice_character", package.seeall)

local lua_dice_character = {}
local fields = {
	relicIds = 7,
	name = 2,
	dicelist = 5,
	skilllist = 6,
	power = 10,
	resetTimes = 8,
	powerSkill = 11,
	desc = 3,
	hp = 9,
	id = 1,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_dice_character.onLoad(json)
	lua_dice_character.configList, lua_dice_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_character
