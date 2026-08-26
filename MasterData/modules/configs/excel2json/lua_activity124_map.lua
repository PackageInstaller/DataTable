-- chunkname: @modules/configs/excel2json/lua_activity124_map.lua

module("modules.configs.excel2json.lua_activity124_map", package.seeall)

local lua_activity124_map = {}
local fields = {
	objects = 7,
	height = 4,
	tilebase = 6,
	audioAmbient = 5,
	id = 2,
	activityId = 1,
	width = 3,
	desc = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity124_map.onLoad(json)
	lua_activity124_map.configList, lua_activity124_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity124_map
