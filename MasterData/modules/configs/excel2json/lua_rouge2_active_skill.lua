-- chunkname: @modules/configs/excel2json/lua_rouge2_active_skill.lua

module("modules.configs.excel2json.lua_rouge2_active_skill", package.seeall)

local lua_rouge2_active_skill = {}
local fields = {
	passiveSkillId = 9,
	name = 2,
	isOff = 3,
	outUnlock = 5,
	isHide = 7,
	unlock = 14,
	career = 12,
	desc = 15,
	battleTag = 19,
	descSimply = 16,
	updateAttri = 22,
	skillId = 8,
	tag = 10,
	icon = 13,
	attributeTag = 11,
	countParam = 25,
	sortId = 4,
	skillTypeName = 20,
	newDesc = 23,
	outUnlockDesc = 6,
	countTitle = 24,
	updateSkill = 21,
	rare = 18,
	assembleCost = 27,
	keyWord = 17,
	hero_trial = 26,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	keyWord = 5,
	descSimply = 4,
	name = 1,
	outUnlockDesc = 2,
	countTitle = 7,
	newDesc = 6,
	desc = 3
}

function lua_rouge2_active_skill.onLoad(json)
	lua_rouge2_active_skill.configList, lua_rouge2_active_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_active_skill
