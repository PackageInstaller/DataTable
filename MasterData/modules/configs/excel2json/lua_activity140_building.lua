-- chunkname: @modules/configs/excel2json/lua_activity140_building.lua

module("modules.configs.excel2json.lua_activity140_building", package.seeall)

local lua_activity140_building = {}
local fields = {
	cost = 6,
	name = 7,
	skilldesc = 5,
	type = 4,
	group = 3,
	focusPos = 12,
	pos = 11,
	desc = 13,
	previewImg = 9,
	id = 1,
	icon = 10,
	activityId = 2,
	nameEn = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	skilldesc = 1,
	desc = 3
}

function lua_activity140_building.onLoad(json)
	lua_activity140_building.configList, lua_activity140_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity140_building
