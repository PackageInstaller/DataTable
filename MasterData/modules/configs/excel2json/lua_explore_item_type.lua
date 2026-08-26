-- chunkname: @modules/configs/excel2json/lua_explore_item_type.lua

module("modules.configs.excel2json.lua_explore_item_type", package.seeall)

local lua_explore_item_type = {}
local fields = {
	isActiveType = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {}

function lua_explore_item_type.onLoad(json)
	lua_explore_item_type.configList, lua_explore_item_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_item_type
