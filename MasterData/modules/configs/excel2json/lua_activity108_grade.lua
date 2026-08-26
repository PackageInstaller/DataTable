-- chunkname: @modules/configs/excel2json/lua_activity108_grade.lua

module("modules.configs.excel2json.lua_activity108_grade", package.seeall)

local lua_activity108_grade = {}
local fields = {
	score = 3,
	mapId = 2,
	bonus = 5,
	id = 1,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity108_grade.onLoad(json)
	lua_activity108_grade.configList, lua_activity108_grade.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity108_grade
