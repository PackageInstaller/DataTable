-- chunkname: @modules/configs/excel2json/lua_activity_show.lua

module("modules.configs.excel2json.lua_activity_show", package.seeall)

local lua_activity_show = {}
local fields = {
	jumpId = 6,
	taskDesc = 4,
	centerId = 7,
	actDesc = 3,
	id = 2,
	activityId = 1,
	showBonus = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	taskDesc = 2,
	actDesc = 1
}

function lua_activity_show.onLoad(json)
	lua_activity_show.configList, lua_activity_show.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_show
