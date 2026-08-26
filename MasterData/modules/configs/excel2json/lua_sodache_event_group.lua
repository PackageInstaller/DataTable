-- chunkname: @modules/configs/excel2json/lua_sodache_event_group.lua

module("modules.configs.excel2json.lua_sodache_event_group", package.seeall)

local lua_sodache_event_group = {}
local fields = {
	force = 2,
	icon = 3,
	hide = 4,
	groupId = 1
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}

function lua_sodache_event_group.onLoad(json)
	lua_sodache_event_group.configList, lua_sodache_event_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_event_group
