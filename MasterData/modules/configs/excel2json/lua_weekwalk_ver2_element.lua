-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2_element.lua

module("modules.configs.excel2json.lua_weekwalk_ver2_element", package.seeall)

local lua_weekwalk_ver2_element = {}
local fields = {
	isBoss = 7,
	smokeMaskOffset = 12,
	lightOffsetPos = 11,
	type = 2,
	disappearEffect = 17,
	skipFinish = 4,
	pos = 14,
	desc = 13,
	roundId = 5,
	param = 3,
	effect = 16,
	starOffsetPos = 10,
	tipOffsetPos = 15,
	res = 6,
	generalType = 9,
	id = 1,
	bonusGroup = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_weekwalk_ver2_element.onLoad(json)
	lua_weekwalk_ver2_element.configList, lua_weekwalk_ver2_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_ver2_element
