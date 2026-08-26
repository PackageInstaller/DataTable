-- chunkname: @modules/configs/excel2json/lua_skill_role_mapping.lua

module("modules.configs.excel2json.lua_skill_role_mapping", package.seeall)

local lua_skill_role_mapping = {}
local fields = {
	heroId = 2,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_skill_role_mapping.onLoad(json)
	lua_skill_role_mapping.configList, lua_skill_role_mapping.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_role_mapping
