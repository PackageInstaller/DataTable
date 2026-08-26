-- chunkname: @modules/configs/excel2json/lua_activity191_fight_event.lua

module("modules.configs.excel2json.lua_activity191_fight_event", package.seeall)

local lua_activity191_fight_event = {}
local fields = {
	fightLevel = 12,
	autoRewardView = 9,
	bloodAward = 10,
	type = 3,
	skinId = 6,
	title = 4,
	offset = 7,
	episodeId = 5,
	rewardView = 8,
	autoAward = 11,
	id = 1,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}

function lua_activity191_fight_event.onLoad(json)
	lua_activity191_fight_event.configList, lua_activity191_fight_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_fight_event
