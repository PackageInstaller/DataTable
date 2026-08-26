-- chunkname: @modules/configs/excel2json/lua_survival_shop_item.lua

module("modules.configs.excel2json.lua_survival_shop_item", package.seeall)

local lua_survival_shop_item = {}
local fields = {
	groupId = 2,
	item = 6,
	worthFix = 5,
	type = 3,
	id = 1,
	maxNum = 7,
	unlock = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_shop_item.onLoad(json)
	lua_survival_shop_item.configList, lua_survival_shop_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_shop_item
