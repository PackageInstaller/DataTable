-- chunkname: @modules/configs/excel2json/lua_survival_hardness.lua

module("modules.configs.excel2json.lua_survival_hardness", package.seeall)

local lua_survival_hardness = {}
local fields = {
	versions = 2,
	isShow = 8,
	icon = 9,
	type = 4,
	titile = 10,
	scoreRate = 12,
	extendScoreFix = 13,
	desc = 11,
	lockDesc = 14,
	subtype = 5,
	seasons = 3,
	id = 1,
	optional = 7,
	level = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_survival_hardness.onLoad(json)
	lua_survival_hardness.configList, lua_survival_hardness.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_hardness
