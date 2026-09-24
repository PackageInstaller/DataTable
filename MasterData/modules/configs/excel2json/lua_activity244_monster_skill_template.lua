-- chunkname: @modules/configs/excel2json/lua_activity244_monster_skill_template.lua

module("modules.configs.excel2json.lua_activity244_monster_skill_template", package.seeall)

local lua_activity244_monster_skill_template = {}
local fields = {
	id = 1,
	activeSkill = 2,
	passiveSkill = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity244_monster_skill_template.onLoad(json)
	lua_activity244_monster_skill_template.configList, lua_activity244_monster_skill_template.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_monster_skill_template
