-- chunkname: @modules/configs/excel2json/lua_skill.lua

module("modules.configs.excel2json.lua_skill", package.seeall)

local lua_skill = {}
local fields = {
	icon = 4,
	name = 2,
	desc_art = 5,
	timeline = 3,
	preFxId = 14,
	notDoAction = 10,
	bloomParams = 12,
	activeTargetFrameEvent = 13,
	eff_desc = 6,
	heroId = 15,
	battleTag = 7,
	id = 1,
	skillEffect = 8,
	showInBattle = 11,
	skillRank = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc_art = 2,
	name = 1
}

function lua_skill.onLoad(json)
	lua_skill.configList, lua_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill
