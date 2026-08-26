-- chunkname: @modules/configs/excel2json/lua_activity174_match.lua

module("modules.configs.excel2json.lua_activity174_match", package.seeall)

local lua_activity174_match = {}
local fields = {
	score = 4,
	rank = 2,
	count = 3,
	matchRule = 5,
	robotRate = 9,
	matchRuleLimit = 6,
	lostValue = 8,
	activityId = 1,
	winValue = 7
}
local primaryKey = {
	"activityId",
	"rank",
	"count"
}
local mlStringKey = {}

function lua_activity174_match.onLoad(json)
	lua_activity174_match.configList, lua_activity174_match.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_match
