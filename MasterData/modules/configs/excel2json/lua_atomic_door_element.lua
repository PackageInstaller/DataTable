-- chunkname: @modules/configs/excel2json/lua_atomic_door_element.lua

module("modules.configs.excel2json.lua_atomic_door_element", package.seeall)

local lua_atomic_door_element = {}
local fields = {
	keyElementIds = 2,
	title = 3,
	id = 1,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_atomic_door_element.onLoad(json)
	lua_atomic_door_element.configList, lua_atomic_door_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_door_element
