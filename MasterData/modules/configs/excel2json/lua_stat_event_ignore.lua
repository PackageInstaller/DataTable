-- chunkname: @modules/configs/excel2json/lua_stat_event_ignore.lua

module("modules.configs.excel2json.lua_stat_event_ignore", package.seeall)

local lua_stat_event_ignore = {}
local fields = {
	id = 1,
	propertyValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_stat_event_ignore.onLoad(json)
	lua_stat_event_ignore.configList, lua_stat_event_ignore.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_stat_event_ignore
