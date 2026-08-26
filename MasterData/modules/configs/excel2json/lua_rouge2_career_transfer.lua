-- chunkname: @modules/configs/excel2json/lua_rouge2_career_transfer.lua

module("modules.configs.excel2json.lua_rouge2_career_transfer", package.seeall)

local lua_rouge2_career_transfer = {}
local fields = {
	recommendAttribute = 6,
	name = 3,
	passiveSkillBrief = 9,
	unlockParam = 13,
	healthLimit = 7,
	activeSkills = 11,
	career = 2,
	unlockType = 12,
	passiveSkills = 10,
	careerTransferDesc = 4,
	initialTreasure = 8,
	recommendTeam = 14,
	id = 1,
	icon = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	careerTransferDesc = 2,
	name = 1
}

function lua_rouge2_career_transfer.onLoad(json)
	lua_rouge2_career_transfer.configList, lua_rouge2_career_transfer.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_career_transfer
