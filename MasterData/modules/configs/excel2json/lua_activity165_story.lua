-- chunkname: @modules/configs/excel2json/lua_activity165_story.lua

module("modules.configs.excel2json.lua_activity165_story", package.seeall)

local lua_activity165_story = {}
local fields = {
	storyId = 2,
	unlockElementIds2 = 7,
	firstUnlockElementCd2 = 8,
	preElementId1 = 3,
	firstUnlockElementCd1 = 5,
	unlockElementIds1 = 4,
	pic = 11,
	name = 10,
	firstStepId = 9,
	preElementId2 = 6,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"storyId"
}
local mlStringKey = {
	name = 1
}

function lua_activity165_story.onLoad(json)
	lua_activity165_story.configList, lua_activity165_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity165_story
