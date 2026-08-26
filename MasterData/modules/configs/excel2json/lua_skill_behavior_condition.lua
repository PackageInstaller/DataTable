-- chunkname: @modules/configs/excel2json/lua_skill_behavior_condition.lua

module("modules.configs.excel2json.lua_skill_behavior_condition", package.seeall)

local lua_skill_behavior_condition = {}
local fields = {
	id = 1,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skill_behavior_condition.onLoad(json)
	lua_skill_behavior_condition.configList, lua_skill_behavior_condition.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_behavior_condition
