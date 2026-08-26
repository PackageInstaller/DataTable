-- chunkname: @modules/configs/excel2json/lua_trade_support_bonus.lua

module("modules.configs.excel2json.lua_trade_support_bonus", package.seeall)

local lua_trade_support_bonus = {}
local fields = {
	id = 1,
	needTask = 3,
	bonus = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_trade_support_bonus.onLoad(json)
	lua_trade_support_bonus.configList, lua_trade_support_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_trade_support_bonus
