-- chunkname: @modules/configs/excel2json/lua_activity174_effect.lua

module("modules.configs.excel2json.lua_activity174_effect", package.seeall)

local lua_activity174_effect = {}
local fields = {
	season = 2,
	id = 1,
	typeParam = 4,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity174_effect.onLoad(json)
	lua_activity174_effect.configList, lua_activity174_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_effect
