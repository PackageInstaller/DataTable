-- chunkname: @modules/configs/excel2json/lua_activity117_order.lua

module("modules.configs.excel2json.lua_activity117_order", package.seeall)

local lua_activity117_order = {}
local fields = {
	openDay = 4,
	name = 3,
	maxAcceptScore = 7,
	minDealScore = 6,
	jumpId = 12,
	maxDealScore = 8,
	listenerType = 9,
	listenerParam = 10,
	id = 2,
	maxProgress = 11,
	activityId = 1,
	order = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity117_order.onLoad(json)
	lua_activity117_order.configList, lua_activity117_order.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity117_order
