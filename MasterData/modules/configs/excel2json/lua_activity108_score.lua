-- chunkname: @modules/configs/excel2json/lua_activity108_score.lua

module("modules.configs.excel2json.lua_activity108_score", package.seeall)

local lua_activity108_score = {}
local fields = {
	grade = 2,
	id = 1,
	maxScore = 4,
	minScore = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity108_score.onLoad(json)
	lua_activity108_score.configList, lua_activity108_score.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity108_score
