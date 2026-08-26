-- chunkname: @modules/configs/excel2json/lua_arcade_attribute.lua

module("modules.configs.excel2json.lua_arcade_attribute", package.seeall)

local lua_arcade_attribute = {}
local fields = {
	extend = 5,
	min = 2,
	icon = 6,
	name = 8,
	id = 1,
	initVal = 4,
	currencyIcon = 7,
	max = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_attribute.onLoad(json)
	lua_arcade_attribute.configList, lua_arcade_attribute.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_attribute
