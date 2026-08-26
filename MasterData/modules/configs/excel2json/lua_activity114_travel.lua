-- chunkname: @modules/configs/excel2json/lua_activity114_travel.lua

module("modules.configs.excel2json.lua_activity114_travel", package.seeall)

local lua_activity114_travel = {}
local fields = {
	specialEvents = 8,
	placeEn = 4,
	condition = 7,
	residentEvent = 6,
	id = 2,
	events = 5,
	activityId = 1,
	place = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	place = 1
}

function lua_activity114_travel.onLoad(json)
	lua_activity114_travel.configList, lua_activity114_travel.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_travel
