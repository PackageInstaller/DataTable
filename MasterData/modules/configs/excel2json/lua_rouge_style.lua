-- chunkname: @modules/configs/excel2json/lua_rouge_style.lua

module("modules.configs.excel2json.lua_rouge_style", package.seeall)

local lua_rouge_style = {}
local fields = {
	coin = 8,
	name = 4,
	talentPointGroup = 17,
	layoutId = 11,
	season = 1,
	mapSkills = 15,
	passiveSkillDescs = 12,
	desc = 5,
	unlockType = 18,
	capacity = 7,
	talentSkill = 16,
	power = 9,
	icon = 6,
	unlockParam = 19,
	halfCost = 20,
	activeSkills = 14,
	passiveSkillDescs2 = 13,
	id = 2,
	version = 3,
	powerLimit = 10
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	passiveSkillDescs2 = 4,
	name = 1,
	passiveSkillDescs = 3,
	desc = 2
}

function lua_rouge_style.onLoad(json)
	lua_rouge_style.configList, lua_rouge_style.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_style
