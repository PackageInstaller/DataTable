-- chunkname: @modules/configs/excel2json/lua_skill_ex_level.lua

module("modules.configs.excel2json.lua_skill_ex_level", package.seeall)

local lua_skill_ex_level = {}
local fields = {
	skillEx = 10,
	passiveSkill = 11,
	consume = 3,
	skillGroup1 = 8,
	deviceId = 6,
	skillGroup2 = 9,
	desc = 5,
	skillLevel = 2,
	heroId = 1,
	consume2 = 12,
	requirement = 4,
	qteGoupId = 7
}
local primaryKey = {
	"heroId",
	"skillLevel"
}
local mlStringKey = {
	desc = 1
}

function lua_skill_ex_level.onLoad(json)
	lua_skill_ex_level.configList, lua_skill_ex_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_ex_level
