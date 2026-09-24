-- chunkname: @modules/configs/excel2json/lua_destiny_facets_ex_level.lua

module("modules.configs.excel2json.lua_destiny_facets_ex_level", package.seeall)

local lua_destiny_facets_ex_level = {}
local fields = {
	skillEx = 8,
	passiveSkill = 9,
	desc = 3,
	qteid = 5,
	deviceId = 4,
	skillGroup2 = 7,
	skillGroup1 = 6,
	skillLevel = 2,
	heroId = 1,
	exchangeSkill = 10
}
local primaryKey = {
	"heroId",
	"skillLevel"
}
local mlStringKey = {
	desc = 1
}

function lua_destiny_facets_ex_level.onLoad(json)
	lua_destiny_facets_ex_level.configList, lua_destiny_facets_ex_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_destiny_facets_ex_level
