-- chunkname: @modules/configs/excel2json/lua_store_bundle.lua

module("modules.configs.excel2json.lua_store_bundle", package.seeall)

local lua_store_bundle = {}
local fields = {
	fatherGoods = 1,
	sonGoods = 2
}
local primaryKey = {
	"fatherGoods"
}
local mlStringKey = {}

function lua_store_bundle.onLoad(json)
	lua_store_bundle.configList, lua_store_bundle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_bundle
