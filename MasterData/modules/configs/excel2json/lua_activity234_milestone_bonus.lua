-- chunkname: @modules/configs/excel2json/lua_activity234_milestone_bonus.lua

module("modules.configs.excel2json.lua_activity234_milestone_bonus", package.seeall)

local lua_activity234_milestone_bonus = {}
local fields = {
	coinNum = 3,
	bonus = 4,
	activityId = 1,
	rewardId = 2
}
local primaryKey = {
	"activityId",
	"rewardId"
}
local mlStringKey = {}

function lua_activity234_milestone_bonus.onLoad(json)
	lua_activity234_milestone_bonus.configList, lua_activity234_milestone_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity234_milestone_bonus
