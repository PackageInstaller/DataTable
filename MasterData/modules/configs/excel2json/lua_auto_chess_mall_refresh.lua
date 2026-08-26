-- chunkname: @modules/configs/excel2json/lua_auto_chess_mall_refresh.lua

module("modules.configs.excel2json.lua_auto_chess_mall_refresh", package.seeall)

local lua_auto_chess_mall_refresh = {}
local fields = {
	round = 1,
	cost = 2
}
local primaryKey = {
	"round"
}
local mlStringKey = {}

function lua_auto_chess_mall_refresh.onLoad(json)
	lua_auto_chess_mall_refresh.configList, lua_auto_chess_mall_refresh.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_mall_refresh
