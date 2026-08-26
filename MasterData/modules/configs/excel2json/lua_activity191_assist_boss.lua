-- chunkname: @modules/configs/excel2json/lua_activity191_assist_boss.lua

module("modules.configs.excel2json.lua_activity191_assist_boss", package.seeall)

local lua_activity191_assist_boss = {}
local fields = {
	bossId = 1,
	passiveSkills = 14,
	powerMax = 10,
	skinId = 7,
	uniqueSkill = 13,
	gender = 8,
	career = 6,
	activeSkill2 = 12,
	condition = 5,
	activeSkill1 = 11,
	dmgType = 9,
	name = 2,
	relation = 4,
	icon = 18,
	activityId = 3,
	headIcon = 17,
	offset = 16,
	uiForm = 15,
	bossDesc = 19
}
local primaryKey = {
	"bossId"
}
local mlStringKey = {
	bossDesc = 2,
	name = 1
}

function lua_activity191_assist_boss.onLoad(json)
	lua_activity191_assist_boss.configList, lua_activity191_assist_boss.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_assist_boss
