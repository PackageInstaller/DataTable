-- chunkname: @modules/configs/excel2json/lua_tower_assist_boss.lua

module("modules.configs.excel2json.lua_tower_assist_boss", package.seeall)

local lua_tower_assist_boss = {}
local fields = {
	bossId = 1,
	teachSkills = 13,
	heartVariantId = 9,
	skinId = 5,
	name = 3,
	gender = 6,
	career = 4,
	passiveSkills = 12,
	bossPic = 17,
	bossDesc = 19,
	dmgType = 7,
	tag = 8,
	coldTime = 10,
	resMaxVal = 16,
	bossShadowPic = 18,
	resInitVal = 15,
	towerId = 2,
	activeSkills = 11,
	passiveSkillName = 14
}
local primaryKey = {
	"bossId"
}
local mlStringKey = {
	tag = 2,
	name = 1,
	passiveSkillName = 3
}

function lua_tower_assist_boss.onLoad(json)
	lua_tower_assist_boss.configList, lua_tower_assist_boss.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_assist_boss
