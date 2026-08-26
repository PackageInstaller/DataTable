-- chunkname: @modules/configs/excel2json/lua_activity224_milestone_bonus.lua

module("modules.configs.excel2json.lua_activity224_milestone_bonus", package.seeall)

local lua_activity224_milestone_bonus = {}
local fields = {
	bonus = 6,
	isSpBonus = 7,
	coinNum = 3,
	loopBonusIntervalNum = 5,
	id = 2,
	titleId = 8,
	activityId = 1,
	isLoopBonus = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity224_milestone_bonus.onLoad(json)
	lua_activity224_milestone_bonus.configList, lua_activity224_milestone_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity224_milestone_bonus
