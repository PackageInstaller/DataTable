-- chunkname: @modules/configs/excel2json/lua_activity244_item.lua

module("modules.configs.excel2json.lua_activity244_item", package.seeall)

local lua_activity244_item = {}
local fields = {
	itemId = 1,
	itemType = 3,
	name = 2,
	quality = 5,
	desc = 7,
	icon = 6,
	maxNum = 4
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity244_item.onLoad(json)
	lua_activity244_item.configList, lua_activity244_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_item
