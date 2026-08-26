-- chunkname: @modules/configs/excel2json/lua_survival_building.lua

module("modules.configs.excel2json.lua_survival_building", package.seeall)

local lua_survival_building = {}
local fields = {
	destruction = 10,
	name = 4,
	ruins = 8,
	type = 3,
	repairCost = 11,
	unlockCondition = 6,
	effect = 12,
	unName = 5,
	sort = 13,
	desc = 14,
	id = 1,
	icon = 9,
	lvUpCost = 7,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_survival_building.onLoad(json)
	lua_survival_building.configList, lua_survival_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_building
