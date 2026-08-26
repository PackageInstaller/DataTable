-- chunkname: @modules/configs/excel2json/lua_store_charge_goods.lua

module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

local lua_store_charge_goods = {}
local fields = {
	newEndTime = 26,
	name = 5,
	preGoodsId = 24,
	type = 3,
	extraDiamond = 21,
	newStartTime = 25,
	showLogoTag = 33,
	isShowTurnback = 35,
	onlineTime = 15,
	quickUseItemList = 29,
	item = 22,
	offTag = 13,
	firstDiamond = 20,
	bigImg = 8,
	diamond = 19,
	product = 9,
	id = 1,
	overviewJumpId = 34,
	nameEn = 6,
	taskid = 31,
	detailDesc = 28,
	belongStoreId = 2,
	desc = 7,
	originalCost = 18,
	slogan = 12,
	notShowInRecommend = 27,
	underlay = 10,
	price = 17,
	order = 4,
	showLinkageTag = 30,
	isOnline = 14,
	offlineTime = 16,
	limit = 23,
	showBg = 11,
	newShowLinkTag = 32
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 3,
	name = 1,
	nameEn = 2
}

function lua_store_charge_goods.onLoad(json)
	lua_store_charge_goods.configList, lua_store_charge_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_charge_goods
