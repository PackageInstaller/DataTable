-- chunkname: @modules/configs/excel2json/lua_currency.lua

module("modules.configs.excel2json.lua_currency", package.seeall)

local lua_currency = {}
local fields = {
	subType = 3,
	name = 2,
	useDesc = 8,
	maxLimit = 14,
	dayRecoverNum = 13,
	headIconSign = 16,
	rare = 4,
	desc = 9,
	recoverTime = 10,
	smallIcon = 7,
	recoverLimit = 12,
	sources = 15,
	id = 1,
	icon = 6,
	recoverNum = 11,
	highQuality = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_currency.onLoad(json)
	lua_currency.configList, lua_currency.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_currency
