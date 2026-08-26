-- chunkname: @modules/configs/excel2json/lua_track_path_segment.lua

module("modules.configs.excel2json.lua_track_path_segment", package.seeall)

local lua_track_path_segment = {}
local fields = {
	rad = 6,
	endPoint = 4,
	segmentId = 2,
	type = 5,
	traceId = 1,
	len = 7,
	startPoint = 3
}
local primaryKey = {
	"traceId",
	"segmentId"
}
local mlStringKey = {}

function lua_track_path_segment.onLoad(json)
	lua_track_path_segment.configList, lua_track_path_segment.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_track_path_segment
