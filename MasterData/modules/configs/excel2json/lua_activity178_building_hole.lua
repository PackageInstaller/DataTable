-- chunkname: @modules/configs/excel2json/lua_activity178_building_hole.lua

module("modules.configs.excel2json.lua_activity178_building_hole", package.seeall)

local lua_activity178_building_hole = {}
local fields = {
	activityId = 1,
	condition = 5,
	index = 2,
	size = 4,
	pos = 3
}
local primaryKey = {
	"activityId",
	"index"
}
local mlStringKey = {}

function lua_activity178_building_hole.onLoad(json)
	lua_activity178_building_hole.configList, lua_activity178_building_hole.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity178_building_hole
