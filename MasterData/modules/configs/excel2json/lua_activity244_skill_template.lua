-- chunkname: @modules/configs/excel2json/lua_activity244_skill_template.lua

module("modules.configs.excel2json.lua_activity244_skill_template", package.seeall)

local lua_activity244_skill_template = {}
local fields = {
	passiveSkill = 5,
	name = 2,
	id = 1,
	activeSkill = 4,
	des = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 2,
	name = 1
}

function lua_activity244_skill_template.onLoad(json)
	lua_activity244_skill_template.configList, lua_activity244_skill_template.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_skill_template
