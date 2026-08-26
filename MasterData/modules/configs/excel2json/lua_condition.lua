-- chunkname: @modules/configs/excel2json/lua_condition.lua

module("modules.configs.excel2json.lua_condition", package.seeall)

local lua_condition = {}
local fields = {
	desc = 3,
	progress = 5,
	type = 2,
	id = 1,
	attr = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_condition.onLoad(json)
	lua_condition.configList, lua_condition.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_condition
