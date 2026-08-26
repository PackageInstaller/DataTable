-- chunkname: @modules/configs/excel2json/lua_activity114_round.lua

module("modules.configs.excel2json.lua_activity114_round", package.seeall)

local lua_activity114_round = {}
local fields = {
	desc = 5,
	storyId = 10,
	isSkip = 12,
	type = 4,
	eventId = 8,
	transition = 11,
	day = 2,
	banButton2 = 7,
	banButton1 = 6,
	id = 3,
	activityId = 1,
	preStoryId = 9
}
local primaryKey = {
	"activityId",
	"day",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity114_round.onLoad(json)
	lua_activity114_round.configList, lua_activity114_round.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_round
