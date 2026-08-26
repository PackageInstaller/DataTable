-- chunkname: @modules/configs/excel2json/lua_monster_job.lua

module("modules.configs.excel2json.lua_monster_job", package.seeall)

local lua_monster_job = {}
local fields = {
	technic_equip_base = 16,
	criDef_init_super = 20,
	defense_equip_base = 14,
	dropDmg_equip_super = 28,
	cri_init_super = 17,
	criDmg_init_super = 19,
	criDmg_equip_super = 25,
	cri_equip_super = 23,
	cri_reson_super = 29,
	id = 1,
	recri_init_super = 18,
	addDmg_init_super = 21,
	mdefense_equip_base = 15,
	addDmg_reson_super = 33,
	life_base_coef = 2,
	mdefense_base_coef = 5,
	life_equip_base = 12,
	criDef_equip_super = 26,
	technic_base = 11,
	defense_base_coef = 4,
	attack_base = 8,
	addDmg_equip_super = 27,
	attack_base_coef = 3,
	recri_equip_super = 24,
	defense_base = 9,
	dropDmg_init_super = 22,
	mdefense_base = 10,
	technic_base_coef = 6,
	criDmg_reson_super = 31,
	recri_reson_super = 30,
	criDef_reson_super = 32,
	attack_equip_base = 13,
	life_base = 7,
	dropDmg_reson_super = 34
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_monster_job.onLoad(json)
	lua_monster_job.configList, lua_monster_job.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster_job
