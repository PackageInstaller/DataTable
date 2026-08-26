-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_skill.lua

module("modules.configs.excel2json.lua_activity220_hedone_skill", package.seeall)

local lua_activity220_hedone_skill = {}
local fields = {
	weight = 12,
	name = 2,
	bullet = 14,
	unlockTypeCount = 9,
	cd = 5,
	triggerPoint2 = 19,
	skillType = 4,
	desc = 3,
	param1 = 18,
	conflictSkills = 8,
	probability2 = 20,
	skillId = 1,
	probability3 = 23,
	icon = 13,
	param3 = 24,
	triggerPoint3 = 22,
	param2 = 21,
	tags = 6,
	findTarget = 15,
	rare = 10,
	triggerPoint1 = 16,
	probability1 = 17,
	isUnique = 11,
	unlockGameId = 7
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	tags = 3,
	name = 1,
	desc = 2
}

function lua_activity220_hedone_skill.onLoad(json)
	lua_activity220_hedone_skill.configList, lua_activity220_hedone_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_hedone_skill
