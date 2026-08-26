-- chunkname: @modules/configs/excel2json/lua_store_recommend.lua

module("modules.configs.excel2json.lua_store_recommend", package.seeall)

local lua_store_recommend = {}
local fields = {
	systemJumpCode = 16,
	prefab = 4,
	relations = 14,
	adjustOrder = 8,
	name = 2,
	des = 6,
	className = 19,
	showOfflineTime = 13,
	onlineTime = 10,
	type = 17,
	topDay = 20,
	topType = 21,
	isOffline = 9,
	isShowTurnback = 22,
	order = 7,
	isCustomLoad = 18,
	showOnlineTime = 12,
	offlineTime = 11,
	country = 15,
	res = 3,
	id = 1,
	nameEn = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 2,
	name = 1
}

function lua_store_recommend.onLoad(json)
	lua_store_recommend.configList, lua_store_recommend.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_recommend
