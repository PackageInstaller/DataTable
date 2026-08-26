-- chunkname: @modules/configs/excel2json/lua_activity191_effect.lua

module("modules.configs.excel2json.lua_activity191_effect", package.seeall)

local lua_activity191_effect = {}
local fields = {
	id = 1,
	group = 2,
	typeParam = 5,
	type = 4,
	tag = 3,
	itemParam = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity191_effect.onLoad(json)
	lua_activity191_effect.configList, lua_activity191_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_effect
