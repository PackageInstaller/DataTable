-- chunkname: @modules/configs/excel2json/lua_activity168_event.lua

module("modules.configs.excel2json.lua_activity168_event", package.seeall)

local lua_activity168_event = {}
local fields = {
	optionIds = 4,
	eventId = 2,
	activityId = 1,
	name = 3
}
local primaryKey = {
	"activityId",
	"eventId"
}
local mlStringKey = {
	name = 1
}

function lua_activity168_event.onLoad(json)
	lua_activity168_event.configList, lua_activity168_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity168_event
