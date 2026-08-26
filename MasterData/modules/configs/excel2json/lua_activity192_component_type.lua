-- chunkname: @modules/configs/excel2json/lua_activity192_component_type.lua

module("modules.configs.excel2json.lua_activity192_component_type", package.seeall)

local lua_activity192_component_type = {}
local fields = {
	id = 1,
	name = 2,
	path = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity192_component_type.onLoad(json)
	lua_activity192_component_type.configList, lua_activity192_component_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity192_component_type
