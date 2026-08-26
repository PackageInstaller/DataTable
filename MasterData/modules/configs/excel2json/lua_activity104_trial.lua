-- chunkname: @modules/configs/excel2json/lua_activity104_trial.lua

module("modules.configs.excel2json.lua_activity104_trial", package.seeall)

local lua_activity104_trial = {}
local fields = {
	equipId = 8,
	firstPassEquipIds = 5,
	name = 6,
	nameEn = 7,
	episodeId = 3,
	unlockLayer = 4,
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

function lua_activity104_trial.onLoad(json)
	lua_activity104_trial.configList, lua_activity104_trial.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity104_trial
