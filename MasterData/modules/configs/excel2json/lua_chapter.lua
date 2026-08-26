-- chunkname: @modules/configs/excel2json/lua_chapter.lua

module("modules.configs.excel2json.lua_chapter", package.seeall)

local lua_chapter = {}
local fields = {
	desc = 7,
	chapterpic = 9,
	name = 2,
	type = 10,
	ambientMusic = 25,
	challengeCountLimit = 21,
	openLevel = 13,
	rewardPoint = 14,
	elementList = 16,
	saveHeroGroup = 22,
	dramaModeToMainChapterld = 4,
	navigationIcon = 23,
	name_En = 6,
	canPlayOpenMv = 17,
	isHeroRecommend = 26,
	canUseDouble = 18,
	openDay = 12,
	enterAfterFreeLimit = 20,
	rewindChapterBg = 24,
	chapterIndex = 5,
	canReturn = 11,
	episodeId = 28,
	eaActivityId = 3,
	year = 8,
	canMakeTeam = 19,
	id = 1,
	actId = 27,
	preChapter = 15
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	year = 3,
	desc = 2
}

function lua_chapter.onLoad(json)
	lua_chapter.configList, lua_chapter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter
