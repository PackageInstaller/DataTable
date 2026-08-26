-- chunkname: @modules/configs/excel2json/lua_activity174_bag.lua

module("modules.configs.excel2json.lua_activity174_bag", package.seeall)

local lua_activity174_bag = {}
local fields = {
	season = 3,
	bagDesc = 8,
	costCoin = 6,
	type = 4,
	heroNum = 11,
	heroParam = 10,
	collectionType = 12,
	activityId = 2,
	collectionNum = 14,
	quality = 5,
	heroType = 9,
	enhanceNum = 17,
	collectionParam = 13,
	enhanceType = 15,
	id = 1,
	bagTitle = 7,
	enhanceParam = 16
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	bagDesc = 2,
	bagTitle = 1
}

function lua_activity174_bag.onLoad(json)
	lua_activity174_bag.configList, lua_activity174_bag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_bag
