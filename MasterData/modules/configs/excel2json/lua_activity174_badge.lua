-- chunkname: @modules/configs/excel2json/lua_activity174_badge.lua

module("modules.configs.excel2json.lua_activity174_badge", package.seeall)

local lua_activity174_badge = {}
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

function lua_activity174_badge.onLoad(json)
	lua_activity174_badge.configList, lua_activity174_badge.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_badge
