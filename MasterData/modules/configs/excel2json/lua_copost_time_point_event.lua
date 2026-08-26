-- chunkname: @modules/configs/excel2json/lua_copost_time_point_event.lua

module("modules.configs.excel2json.lua_copost_time_point_event", package.seeall)

local lua_copost_time_point_event = {}
local fields = {
	id = 1,
	fightId = 2,
	allTextId = 7,
	chaEventId = 5,
	frontEventId = 3,
	eventId = 4,
	chaId = 8,
	coordinatesId = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_time_point_event.onLoad(json)
	lua_copost_time_point_event.configList, lua_copost_time_point_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_time_point_event
