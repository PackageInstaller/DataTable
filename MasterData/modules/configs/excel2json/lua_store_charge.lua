-- chunkname: @modules/configs/excel2json/lua_store_charge.lua

module("modules.configs.excel2json.lua_store_charge", package.seeall)

local lua_store_charge = {}
local fields = {
	id = 1,
	packageName = 2,
	appStoreProductID = 3
}
local primaryKey = {
	"id",
	"packageName"
}
local mlStringKey = {}

function lua_store_charge.onLoad(json)
	lua_store_charge.configList, lua_store_charge.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_charge
