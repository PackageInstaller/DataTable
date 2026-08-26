-- chunkname: @modules/configs/excel2json/lua_room_order_refresh.lua

module("modules.configs.excel2json.lua_room_order_refresh", package.seeall)

local lua_room_order_refresh = {}
local fields = {
	wholesaleRevenueWeeklyLimit = 5,
	finishLimitDaily = 3,
	wholesaleGoodsWeight = 6,
	meanwhileWholesaleNum = 4,
	qualityWeight = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_room_order_refresh.onLoad(json)
	lua_room_order_refresh.configList, lua_room_order_refresh.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_order_refresh
