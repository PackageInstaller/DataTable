-- chunkname: @modules/configs/excel2json/lua_racing_element.lua

module("modules.configs.excel2json.lua_racing_element", package.seeall)

local lua_racing_element = {}
local fields = {
	param = 5,
	prefab = 4,
	name = 2,
	type = 3,
	id = 1,
	icon = 8,
	refreshTime = 7,
	effect = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_racing_element.onLoad(json)
	lua_racing_element.configList, lua_racing_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_element
