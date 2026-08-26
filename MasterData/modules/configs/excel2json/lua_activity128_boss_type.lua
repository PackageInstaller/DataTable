-- chunkname: @modules/configs/excel2json/lua_activity128_boss_type.lua

module("modules.configs.excel2json.lua_activity128_boss_type", package.seeall)

local lua_activity128_boss_type = {}
local fields = {
	career_weak = 3,
	recommendStrategy = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {}

function lua_activity128_boss_type.onLoad(json)
	lua_activity128_boss_type.configList, lua_activity128_boss_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_boss_type
