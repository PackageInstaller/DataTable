-- chunkname: @modules/configs/excel2json/lua_activity122_map.lua

module("modules.configs.excel2json.lua_activity122_map", package.seeall)

local lua_activity122_map = {}
local fields = {
	bgPath = 6,
	height = 4,
	activityId = 1,
	objects = 9,
	decorateObjects = 10,
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

function lua_activity122_map.onLoad(json)
	lua_activity122_map.configList, lua_activity122_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity122_map
