-- chunkname: @modules/configs/excel2json/lua_rouge2_shop_date.lua

module("modules.configs.excel2json.lua_rouge2_shop_date", package.seeall)

local lua_rouge2_shop_date = {}
local fields = {
	currencyMax = 5,
	shopTitle = 4,
	endTime = 3,
	id = 1,
	startTime = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	shopTitle = 1
}

function lua_rouge2_shop_date.onLoad(json)
	lua_rouge2_shop_date.configList, lua_rouge2_shop_date.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_shop_date
