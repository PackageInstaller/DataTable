-- chunkname: @modules/configs/excel2json/lua_activity191_badge.lua

module("modules.configs.excel2json.lua_activity191_badge", package.seeall)

local lua_activity191_badge = {}
local fields = {
	trigger = 6,
	name = 3,
	actParam = 7,
	spParam = 8,
	id = 2,
	icon = 5,
	activityId = 1,
	desc = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity191_badge.onLoad(json)
	lua_activity191_badge.configList, lua_activity191_badge.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_badge
