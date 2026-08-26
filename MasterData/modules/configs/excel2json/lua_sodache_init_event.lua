-- chunkname: @modules/configs/excel2json/lua_sodache_init_event.lua

module("modules.configs.excel2json.lua_sodache_init_event", package.seeall)

local lua_sodache_init_event = {}
local fields = {
	group = 2,
	eventGroup = 5,
	plot = 7,
	example = 4,
	id = 1,
	eventId = 6,
	difficulty = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_sodache_init_event.onLoad(json)
	lua_sodache_init_event.configList, lua_sodache_init_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_init_event
