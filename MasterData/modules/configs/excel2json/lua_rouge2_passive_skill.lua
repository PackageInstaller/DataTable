-- chunkname: @modules/configs/excel2json/lua_rouge2_passive_skill.lua

module("modules.configs.excel2json.lua_rouge2_passive_skill", package.seeall)

local lua_rouge2_passive_skill = {}
local fields = {
	isSpecial = 11,
	name = 3,
	effectDesc = 5,
	upDesc = 6,
	icon = 9,
	attribute = 10,
	id = 1,
	desc = 4,
	levelUpDesc = 7,
	imLevelUpDesc = 8,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	effectDesc = 3,
	name = 1,
	levelUpDesc = 5,
	upDesc = 4,
	imLevelUpDesc = 6,
	desc = 2
}

function lua_rouge2_passive_skill.onLoad(json)
	lua_rouge2_passive_skill.configList, lua_rouge2_passive_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_passive_skill
