-- chunkname: @modules/configs/excel2json/lua_survival_role.lua

module("modules.configs.excel2json.lua_survival_role", package.seeall)

local lua_survival_role = {}
local fields = {
	initDisposition = 3,
	name = 2,
	skill = 17,
	isonline = 19,
	pic = 9,
	desc = 6,
	techSpriteId = 13,
	moveHead = 11,
	conditions = 15,
	mapHead = 12,
	initTalentIds = 18,
	chessPic = 8,
	dispositionType = 4,
	conditionsDesc = 16,
	resource = 7,
	head = 10,
	talentName = 5,
	id = 1,
	techIconType = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	talentName = 2,
	name = 1,
	conditionsDesc = 4,
	desc = 3
}

function lua_survival_role.onLoad(json)
	lua_survival_role.configList, lua_survival_role.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_role
