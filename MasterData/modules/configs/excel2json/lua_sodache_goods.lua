-- chunkname: @modules/configs/excel2json/lua_sodache_goods.lua

module("modules.configs.excel2json.lua_sodache_goods", package.seeall)

local lua_sodache_goods = {}
local fields = {
	cost = 6,
	cost1 = 8,
	relatedId = 5,
	maxLimit = 11,
	groupId = 3,
	bundleName = 9,
	quality = 10,
	unlock = 4,
	bundleDiscount = 7,
	shopId = 2,
	id = 1,
	weight = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	bundleDiscount = 1,
	bundleName = 2
}

function lua_sodache_goods.onLoad(json)
	lua_sodache_goods.configList, lua_sodache_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_goods
