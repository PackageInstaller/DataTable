-- chunkname: @modules/configs/excel2json/lua_store_goods.lua

module("modules.configs.excel2json.lua_store_goods", package.seeall)

local lua_store_goods = {}
local fields = {
	buyLevel = 28,
	name = 9,
	needTopup = 19,
	preGoodsId = 18,
	needWeekwalkLayer = 27,
	skinLevel = 36,
	openLevel = 17,
	discountItem = 39,
	onlineTime = 21,
	specialofferItem = 40,
	showLinkageLogo = 42,
	duration = 20,
	activityId = 31,
	jumpId = 33,
	newStartTime = 29,
	offTag = 11,
	islinkageSkin = 41,
	newEndTime = 30,
	bigImg = 8,
	product = 2,
	id = 1,
	showRefreshTime = 24,
	nameEn = 10,
	refreshTime = 23,
	needEpisodeId = 26,
	bindgoodid = 32,
	logoRoots = 43,
	isAdvancedSkin = 34,
	cost2 = 5,
	originalCost = 15,
	slogan = 14,
	notShowInRecommend = 35,
	underlay = 12,
	order = 25,
	cost = 4,
	isOnline = 16,
	offlineTime = 22,
	deductionItem = 37,
	maxBuyCount = 3,
	showBg = 13,
	reduction = 6,
	spineParams = 38,
	storeId = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	offTag = 2,
	name = 1
}

function lua_store_goods.onLoad(json)
	lua_store_goods.configList, lua_store_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_goods
