-- chunkname: @modules/configs/excel2json/lua_survival_shelter_intrude_fight.lua

module("modules.configs.excel2json.lua_survival_shelter_intrude_fight", package.seeall)

local lua_survival_shelter_intrude_fight = {}
local fields = {
	target = 2,
	destructionLevel = 16,
	name = 10,
	cleanLevel = 14,
	gridType = 8,
	cleanpoint = 15,
	desc = 11,
	saveMonster = 13,
	model = 6,
	battleId = 3,
	smallheadicon = 9,
	score = 4,
	image = 5,
	toward = 12,
	drop = 17,
	id = 1,
	scale = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	target = 1,
	desc = 3
}

function lua_survival_shelter_intrude_fight.onLoad(json)
	lua_survival_shelter_intrude_fight.configList, lua_survival_shelter_intrude_fight.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_shelter_intrude_fight
