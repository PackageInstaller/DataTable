-- chunkname: @modules/configs/excel2json/lua_arcade_grade.lua

module("modules.configs.excel2json.lua_arcade_grade", package.seeall)

local lua_arcade_grade = {}
local fields = {
	gainRateAdd = 3,
	icon = 2,
	needScore = 1
}
local primaryKey = {
	"needScore"
}
local mlStringKey = {}

function lua_arcade_grade.onLoad(json)
	lua_arcade_grade.configList, lua_arcade_grade.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_grade
