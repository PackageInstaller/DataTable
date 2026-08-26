-- chunkname: @modules/configs/excel2json/lua_critter_attribute_level.lua

module("modules.configs.excel2json.lua_critter_attribute_level", package.seeall)

local lua_critter_attribute_level = {}
local fields = {
	name = 3,
	minValue = 2,
	icon = 4,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_critter_attribute_level.onLoad(json)
	lua_critter_attribute_level.configList, lua_critter_attribute_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_attribute_level
