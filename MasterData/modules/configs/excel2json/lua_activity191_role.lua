-- chunkname: @modules/configs/excel2json/lua_activity191_role.lua

module("modules.configs.excel2json.lua_activity191_role", package.seeall)

local lua_activity191_role = {}
local fields = {
	roleId = 10,
	name = 11,
	type = 3,
	skinId = 5,
	uniqueSkill = 18,
	gender = 12,
	career = 13,
	activeSkill2 = 17,
	star = 7,
	activeSkill1 = 16,
	dmgType = 14,
	quality = 6,
	tag = 9,
	uniqueSkill_point = 19,
	activityId = 2,
	powerMax = 20,
	facetsId = 21,
	passiveSkill = 15,
	exLevel = 8,
	template = 4,
	id = 1,
	weight = 22
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity191_role.onLoad(json)
	lua_activity191_role.configList, lua_activity191_role.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_role
