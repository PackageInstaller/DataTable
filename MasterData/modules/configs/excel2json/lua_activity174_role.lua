-- chunkname: @modules/configs/excel2json/lua_activity174_role.lua

module("modules.configs.excel2json.lua_activity174_role", package.seeall)

local lua_activity174_role = {}
local fields = {
	heroId = 8,
	name = 9,
	quality = 6,
	skinId = 5,
	season = 2,
	gender = 10,
	career = 11,
	activeSkill2 = 16,
	type = 3,
	activeSkill1 = 15,
	dmgType = 12,
	uniqueSkill = 17,
	coinValue = 20,
	uniqueSkill_point = 18,
	powerMax = 19,
	passiveSkill = 13,
	rare = 7,
	template = 4,
	id = 1,
	replacePassiveSkill = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity174_role.onLoad(json)
	lua_activity174_role.configList, lua_activity174_role.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_role
