-- chunkname: @modules/configs/excel2json/lua_character_skill.lua

module("modules.configs.excel2json.lua_character_skill", package.seeall)

local lua_character_skill = {}
local fields = {
	triggerPoint = 8,
	name = 2,
	cost = 7,
	condition = 9,
	effect = 10,
	roundTriggerCountLimit = 11,
	skillPrompt = 4,
	desc = 3,
	totalTriggerCountLimit = 12,
	id = 1,
	icon = 5,
	active = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	skillPrompt = 3,
	desc = 2
}

function lua_character_skill.onLoad(json)
	lua_character_skill.configList, lua_character_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_skill
