-- chunkname: @modules/configs/excel2json/lua_actvity186_mini_game_question.lua

module("modules.configs.excel2json.lua_actvity186_mini_game_question", package.seeall)

local lua_actvity186_mini_game_question = {}
local fields = {
	rewardId1 = 7,
	rewardId2 = 10,
	question = 4,
	answer3 = 11,
	rewardId3 = 13,
	feedback3 = 12,
	hanzhangline4 = 14,
	answer2 = 8,
	feedback1 = 6,
	answer1 = 5,
	feedback2 = 9,
	id = 2,
	activityId = 1,
	sort = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	answer2 = 4,
	feedback1 = 3,
	question = 1,
	feedback2 = 5,
	hanzhangline4 = 8,
	feedback3 = 7,
	answer3 = 6,
	answer1 = 2
}

function lua_actvity186_mini_game_question.onLoad(json)
	lua_actvity186_mini_game_question.configList, lua_actvity186_mini_game_question.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity186_mini_game_question
