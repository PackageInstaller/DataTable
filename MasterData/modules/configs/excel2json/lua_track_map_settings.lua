-- chunkname: @modules/configs/excel2json/lua_track_map_settings.lua

module("modules.configs.excel2json.lua_track_map_settings", package.seeall)

local lua_track_map_settings = {}
local fields = {
	laneLength = 7,
	name = 2,
	slotDistance = 4,
	isCircle = 9,
	startPoint = 8,
	laneCount = 5,
	scene = 3,
	id = 1,
	laneWidth = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_track_map_settings.onLoad(json)
	lua_track_map_settings.configList, lua_track_map_settings.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_track_map_settings
