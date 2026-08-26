-- chunkname: @modules/configs/excel2json/lua_survival_outside_tech.lua

module("modules.configs.excel2json.lua_survival_outside_tech", package.seeall)

local lua_survival_outside_tech = {}
local fields = {
	cost = 10,
	name = 2,
	belongRole = 3,
	sign = 11,
	desc = 6,
	preNodes = 7,
	point = 4,
	id = 1,
	icon = 5,
	addTalentIds = 8,
	extendScoreFix = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_survival_outside_tech.onLoad(json)
	lua_survival_outside_tech.configList, lua_survival_outside_tech.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_outside_tech
