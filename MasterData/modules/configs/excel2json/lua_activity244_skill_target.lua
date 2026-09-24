-- chunkname: @modules/configs/excel2json/lua_activity244_skill_target.lua

module("modules.configs.excel2json.lua_activity244_skill_target", package.seeall)

local lua_activity244_skill_target = {}
local fields = {
	targetId = 1,
	targetType = 2
}
local primaryKey = {
	"targetId"
}
local mlStringKey = {}

function lua_activity244_skill_target.onLoad(json)
	lua_activity244_skill_target.configList, lua_activity244_skill_target.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_skill_target
