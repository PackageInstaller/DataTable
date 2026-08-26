-- chunkname: @modules/configs/excel2json/lua_teamchess_enemy.lua

module("modules.configs.excel2json.lua_teamchess_enemy", package.seeall)

local lua_teamchess_enemy = {}
local fields = {
	name = 2,
	passiveSkillIds = 7,
	specialAttr1 = 9,
	behaviorId = 8,
	specialAttr2 = 10,
	headImg = 4,
	specialAttr3 = 11,
	specialAttr5 = 13,
	specialAttr4 = 12,
	hp = 3,
	id = 1,
	skillIcon = 5,
	skillDesc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillDesc = 2,
	name = 1
}

function lua_teamchess_enemy.onLoad(json)
	lua_teamchess_enemy.configList, lua_teamchess_enemy.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_teamchess_enemy
