-- chunkname: @modules/configs/excel2json/lua_character_grow.lua

module("modules.configs.excel2json.lua_character_grow", package.seeall)

local lua_character_grow = {}
local fields = {
	technic = 7,
	def = 5,
	hp = 3,
	atk = 4,
	id = 1,
	icon = 2,
	mdef = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_character_grow.onLoad(json)
	lua_character_grow.configList, lua_character_grow.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_grow
