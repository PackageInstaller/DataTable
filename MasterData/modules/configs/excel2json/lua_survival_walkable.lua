-- chunkname: @modules/configs/excel2json/lua_survival_walkable.lua

module("modules.configs.excel2json.lua_survival_walkable", package.seeall)

local lua_survival_walkable = {}
local fields = {
	id = 2,
	map = 1,
	weight = 4,
	resource = 3
}
local primaryKey = {
	"map",
	"id"
}
local mlStringKey = {}

function lua_survival_walkable.onLoad(json)
	lua_survival_walkable.configList, lua_survival_walkable.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_walkable
