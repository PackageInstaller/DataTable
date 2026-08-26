-- chunkname: @modules/configs/excel2json/lua_survival_hardness_mod.lua

module("modules.configs.excel2json.lua_survival_hardness_mod", package.seeall)

local lua_survival_hardness_mod = {}
local fields = {
	unlock = 8,
	extendScore = 6,
	name = 2,
	subTab = 4,
	hardness = 5,
	initRole = 9,
	desc = 7,
	id = 1,
	optional = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_survival_hardness_mod.onLoad(json)
	lua_survival_hardness_mod.configList, lua_survival_hardness_mod.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_hardness_mod
