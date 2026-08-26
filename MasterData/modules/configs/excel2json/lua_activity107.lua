-- chunkname: @modules/configs/excel2json/lua_activity107.lua

module("modules.configs.excel2json.lua_activity107", package.seeall)

local lua_activity107 = {}
local fields = {
	cost = 5,
	name = 8,
	tag = 6,
	offTag = 13,
	group = 12,
	order = 11,
	isOnline = 9,
	maxBuyCount = 4,
	bigImg = 7,
	originalCost = 14,
	product = 3,
	specProduct = 15,
	id = 2,
	isShowBtnDetail = 16,
	activityId = 1,
	preGoodsId = 10
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	offTag = 1
}

function lua_activity107.onLoad(json)
	lua_activity107.configList, lua_activity107.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity107
