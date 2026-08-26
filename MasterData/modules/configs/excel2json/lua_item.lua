-- chunkname: @modules/configs/excel2json/lua_item.lua

module("modules.configs.excel2json.lua_item", package.seeall)

local lua_item = {}
local fields = {
	isTimeShow = 12,
	name = 2,
	cd = 15,
	isShow = 11,
	boxOpen = 20,
	activityId = 18,
	sources = 19,
	desc = 4,
	rare = 8,
	subType = 5,
	clientDisplayType = 23,
	itemSortIdx = 21,
	icon = 7,
	price = 17,
	expireTime = 16,
	effect = 14,
	useDesc = 3,
	headIconSign = 22,
	clienttag = 6,
	id = 1,
	isStackable = 10,
	isDynamic = 13,
	highQuality = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_item.onLoad(json)
	lua_item.configList, lua_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_item
