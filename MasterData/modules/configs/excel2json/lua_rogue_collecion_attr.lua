-- chunkname: @modules/configs/excel2json/lua_rogue_collecion_attr.lua

module("modules.configs.excel2json.lua_rogue_collecion_attr", package.seeall)

local lua_rogue_collecion_attr = {}
local fields = {
	revive = 13,
	def = 4,
	dropDmg = 11,
	defenseIgnore = 14,
	cri = 6,
	id = 1,
	mdef = 5,
	addDmg = 10,
	criDmg = 8,
	attack = 3,
	criDef = 9,
	clutch = 17,
	absorb = 15,
	normalSkillRate = 16,
	recri = 7,
	hp = 2,
	heal = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rogue_collecion_attr.onLoad(json)
	lua_rogue_collecion_attr.configList, lua_rogue_collecion_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_collecion_attr
