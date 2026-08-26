-- chunkname: @modules/configs/excel2json/lua_item_category_show.lua

module("modules.configs.excel2json.lua_item_category_show", package.seeall)

local lua_item_category_show = {}
local fields = {
	id = 1,
	highQuality = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_item_category_show.onLoad(json)
	lua_item_category_show.configList, lua_item_category_show.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_item_category_show
