-- chunkname: @modules/configs/excel2json/lua_activity188_ai.lua

module("modules.configs.excel2json.lua_activity188_ai", package.seeall)

local lua_activity188_ai = {}
local fields = {
	pairRate = 5,
	pairRound = 4,
	reverseTime = 3,
	difficult = 2,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"difficult"
}
local mlStringKey = {}

function lua_activity188_ai.onLoad(json)
	lua_activity188_ai.configList, lua_activity188_ai.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity188_ai
