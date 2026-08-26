-- chunkname: @modules/configs/excel2json/lua_auto_chess_mall_coin.lua

module("modules.configs.excel2json.lua_auto_chess_mall_coin", package.seeall)

local lua_auto_chess_mall_coin = {}
local fields = {
	activityId = 1,
	coinNum = 3,
	round = 2,
	refreshCost = 4
}
local primaryKey = {
	"activityId",
	"round"
}
local mlStringKey = {}

function lua_auto_chess_mall_coin.onLoad(json)
	lua_auto_chess_mall_coin.configList, lua_auto_chess_mall_coin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_mall_coin
