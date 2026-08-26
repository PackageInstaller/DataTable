-- chunkname: @modules/configs/excel2json/lua_subclass_priority.lua

module("modules.configs.excel2json.lua_subclass_priority", package.seeall)

local lua_subclass_priority = {}
local fields = {
	id = 1,
	priority = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_subclass_priority.onLoad(json)
	lua_subclass_priority.configList, lua_subclass_priority.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_subclass_priority
