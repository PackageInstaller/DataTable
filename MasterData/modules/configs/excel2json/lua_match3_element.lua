-- chunkname: @modules/configs/excel2json/lua_match3_element.lua

module("modules.configs.excel2json.lua_match3_element", package.seeall)

local lua_match3_element = {}
local fields = {
	elementId = 1,
	name = 3,
	elementKey = 2,
	icon = 5,
	beadColor = 4
}
local primaryKey = {
	"elementId"
}
local mlStringKey = {
	name = 1
}

function lua_match3_element.onLoad(json)
	lua_match3_element.configList, lua_match3_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_element
