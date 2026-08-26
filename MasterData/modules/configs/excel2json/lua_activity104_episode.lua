-- chunkname: @modules/configs/excel2json/lua_activity104_episode.lua

module("modules.configs.excel2json.lua_activity104_episode", package.seeall)

local lua_activity104_episode = {}
local fields = {
	level = 8,
	stagePicture = 7,
	stageNameEn = 6,
	episodeId = 3,
	unlockEquipIndex = 9,
	afterStoryId = 11,
	desc = 12,
	stageName = 5,
	firstPassEquipId = 10,
	stage = 4,
	activityId = 1,
	layer = 2
}
local primaryKey = {
	"activityId",
	"layer"
}
local mlStringKey = {
	desc = 2,
	stageName = 1
}

function lua_activity104_episode.onLoad(json)
	lua_activity104_episode.configList, lua_activity104_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity104_episode
