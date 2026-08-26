-- chunkname: @modules/configs/excel2json/lua_linkage_activity.lua

module("modules.configs.excel2json.lua_linkage_activity", package.seeall)

local lua_linkage_activity = {}
local fields = {
	item1 = 7,
	activityId = 1,
	showOnlineTime = 2,
	desc1 = 9,
	item2 = 8,
	showOfflineTime = 3,
	res_video2 = 5,
	desc2 = 10,
	res_video1 = 4,
	systemJumpCode = 6
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {
	desc2 = 2,
	desc1 = 1
}

function lua_linkage_activity.onLoad(json)
	lua_linkage_activity.configList, lua_linkage_activity.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_linkage_activity
