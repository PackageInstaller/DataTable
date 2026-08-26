-- chunkname: @modules/configs/excel2json/lua_critter_attribute.lua

module("modules.configs.excel2json.lua_critter_attribute", package.seeall)

local lua_critter_attribute = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_critter_attribute.onLoad(json)
	lua_critter_attribute.configList, lua_critter_attribute.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_attribute
