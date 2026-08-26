-- chunkname: @modules/configs/excel2json/lua_talent_cube_attr.lua

module("modules.configs.excel2json.lua_talent_cube_attr", package.seeall)

local lua_talent_cube_attr = {}
local fields = {
	cri = 9,
	calculateType = 4,
	cri_def = 12,
	defenseIgnore = 19,
	cri_dmg = 11,
	clutch = 17,
	mdef = 8,
	heal = 18,
	add_dmg = 13,
	def = 7,
	normalSkillRate = 20,
	atk = 6,
	icon = 3,
	level = 2,
	absorb = 16,
	revive = 15,
	recri = 10,
	drop_dmg = 14,
	hp = 5,
	id = 1
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {}

function lua_talent_cube_attr.onLoad(json)
	lua_talent_cube_attr.configList, lua_talent_cube_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_talent_cube_attr
