-- chunkname: @modules/configs/excel2json/lua_stronghold_skill.lua

module("modules.configs.excel2json.lua_stronghold_skill", package.seeall)

local lua_stronghold_skill = {}
local fields = {
	triggerPoint = 3,
	effect = 4,
	roundTriggerCountLimit = 5,
	skillId = 1,
	totalTriggerCountLimit = 6,
	condition = 2
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_stronghold_skill.onLoad(json)
	lua_stronghold_skill.configList, lua_stronghold_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_stronghold_skill
