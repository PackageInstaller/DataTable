-- chunkname: @modules/configs/excel2json/lua_hero_upgrade_options.lua

module("modules.configs.excel2json.lua_hero_upgrade_options", package.seeall)

local lua_hero_upgrade_options = {}
local fields = {
	unlockCondition = 2,
	addBuff = 11,
	replaceBigSkill = 8,
	replaceSkillGroup1 = 6,
	delBuff = 12,
	title = 3,
	desc = 4,
	replaceSkillGroup2 = 7,
	id = 1,
	addPassiveSkill = 10,
	showSkillId = 5,
	replacePassiveSkill = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_hero_upgrade_options.onLoad(json)
	lua_hero_upgrade_options.configList, lua_hero_upgrade_options.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_upgrade_options
