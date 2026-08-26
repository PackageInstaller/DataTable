-- chunkname: @modules/configs/excel2json/lua_auto_chess_skill.lua

module("modules.configs.excel2json.lua_auto_chess_skill", package.seeall)

local lua_auto_chess_skill = {}
local fields = {
	effect1 = 6,
	triggerPoint1 = 5,
	totalTriggerLimit1 = 8,
	totalTriggerLimit3 = 18,
	effect3 = 16,
	triggerPoint2 = 10,
	roundTriggerLimit1 = 7,
	condition3 = 14,
	skillaction = 19,
	skilleffID = 21,
	useeffect = 20,
	tag = 2,
	condition2 = 9,
	effect2 = 11,
	triggerPoint3 = 15,
	roundTriggerLimit2 = 12,
	countdown = 3,
	totalTriggerLimit2 = 13,
	roundTriggerLimit3 = 17,
	condition1 = 4,
	id = 1,
	downline = 22
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_skill.onLoad(json)
	lua_auto_chess_skill.configList, lua_auto_chess_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_skill
