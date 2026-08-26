-- chunkname: @modules/configs/excel2json/lua_survival_shelter_monster_act.lua

module("modules.configs.excel2json.lua_survival_shelter_monster_act", package.seeall)

local lua_survival_shelter_monster_act = {}
local fields = {
	round9 = 12,
	round4 = 7,
	round7 = 10,
	round3 = 6,
	monsterSpeed = 3,
	round6 = 9,
	round10 = 13,
	round5 = 8,
	fightId = 1,
	round8 = 11,
	monsterID = 2,
	round2 = 5,
	round1 = 4
}
local primaryKey = {
	"fightId"
}
local mlStringKey = {}

function lua_survival_shelter_monster_act.onLoad(json)
	lua_survival_shelter_monster_act.configList, lua_survival_shelter_monster_act.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_shelter_monster_act
