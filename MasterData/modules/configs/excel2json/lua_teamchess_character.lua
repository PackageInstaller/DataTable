-- chunkname: @modules/configs/excel2json/lua_teamchess_character.lua

module("modules.configs.excel2json.lua_teamchess_character", package.seeall)

local lua_teamchess_character = {}
local fields = {
	activeSkillIds = 8,
	name = 2,
	id = 1,
	specialAttr1 = 10,
	specialAttr2 = 11,
	initPower = 4,
	passiveSkillIds = 9,
	specialAttr3 = 12,
	specialAttr4 = 13,
	hp = 3,
	resPic = 7,
	maxPowerLimit = 6,
	initDiamonds = 5,
	specialAttr5 = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_teamchess_character.onLoad(json)
	lua_teamchess_character.configList, lua_teamchess_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_teamchess_character
