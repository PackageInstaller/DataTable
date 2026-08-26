-- chunkname: @modules/configs/excel2json/lua_survival_decree.lua

module("modules.configs.excel2json.lua_survival_decree", package.seeall)

local lua_survival_decree = {}
local fields = {
	versions = 3,
	name = 5,
	group = 2,
	seasons = 4,
	id = 1,
	icon = 7,
	getTalents = 8,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_survival_decree.onLoad(json)
	lua_survival_decree.configList, lua_survival_decree.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_decree
