-- chunkname: @modules/configs/excel2json/lua_activity244_skill_range.lua

module("modules.configs.excel2json.lua_activity244_skill_range", package.seeall)

local lua_activity244_skill_range = {}
local fields = {
	id = 1,
	range = 2,
	rangeType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity244_skill_range.onLoad(json)
	lua_activity244_skill_range.configList, lua_activity244_skill_range.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_skill_range
