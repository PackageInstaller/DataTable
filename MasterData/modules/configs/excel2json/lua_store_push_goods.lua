-- chunkname: @modules/configs/excel2json/lua_store_push_goods.lua

module("modules.configs.excel2json.lua_store_push_goods", package.seeall)

local lua_store_push_goods = {}
local fields = {
	gapHours = 5,
	desc = 7,
	levelLimits = 9,
	typeId = 4,
	className = 6,
	listenerType = 2,
	listenerParam = 3,
	goodpushsId = 1,
	containedgoodsId = 8
}
local primaryKey = {
	"goodpushsId"
}
local mlStringKey = {}

function lua_store_push_goods.onLoad(json)
	lua_store_push_goods.configList, lua_store_push_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_push_goods
