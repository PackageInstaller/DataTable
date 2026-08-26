-- chunkname: @modules/configs/excel2json/lua_activity236.lua

module("modules.configs.excel2json.lua_activity236", package.seeall)

local lua_activity236 = {}
local fields = {
	reward = 4,
	cost = 3,
	showVideo = 7,
	showWindow = 6,
	id = 1,
	activityId = 2,
	showReward = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	showVideo = 3,
	showWindow = 2,
	showReward = 1
}

function lua_activity236.onLoad(json)
	lua_activity236.configList, lua_activity236.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity236
