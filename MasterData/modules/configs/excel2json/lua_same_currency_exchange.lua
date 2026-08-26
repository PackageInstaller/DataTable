-- chunkname: @modules/configs/excel2json/lua_same_currency_exchange.lua

module("modules.configs.excel2json.lua_same_currency_exchange", package.seeall)

local lua_same_currency_exchange = {}
local fields = {
	currencyId = 1,
	desc = 3,
	storeEntranceId = 6,
	boxPath = 5,
	image = 4,
	versionId = 2
}
local primaryKey = {
	"currencyId"
}
local mlStringKey = {
	desc = 1
}

function lua_same_currency_exchange.onLoad(json)
	lua_same_currency_exchange.configList, lua_same_currency_exchange.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_same_currency_exchange
