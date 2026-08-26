-- chunkname: @modules/configs/excel2json/lua_activity178_building.lua

module("modules.configs.excel2json.lua_activity178_building", package.seeall)

local lua_activity178_building = {}
local fields = {
	cost = 12,
	effect = 7,
	desc2 = 11,
	type = 4,
	name = 5,
	uiOffset = 13,
	condition = 6,
	desc = 10,
	destory = 14,
	res = 8,
	limit = 15,
	size = 16,
	id = 2,
	icon = 9,
	activityId = 1,
	level = 3
}
local primaryKey = {
	"activityId",
	"id",
	"level"
}
local mlStringKey = {
	desc2 = 3,
	name = 1,
	desc = 2
}

function lua_activity178_building.onLoad(json)
	lua_activity178_building.configList, lua_activity178_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity178_building
