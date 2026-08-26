-- chunkname: @modules/configs/excel2json/lua_activity123_trial.lua

module("modules.configs.excel2json.lua_activity123_trial", package.seeall)

local lua_activity123_trial = {}
local fields = {
	equipId = 8,
	firstPassEquipIds = 5,
	name = 6,
	nameEn = 7,
	unlockStage = 4,
	episodeId = 3,
	activityId = 1,
	layer = 2
}
local primaryKey = {
	"activityId",
	"layer"
}
local mlStringKey = {
	name = 1
}

function lua_activity123_trial.onLoad(json)
	lua_activity123_trial.configList, lua_activity123_trial.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity123_trial
