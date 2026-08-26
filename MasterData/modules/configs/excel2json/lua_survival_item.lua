-- chunkname: @modules/configs/excel2json/lua_survival_item.lua

module("modules.configs.excel2json.lua_survival_item", package.seeall)

local lua_survival_item = {}
local fields = {
	desc2 = 6,
	name = 2,
	sellPrice = 8,
	type = 10,
	exp = 24,
	worth = 16,
	overlayLimit = 17,
	isDestroy = 18,
	versions = 3,
	subType = 11,
	enhanceCond = 21,
	copyItem = 23,
	sublimateDrop = 25,
	icon = 9,
	desc1 = 5,
	cost = 15,
	effect = 20,
	deposit = 12,
	maxLimit = 22,
	exchange = 19,
	rare = 13,
	seasons = 4,
	id = 1,
	disposable = 7,
	mass = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 3,
	name = 1,
	desc1 = 2
}

function lua_survival_item.onLoad(json)
	lua_survival_item.configList, lua_survival_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_item
