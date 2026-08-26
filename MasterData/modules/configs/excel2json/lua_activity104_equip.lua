-- chunkname: @modules/configs/excel2json/lua_activity104_equip.lua

module("modules.configs.excel2json.lua_activity104_equip", package.seeall)

local lua_activity104_equip = {}
local fields = {
	iconOffset = 7,
	name = 2,
	attrId = 9,
	signIcon = 6,
	isOptional = 4,
	career = 11,
	rare = 3,
	careerIcon = 12,
	equipId = 1,
	signOffset = 8,
	group = 13,
	skillId = 10,
	tag = 15,
	icon = 5,
	activityId = 14
}
local primaryKey = {
	"equipId"
}
local mlStringKey = {
	name = 1
}

function lua_activity104_equip.onLoad(json)
	lua_activity104_equip.configList, lua_activity104_equip.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity104_equip
