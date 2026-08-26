-- chunkname: @modules/configs/excel2json/lua_push_box_activity.lua

module("modules.configs.excel2json.lua_push_box_activity", package.seeall)

local lua_push_box_activity = {}
local fields = {
	stageId = 2,
	episodeIds = 3,
	activityId = 1,
	openDay = 4
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {}

function lua_push_box_activity.onLoad(json)
	lua_push_box_activity.configList, lua_push_box_activity.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_push_box_activity
