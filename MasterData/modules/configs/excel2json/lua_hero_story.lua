-- chunkname: @modules/configs/excel2json/lua_hero_story.lua

module("modules.configs.excel2json.lua_hero_story", package.seeall)

local lua_hero_story = {}
local fields = {
	episodeId = 12,
	name = 9,
	nameEn = 10,
	chapterId = 2,
	order = 8,
	activity_pic = 17,
	cgUnlockEpisodeId = 18,
	unlock = 3,
	cgPos = 20,
	heroName = 5,
	cgUnlockStoryId = 19,
	mainviewName = 22,
	permanentUnlock = 23,
	signature = 24,
	activityId = 16,
	queryVersion = 11,
	preStoryId = 25,
	challengeBonus = 15,
	cgBg = 7,
	cgScale = 21,
	photo = 6,
	id = 1,
	main_pic = 13,
	monster_pic = 14,
	bonus = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	heroName = 1,
	mainviewName = 3
}

function lua_hero_story.onLoad(json)
	lua_hero_story.configList, lua_hero_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story
