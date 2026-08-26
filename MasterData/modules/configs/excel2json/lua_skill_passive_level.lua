-- chunkname: @modules/configs/excel2json/lua_skill_passive_level.lua

module("modules.configs.excel2json.lua_skill_passive_level", package.seeall)

local lua_skill_passive_level = {}
local fields = {
	skillGroup = 5,
	heroId = 1,
	skillPassive = 3,
	uiFilterSkill = 4,
	skillLevel = 2
}
local primaryKey = {
	"heroId",
	"skillLevel"
}
local mlStringKey = {}

function lua_skill_passive_level.onLoad(json)
	lua_skill_passive_level.configList, lua_skill_passive_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_passive_level
