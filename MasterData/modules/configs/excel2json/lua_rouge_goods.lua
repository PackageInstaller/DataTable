-- chunkname: @modules/configs/excel2json/lua_rouge_goods.lua

module("modules.configs.excel2json.lua_rouge_goods", package.seeall)

local lua_rouge_goods = {}
local fields = {
	weights = 5,
	goodsGroup = 2,
	creator = 6,
	currency = 3,
	id = 1,
	price = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_goods.onLoad(json)
	lua_rouge_goods.configList, lua_rouge_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_goods
