-- chunkname: @modules/configs/excel2json/lua_rouge_repair_shop_price.lua

module("modules.configs.excel2json.lua_rouge_repair_shop_price", package.seeall)

local lua_rouge_repair_shop_price = {}
local fields = {
	id = 1,
	unlockType = 2,
	desc = 4,
	unlockParam = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_repair_shop_price.onLoad(json)
	lua_rouge_repair_shop_price.configList, lua_rouge_repair_shop_price.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_repair_shop_price
