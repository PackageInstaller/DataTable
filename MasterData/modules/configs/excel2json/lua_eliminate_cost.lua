-- chunkname: @modules/configs/excel2json/lua_eliminate_cost.lua

module("modules.configs.excel2json.lua_eliminate_cost", package.seeall)

local lua_eliminate_cost = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_eliminate_cost.onLoad(json)
	lua_eliminate_cost.configList, lua_eliminate_cost.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_cost
