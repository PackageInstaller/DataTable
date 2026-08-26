-- chunkname: @modules/configs/excel2json/lua_auto_chess_mall_item.lua

module("modules.configs.excel2json.lua_auto_chess_mall_item", package.seeall)

local lua_auto_chess_mall_item = {}
local fields = {
	context = 4,
	id = 1,
	goodsId = 2,
	cost = 5,
	group = 3,
	cardpackIds = 8,
	weight = 6,
	order = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_mall_item.onLoad(json)
	lua_auto_chess_mall_item.configList, lua_auto_chess_mall_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_mall_item
