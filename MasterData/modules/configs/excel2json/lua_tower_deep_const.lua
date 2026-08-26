-- chunkname: @modules/configs/excel2json/lua_tower_deep_const.lua

module("modules.configs.excel2json.lua_tower_deep_const", package.seeall)

local lua_tower_deep_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_tower_deep_const.onLoad(json)
	lua_tower_deep_const.configList, lua_tower_deep_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_deep_const
