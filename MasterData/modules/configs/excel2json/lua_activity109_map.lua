-- chunkname: @modules/configs/excel2json/lua_activity109_map.lua

module("modules.configs.excel2json.lua_activity109_map", package.seeall)

local lua_activity109_map = {}
local fields = {
	bgPath = 6,
	height = 4,
	activityId = 1,
	objects = 9,
	offset = 7,
	audioAmbient = 5,
	tilebase = 8,
	id = 2,
	width = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity109_map.onLoad(json)
	lua_activity109_map.configList, lua_activity109_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity109_map
