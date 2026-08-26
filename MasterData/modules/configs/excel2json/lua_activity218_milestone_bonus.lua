-- chunkname: @modules/configs/excel2json/lua_activity218_milestone_bonus.lua

module("modules.configs.excel2json.lua_activity218_milestone_bonus", package.seeall)

local lua_activity218_milestone_bonus = {}
local fields = {
	isSpBonus = 5,
	coinNum = 3,
	rewardId = 2,
	source = 6,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"rewardId"
}
local mlStringKey = {}

function lua_activity218_milestone_bonus.onLoad(json)
	lua_activity218_milestone_bonus.configList, lua_activity218_milestone_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity218_milestone_bonus
