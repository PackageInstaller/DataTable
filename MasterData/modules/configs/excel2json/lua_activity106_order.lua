-- chunkname: @modules/configs/excel2json/lua_activity106_order.lua

module("modules.configs.excel2json.lua_activity106_order", package.seeall)

local lua_activity106_order = {}
local fields = {
	gameSetting = 14,
	name = 4,
	titledesc = 5,
	openDay = 11,
	infoDesc = 17,
	desc = 6,
	listenerParam = 9,
	maxProgress = 10,
	activityId = 1,
	order = 15,
	jumpId = 16,
	location = 7,
	rare = 3,
	listenerType = 8,
	id = 2,
	bossPic = 13,
	bonus = 12
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1,
	location = 4,
	titledesc = 2,
	infoDesc = 5,
	desc = 3
}

function lua_activity106_order.onLoad(json)
	lua_activity106_order.configList, lua_activity106_order.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity106_order
