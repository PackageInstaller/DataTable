-- chunkname: @modules/configs/excel2json/lua_store_charge_conditional.lua

module("modules.configs.excel2json.lua_store_charge_conditional", package.seeall)

local lua_store_charge_conditional = {}
local fields = {
	clientType = 14,
	order2 = 9,
	redDot = 12,
	signInIdParam = 11,
	bigImg3 = 7,
	conDesc = 10,
	idsStr = 13,
	listenerType = 2,
	listenerParam = 3,
	id = 8,
	goodsId = 1,
	maxProgress = 4,
	bigImg2 = 6,
	bonus = 5
}
local primaryKey = {
	"goodsId"
}
local mlStringKey = {
	conDesc = 1
}

function lua_store_charge_conditional.onLoad(json)
	lua_store_charge_conditional.configList, lua_store_charge_conditional.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_charge_conditional
