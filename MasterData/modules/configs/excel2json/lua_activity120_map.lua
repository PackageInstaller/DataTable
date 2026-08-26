-- chunkname: @modules/configs/excel2json/lua_activity120_map.lua

module("modules.configs.excel2json.lua_activity120_map", package.seeall)

local lua_activity120_map = {}
local fields = {
	bgPath = 6,
	height = 4,
	activityId = 1,
	objects = 10,
	offset = 8,
	audioAmbient = 5,
	tilebase = 9,
	groundItems = 7,
	id = 2,
	width = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity120_map.onLoad(json)
	lua_activity120_map.configList, lua_activity120_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity120_map
