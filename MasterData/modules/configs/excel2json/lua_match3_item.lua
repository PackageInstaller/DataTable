-- chunkname: @modules/configs/excel2json/lua_match3_item.lua

module("modules.configs.excel2json.lua_match3_item", package.seeall)

local lua_match3_item = {}
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

function lua_match3_item.onLoad(json)
	lua_match3_item.configList, lua_match3_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_item
