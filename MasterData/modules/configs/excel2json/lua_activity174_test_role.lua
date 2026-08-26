-- chunkname: @modules/configs/excel2json/lua_activity174_test_role.lua

module("modules.configs.excel2json.lua_activity174_test_role", package.seeall)

local lua_activity174_test_role = {}
local fields = {
	heroId = 7,
	name = 8,
	costCoin = 19,
	type = 2,
	uniqueSkill = 16,
	gender = 9,
	career = 10,
	activeSkill2 = 15,
	quality = 5,
	activeSkill1 = 14,
	dmgType = 11,
	uniqueSkill_point = 17,
	skinId = 4,
	powerMax = 18,
	passiveSkill = 12,
	rare = 6,
	template = 3,
	id = 1,
	replacePassiveSkill = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity174_test_role.onLoad(json)
	lua_activity174_test_role.configList, lua_activity174_test_role.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_test_role
