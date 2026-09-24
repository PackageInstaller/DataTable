-- chunkname: @modules/configs/excel2json/lua_activity245_turntable.lua

module("modules.configs.excel2json.lua_activity245_turntable", package.seeall)

local lua_activity245_turntable = {}
local fields = {
	isSp = 8,
	isFirstBigReward = 7,
	weight = 3,
	reward = 4,
	spPanelTitle = 13,
	spPanelIcon = 11,
	spMainTitle = 12,
	mainShowIcon = 9,
	spMainIcon = 10,
	availableTime = 5,
	id = 1,
	isBigReward = 6,
	activityId = 2,
	sort = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity245_turntable.onLoad(json)
	lua_activity245_turntable.configList, lua_activity245_turntable.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity245_turntable
