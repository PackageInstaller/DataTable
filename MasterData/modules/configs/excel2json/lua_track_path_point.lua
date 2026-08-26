-- chunkname: @modules/configs/excel2json/lua_track_path_point.lua

module("modules.configs.excel2json.lua_track_path_point", package.seeall)

local lua_track_path_point = {}
local fields = {
	posY = 5,
	posZ = 6,
	distance = 3,
	traceId = 1,
	pointId = 2,
	posX = 4
}
local primaryKey = {
	"traceId",
	"pointId"
}
local mlStringKey = {}

function lua_track_path_point.onLoad(json)
	lua_track_path_point.configList, lua_track_path_point.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_track_path_point
