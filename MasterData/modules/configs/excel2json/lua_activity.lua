-- chunkname: @modules/configs/excel2json/lua_activity.lua

module("modules.configs.excel2json.lua_activity", package.seeall)

local lua_activity = {}
local fields = {
	tabBgPath = 25,
	name = 3,
	logoType = 8,
	banner = 13,
	achievementGroupPath = 23,
	tryoutEpisode = 33,
	tabButton = 26,
	openId = 17,
	patFaceParam = 35,
	achievementGroup = 19,
	hintPriority = 30,
	permanentParentAcitivityId = 22,
	showCenter = 15,
	redDotId = 18,
	extraDisplayIcon = 32,
	isRetroAcitivity = 21,
	actTip = 6,
	id = 1,
	nameEn = 4,
	logoName = 9,
	actDesc = 5,
	achievementJumpId = 28,
	desc = 14,
	confirmCondition = 11,
	tabBgmId = 27,
	extraDisplayId = 31,
	param = 16,
	defaultPriority = 29,
	storyId = 20,
	typeId = 7,
	activityBonus = 24,
	tabName = 2,
	tryoutcharacter = 34,
	joinCondition = 10,
	displayPriority = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	logoName = 5,
	name = 2,
	actDesc = 3,
	tabName = 1,
	actTip = 4,
	desc = 6
}

function lua_activity.onLoad(json)
	lua_activity.configList, lua_activity.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity
