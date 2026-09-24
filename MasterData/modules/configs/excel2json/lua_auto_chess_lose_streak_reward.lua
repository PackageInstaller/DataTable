-- chunkname: @modules/configs/excel2json/lua_auto_chess_lose_streak_reward.lua

module("modules.configs.excel2json.lua_auto_chess_lose_streak_reward", package.seeall)

local lua_auto_chess_lose_streak_reward = {}
local fields = {
	levelId = 2,
	loseStreak = 3,
	activityId = 1,
	bonusCoin = 4
}
local primaryKey = {
	"activityId",
	"levelId"
}
local mlStringKey = {}

function lua_auto_chess_lose_streak_reward.onLoad(json)
	lua_auto_chess_lose_streak_reward.configList, lua_auto_chess_lose_streak_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_lose_streak_reward
