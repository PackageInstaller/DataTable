-- chunkname: @modules/configs/excel2json/lua_rogue_event_random.lua

module("modules.configs.excel2json.lua_rogue_event_random", package.seeall)

local lua_rogue_event_random = {}
local fields = {
	event = 2,
	id = 1,
	weights = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rogue_event_random.onLoad(json)
	lua_rogue_event_random.configList, lua_rogue_event_random.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_event_random
