-- chunkname: @modules/configs/excel2json/lua_activity157_repair_map.lua

module("modules.configs.excel2json.lua_activity157_repair_map", package.seeall)

local lua_activity157_repair_map = {}
local fields = {
	componentId = 2,
	height = 5,
	titleTip = 3,
	activityId = 1,
	tilebase = 6,
	objects = 7,
	width = 4,
	desc = 8
}
local primaryKey = {
	"activityId",
	"componentId"
}
local mlStringKey = {
	titleTip = 1,
	desc = 2
}

function lua_activity157_repair_map.onLoad(json)
	lua_activity157_repair_map.configList, lua_activity157_repair_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity157_repair_map
