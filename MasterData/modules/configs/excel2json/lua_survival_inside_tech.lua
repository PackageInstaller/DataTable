-- chunkname: @modules/configs/excel2json/lua_survival_inside_tech.lua

module("modules.configs.excel2json.lua_survival_inside_tech", package.seeall)

local lua_survival_inside_tech = {}
local fields = {
	cost = 9,
	name = 2,
	preNodes = 6,
	sign = 10,
	desc = 5,
	needLv = 7,
	point = 3,
	id = 1,
	icon = 4,
	addTalentIds = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_survival_inside_tech.onLoad(json)
	lua_survival_inside_tech.configList, lua_survival_inside_tech.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_inside_tech
