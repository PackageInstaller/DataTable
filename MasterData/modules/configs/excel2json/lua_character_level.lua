-- chunkname: @modules/configs/excel2json/lua_character_level.lua

module("modules.configs.excel2json.lua_character_level", package.seeall)

local lua_character_level = {}
local fields = {
	cri_def = 11,
	def = 5,
	technic = 7,
	cri = 8,
	cri_dmg = 10,
	recri = 9,
	mdef = 6,
	drop_dmg = 13,
	add_dmg = 12,
	heroId = 1,
	hp = 3,
	atk = 4,
	level = 2
}
local primaryKey = {
	"heroId",
	"level"
}
local mlStringKey = {}

function lua_character_level.onLoad(json)
	lua_character_level.configList, lua_character_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_level
