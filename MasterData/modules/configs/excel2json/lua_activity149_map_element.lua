-- chunkname: @modules/configs/excel2json/lua_activity149_map_element.lua

module("modules.configs.excel2json.lua_activity149_map_element", package.seeall)

local lua_activity149_map_element = {}
local fields = {
	mapId = 2,
	res = 4,
	tipOffsetPos = 6,
	effect = 7,
	id = 1,
	pos = 3,
	resScale = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity149_map_element.onLoad(json)
	lua_activity149_map_element.configList, lua_activity149_map_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity149_map_element
