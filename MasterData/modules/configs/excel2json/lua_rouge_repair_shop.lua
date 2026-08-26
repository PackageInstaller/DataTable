-- chunkname: @modules/configs/excel2json/lua_rouge_repair_shop.lua

module("modules.configs.excel2json.lua_rouge_repair_shop", package.seeall)

local lua_rouge_repair_shop = {}
local fields = {
	id = 2,
	upConsume = 5,
	collectionId = 3,
	consume = 4,
	season = 1
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {}

function lua_rouge_repair_shop.onLoad(json)
	lua_rouge_repair_shop.configList, lua_rouge_repair_shop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_repair_shop
