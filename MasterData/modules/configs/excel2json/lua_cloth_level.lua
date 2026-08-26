-- chunkname: @modules/configs/excel2json/lua_cloth_level.lua

module("modules.configs.excel2json.lua_cloth_level", package.seeall)

local lua_cloth_level = {}
local fields = {
	usePower1 = 15,
	passiveSkills = 13,
	usePower3 = 23,
	recover = 8,
	death = 11,
	desc = 12,
	allLimit1 = 17,
	move = 6,
	skill2 = 18,
	maxPower = 3,
	cd2 = 20,
	initial = 9,
	skill4 = 26,
	defeat = 10,
	use = 4,
	level = 2,
	compose = 7,
	allLimit2 = 21,
	allLimit3 = 25,
	usePower4 = 27,
	cd4 = 28,
	allLimit4 = 29,
	exp = 30,
	skill3 = 22,
	usePower2 = 19,
	useDeviceCard = 5,
	skill1 = 14,
	cd3 = 24,
	id = 1,
	cd1 = 16
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	desc = 1
}

function lua_cloth_level.onLoad(json)
	lua_cloth_level.configList, lua_cloth_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_cloth_level
