-- chunkname: @modules/configs/excel2json/lua_rogue_goods.lua

module("modules.configs.excel2json.lua_rogue_goods", package.seeall)

local lua_rogue_goods = {}
local fields = {
	weights = 5,
	goodsGroup = 2,
	creator = 6,
	currency = 3,
	id = 1,
	event = 7,
	price = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rogue_goods.onLoad(json)
	lua_rogue_goods.configList, lua_rogue_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_goods
