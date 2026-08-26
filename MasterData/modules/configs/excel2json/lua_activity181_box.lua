-- chunkname: @modules/configs/excel2json/lua_activity181_box.lua

module("modules.configs.excel2json.lua_activity181_box", package.seeall)

local lua_activity181_box = {}
local fields = {
	showOnlineTime = 2,
	bonus = 5,
	obtainStart = 7,
	obtainTimes = 9,
	showOfflineTime = 3,
	obtainType = 6,
	totalBox = 4,
	activityId = 1,
	obtainEnd = 8
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity181_box.onLoad(json)
	lua_activity181_box.configList, lua_activity181_box.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity181_box
