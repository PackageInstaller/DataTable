-- chunkname: @modules/configs/excel2json/lua_activity231_event.lua

module("modules.configs.excel2json.lua_activity231_event", package.seeall)

local lua_activity231_event = {}
local fields = {
	effect = 7,
	name = 4,
	button = 6,
	weight = 8,
	id = 2,
	unlockCondition = 3,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1,
	button = 3,
	desc = 2
}

function lua_activity231_event.onLoad(json)
	lua_activity231_event.configList, lua_activity231_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_event
