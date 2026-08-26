-- chunkname: @modules/configs/excel2json/lua_store_charge_optional.lua

module("modules.configs.excel2json.lua_store_charge_optional", package.seeall)

local lua_store_charge_optional = {}
local fields = {
	id = 2,
	name = 6,
	items = 5,
	type = 4,
	goodsId = 1,
	rare = 3,
	desc = 7
}
local primaryKey = {
	"goodsId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_store_charge_optional.onLoad(json)
	lua_store_charge_optional.configList, lua_store_charge_optional.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_charge_optional
