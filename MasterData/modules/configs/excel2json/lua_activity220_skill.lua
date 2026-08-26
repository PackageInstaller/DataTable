-- chunkname: @modules/configs/excel2json/lua_activity220_skill.lua

module("modules.configs.excel2json.lua_activity220_skill", package.seeall)

local lua_activity220_skill = {}
local fields = {
	skillId = 1,
	name = 2,
	target1 = 12,
	param1 = 13,
	cooldown1 = 7,
	timing1 = 10,
	condition2 = 17,
	desc = 3,
	target2 = 18,
	param2 = 19,
	cooldown3 = 21,
	timing2 = 16,
	condition3 = 22,
	icon = 6,
	percent2 = 14,
	cooldown2 = 15,
	timing3 = 20,
	rare = 5,
	target3 = 23,
	count1 = 9,
	condition1 = 11,
	percent1 = 8,
	weight = 4,
	param3 = 24
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity220_skill.onLoad(json)
	lua_activity220_skill.configList, lua_activity220_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_skill
