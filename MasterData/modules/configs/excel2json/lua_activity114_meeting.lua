-- chunkname: @modules/configs/excel2json/lua_activity114_meeting.lua

module("modules.configs.excel2json.lua_activity114_meeting", package.seeall)

local lua_activity114_meeting = {}
local fields = {
	nameEng = 4,
	name = 3,
	banTurn = 10,
	tag = 11,
	events = 7,
	condition = 8,
	character = 6,
	id = 2,
	signature = 5,
	activityId = 1,
	des = 9
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	des = 2,
	name = 1
}

function lua_activity114_meeting.onLoad(json)
	lua_activity114_meeting.configList, lua_activity114_meeting.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_meeting
