-- chunkname: @modules/configs/excel2json/lua_activity244_monster_skill.lua

module("modules.configs.excel2json.lua_activity244_monster_skill", package.seeall)

local lua_activity244_monster_skill = {}
local fields = {
	effect1 = 11,
	skillText = 6,
	name = 4,
	target1 = 10,
	effect3 = 17,
	desc = 7,
	target4 = 19,
	condition3 = 15,
	effect4 = 20,
	skillId = 1,
	condition2 = 12,
	effect2 = 14,
	target2 = 13,
	skillCD = 8,
	skillType = 2,
	target3 = 16,
	condition4 = 18,
	skillTag = 3,
	condition1 = 9,
	skillTextType = 5
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	skillText = 3,
	name = 2,
	skillTag = 1,
	desc = 4
}

function lua_activity244_monster_skill.onLoad(json)
	lua_activity244_monster_skill.configList, lua_activity244_monster_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_monster_skill
