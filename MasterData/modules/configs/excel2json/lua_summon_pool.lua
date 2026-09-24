-- chunkname: @modules/configs/excel2json/lua_summon_pool.lua

module("modules.configs.excel2json.lua_summon_pool", package.seeall)

local lua_summon_pool = {}
local fields = {
	awardTime = 31,
	discountTime10 = 25,
	cost1 = 21,
	type = 10,
	upWeight = 29,
	customClz = 20,
	advertising = 16,
	priorCost1 = 23,
	param2 = 8,
	subType = 6,
	free10MaxUseCount = 9,
	nameUnderlayColor = 44,
	characterDetail = 34,
	progressRewards = 35,
	progressChooseGroupId = 36,
	unchosenMailId = 37,
	jumpGroupId = 39,
	priority = 2,
	mailIds = 40,
	specialPriority = 3,
	ticketId = 12,
	banner = 17,
	priorCost10 = 24,
	infallibleItemMaxUseCount = 42,
	prefabPath = 19,
	guaranteeSRParam = 30,
	freeTagStyle = 52,
	bannerLineName = 47,
	id = 1,
	poolDetail = 33,
	totalFreeCount = 5,
	nameEn = 14,
	infallibleMailIds = 43,
	ornamentName = 46,
	totalPosibility = 48,
	spinePrefab = 50,
	progressRewardPrefab = 49,
	infallibleItemId = 41,
	progressRewardClass = 51,
	desc = 15,
	nameCn = 13,
	maskColor = 45,
	changeWeight = 32,
	doubleSsrUpRates = 28,
	param = 11,
	historyShowType = 38,
	cost10 = 22,
	dailyFreeSummon10Count = 7,
	discountCost10 = 26,
	priorityType = 4,
	bannerFlag = 18,
	initWeight = 27
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	nameCn = 1,
	desc = 2
}

function lua_summon_pool.onLoad(json)
	lua_summon_pool.configList, lua_summon_pool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_pool
