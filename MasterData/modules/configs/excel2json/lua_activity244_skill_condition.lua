-- chunkname: @modules/configs/excel2json/lua_activity244_skill_condition.lua

module("modules.configs.excel2json.lua_activity244_skill_condition", package.seeall)

local lua_activity244_skill_condition = {}
local fields = {
	id = 1,
	condition = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity244_skill_condition.onLoad(json)
	lua_activity244_skill_condition.configList, lua_activity244_skill_condition.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_skill_condition
