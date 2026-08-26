-- chunkname: @modules/configs/excel2json/lua_activity114_event.lua

module("modules.configs.excel2json.lua_activity114_event", package.seeall)

local lua_activity114_event = {}
local fields = {
	checkOptionText = 6,
	isCheckEvent = 12,
	disposable = 11,
	successVerify = 13,
	battleId = 19,
	testId = 20,
	eventType = 4,
	successBattle = 17,
	activityId = 1,
	isTransition = 21,
	param = 5,
	storyId = 3,
	threshold = 10,
	checkAttribute = 8,
	condition = 18,
	nonOptionText = 7,
	failureStoryId = 16,
	id = 2,
	failureVerify = 15,
	successStoryId = 14,
	checkfeatures = 9
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	checkOptionText = 1,
	nonOptionText = 2
}

function lua_activity114_event.onLoad(json)
	lua_activity114_event.configList, lua_activity114_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_event
