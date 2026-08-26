-- chunkname: @modules/configs/excel2json/lua_fishing_exchange.lua

module("modules.configs.excel2json.lua_fishing_exchange", package.seeall)

local lua_fishing_exchange = {}
local fields = {
	num = 3,
	needCurrencyId = 2,
	times = 1
}
local primaryKey = {
	"times"
}
local mlStringKey = {}

function lua_fishing_exchange.onLoad(json)
	lua_fishing_exchange.configList, lua_fishing_exchange.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fishing_exchange
