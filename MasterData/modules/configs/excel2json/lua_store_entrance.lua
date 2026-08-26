-- chunkname: @modules/configs/excel2json/lua_store_entrance.lua

module("modules.configs.excel2json.lua_store_entrance", package.seeall)

local lua_store_entrance = {}
local fields = {
	name = 4,
	prefab = 6,
	nameEn = 5,
	toprecommend = 16,
	activityId = 11,
	openTime = 12,
	belongFirstTab = 2,
	belongSecondTab = 3,
	storeId = 14,
	openHideId = 15,
	openId = 10,
	endTime = 13,
	id = 1,
	icon = 7,
	showCost = 9,
	order = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_store_entrance.onLoad(json)
	lua_store_entrance.configList, lua_store_entrance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_entrance
