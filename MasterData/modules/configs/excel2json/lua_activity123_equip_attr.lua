-- chunkname: @modules/configs/excel2json/lua_activity123_equip_attr.lua

module("modules.configs.excel2json.lua_activity123_equip_attr", package.seeall)

local lua_activity123_equip_attr = {}
local fields = {
	dropDmg = 11,
	def = 4,
	cri = 6,
	defenseIgnore = 14,
	atk = 3,
	normalSkillRate = 17,
	mdef = 5,
	addDmg = 10,
	criDmg = 8,
	criDef = 9,
	clutch = 16,
	attrId = 1,
	absorb = 15,
	revive = 13,
	recri = 7,
	hp = 2,
	heal = 12
}
local primaryKey = {
	"attrId"
}
local mlStringKey = {}

function lua_activity123_equip_attr.onLoad(json)
	lua_activity123_equip_attr.configList, lua_activity123_equip_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity123_equip_attr
