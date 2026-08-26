-- chunkname: @modules/configs/excel2json/lua_activity166_score.lua

module("modules.configs.excel2json.lua_activity166_score", package.seeall)

local lua_activity166_score = {}
local fields = {
	needScore = 3,
	star = 4,
	activityId = 1,
	level = 2
}
local primaryKey = {
	"activityId",
	"level"
}
local mlStringKey = {}

function lua_activity166_score.onLoad(json)
	lua_activity166_score.configList, lua_activity166_score.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_score
