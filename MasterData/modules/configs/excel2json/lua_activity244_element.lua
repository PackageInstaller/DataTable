-- chunkname: @modules/configs/excel2json/lua_activity244_element.lua

module("modules.configs.excel2json.lua_activity244_element", package.seeall)

local lua_activity244_element = {}
local fields = {
	param = 3,
	name = 4,
	elementId = 1,
	type = 2,
	icon = 5
}
local primaryKey = {
	"elementId"
}
local mlStringKey = {
	name = 1
}

function lua_activity244_element.onLoad(json)
	lua_activity244_element.configList, lua_activity244_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_element
