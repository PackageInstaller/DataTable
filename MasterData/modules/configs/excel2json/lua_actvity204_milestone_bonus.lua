-- chunkname: @modules/configs/excel2json/lua_actvity204_milestone_bonus.lua

module("modules.configs.excel2json.lua_actvity204_milestone_bonus", package.seeall)

local lua_actvity204_milestone_bonus = {}
local fields = {
	loopBonusIntervalNum = 5,
	isSpBonus = 7,
	coinNum = 3,
	rewardId = 2,
	bonus = 6,
	activityId = 1,
	isLoopBonus = 4
}
local primaryKey = {
	"activityId",
	"rewardId"
}
local mlStringKey = {}

function lua_actvity204_milestone_bonus.onLoad(json)
	lua_actvity204_milestone_bonus.configList, lua_actvity204_milestone_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity204_milestone_bonus
