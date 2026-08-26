-- chunkname: @modules/configs/excel2json/lua_building_bonus.lua

module("modules.configs.excel2json.lua_building_bonus", package.seeall)

local lua_building_bonus = {}
local fields = {
	bonus = 2,
	characterLimitAdd = 3,
	buildDegree = 1
}
local primaryKey = {
	"buildDegree"
}
local mlStringKey = {}

function lua_building_bonus.onLoad(json)
	lua_building_bonus.configList, lua_building_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_building_bonus
