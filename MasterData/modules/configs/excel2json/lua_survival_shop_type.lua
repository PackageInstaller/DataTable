-- chunkname: @modules/configs/excel2json/lua_survival_shop_type.lua

module("modules.configs.excel2json.lua_survival_shop_type", package.seeall)

local lua_survival_shop_type = {}
local fields = {
	id = 1,
	name = 2,
	tabIcon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_survival_shop_type.onLoad(json)
	lua_survival_shop_type.configList, lua_survival_shop_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_shop_type
