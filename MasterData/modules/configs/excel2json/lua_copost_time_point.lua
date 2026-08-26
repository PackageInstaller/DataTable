-- chunkname: @modules/configs/excel2json/lua_copost_time_point.lua

module("modules.configs.excel2json.lua_copost_time_point", package.seeall)

local lua_copost_time_point = {}
local fields = {
	id = 1,
	time = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_time_point.onLoad(json)
	lua_copost_time_point.configList, lua_copost_time_point.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_time_point
