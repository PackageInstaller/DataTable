-- chunkname: @modules/configs/excel2json/lua_activity178_score.lua

module("modules.configs.excel2json.lua_activity178_score", package.seeall)

local lua_activity178_score = {}
local fields = {
	value = 3,
	showTxt = 4,
	activityId = 1,
	level = 2
}
local primaryKey = {
	"activityId",
	"level"
}
local mlStringKey = {}

function lua_activity178_score.onLoad(json)
	lua_activity178_score.configList, lua_activity178_score.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity178_score
