-- chunkname: @modules/configs/excel2json/lua_soldier_skill.lua

module("modules.configs.excel2json.lua_soldier_skill", package.seeall)

local lua_soldier_skill = {}
local fields = {
	triggerPoint = 9,
	effect = 10,
	growUpTime = 6,
	type = 4,
	roundTriggerCountLimit = 11,
	condition = 8,
	skillDes = 3,
	totalTriggerCountLimit = 12,
	growUploop = 7,
	skillId = 1,
	skillName = 2,
	active = 5
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	skillDes = 2,
	skillName = 1
}

function lua_soldier_skill.onLoad(json)
	lua_soldier_skill.configList, lua_soldier_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_soldier_skill
