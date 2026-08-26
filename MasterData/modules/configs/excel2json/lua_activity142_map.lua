-- chunkname: @modules/configs/excel2json/lua_activity142_map.lua

module("modules.configs.excel2json.lua_activity142_map", package.seeall)

local lua_activity142_map = {}
local fields = {
	bgPath = 7,
	height = 4,
	activityId = 1,
	objects = 11,
	offset = 9,
	defaultCharacterId = 5,
	audioAmbient = 6,
	tilebase = 10,
	groundItems = 8,
	id = 2,
	width = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity142_map.onLoad(json)
	lua_activity142_map.configList, lua_activity142_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity142_map
