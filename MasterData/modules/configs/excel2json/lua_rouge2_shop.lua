-- chunkname: @modules/configs/excel2json/lua_rouge2_shop.lua

module("modules.configs.excel2json.lua_rouge2_shop", package.seeall)

local lua_rouge2_shop = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_shop.onLoad(json)
	lua_rouge2_shop.configList, lua_rouge2_shop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_shop
