-- chunkname: @modules/configs/excel2json/lua_sodache_event.lua

module("modules.configs.excel2json.lua_sodache_event", package.seeall)

local lua_sodache_event = {}
local fields = {
	retain = 10,
	name = 5,
	typeParam = 3,
	type = 2,
	group = 4,
	path = 7,
	desc = 6,
	probability = 11,
	dropPreview = 9,
	id = 1,
	battleList = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_sodache_event.onLoad(json)
	lua_sodache_event.configList, lua_sodache_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_event
