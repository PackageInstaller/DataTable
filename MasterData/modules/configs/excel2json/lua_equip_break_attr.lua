-- chunkname: @modules/configs/excel2json/lua_equip_break_attr.lua

module("modules.configs.excel2json.lua_equip_break_attr", package.seeall)

local lua_equip_break_attr = {}
local fields = {
	dropDmg = 12,
	def = 5,
	cri = 7,
	defenseIgnore = 15,
	id = 1,
	normalSkillRate = 17,
	mdef = 6,
	addDmg = 11,
	criDmg = 9,
	attack = 3,
	criDef = 10,
	clutch = 18,
	absorb = 16,
	revive = 14,
	recri = 8,
	hp = 4,
	breakLevel = 2,
	heal = 13
}
local primaryKey = {
	"id",
	"breakLevel"
}
local mlStringKey = {}

function lua_equip_break_attr.onLoad(json)
	lua_equip_break_attr.configList, lua_equip_break_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip_break_attr
