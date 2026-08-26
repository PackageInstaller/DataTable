-- chunkname: @modules/configs/excel2json/lua_episode.lua

module("modules.configs.excel2json.lua_episode", package.seeall)

local lua_episode = {}
local fields = {
	bgmevent = 30,
	name = 4,
	retroFirstBonus = 41,
	dayChangeBonus = 24,
	beforeStory = 8,
	preEpisode = 16,
	pic = 14,
	battleDesc = 7,
	afterStory = 10,
	type = 3,
	saveDayNum = 38,
	navigationpic = 31,
	battleId = 23,
	icon = 15,
	freeBonus = 35,
	canUseRecord = 33,
	desc = 6,
	permanentRewardDisplayList = 50,
	displayMark = 39,
	autoSkipStory = 11,
	lockTime = 40,
	chapterId = 2,
	retroAdvancedBonus = 43,
	freeDisplayList = 36,
	advancedBonus = 27,
	preEpisodeId = 17,
	year = 32,
	permanentAdvancedBonus = 49,
	id = 1,
	retroBonus = 42,
	retroRewardList = 45,
	bonus = 26,
	dayNum = 37,
	chainEpisode = 46,
	retroRewardDisplayList = 44,
	rewardDisplayList = 28,
	rewardList = 29,
	firstBonus = 25,
	reward = 52,
	story = 9,
	elementList = 19,
	firstBattleId = 22,
	failCost = 21,
	retroReward = 53,
	name_En = 5,
	permanentBonus = 48,
	permanentReward = 54,
	cost = 20,
	time = 34,
	permanentFirstBonus = 47,
	unlockEpisode = 18,
	mapId = 13,
	decryptId = 12,
	permanentRewardList = 51
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	battleDesc = 3,
	name = 1,
	desc = 2
}

function lua_episode.onLoad(json)
	lua_episode.configList, lua_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_episode
